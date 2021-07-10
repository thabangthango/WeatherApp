import UIKit
import CoreLocation

class WeatherForecastTableViewController: UITableViewController {
    private lazy var locationManager = CLLocationManager()
    private let viewModel: WeatherForcastViewModel = {
        let dataProvider = WeatherService()
        return WeatherForcastViewModel(dataProvider: dataProvider)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        configureTableView()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: String(describing: WeatherForecastTableViewCell.self), bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: WeatherForecastTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        let statusBarHeight =  UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height
        tableView.contentInset = UIEdgeInsets(top: -(statusBarHeight ?? 0), left: 0, bottom: 0, right: 0)
    }
    
    private func configureSummaryView(_ headerView: WeatherSummaryView) {
        let currentWeather = viewModel.currentWeather
        headerView.configure(minClimate: currentWeather?.minTemp)
        headerView.configure(maxClimate: currentWeather?.maxTemp)
        headerView.configure(currentClimate: currentWeather?.temp)
        headerView.configure(backgroundImage: currentWeather?.type?.backgroundImage)
        headerView.configure(climateDescription: currentWeather?.type?.summary)
    }
    
    private func configureTableHeaderView(with headerView: WeatherSummaryView) {
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        tableView.tableHeaderView = headerView
    }
    
    private func updateTableViewState() {
        let headerView = WeatherSummaryView.loadViewFromNib(owner: self)
        configureSummaryView(headerView)
        configureTableHeaderView(with: headerView)
        tableView.backgroundColor = viewModel.currentWeather?.type?.backgroundColor
        tableView.reloadData()
    }
    
    private func performRequestIfNeed(for status: CLAuthorizationStatus) {
        guard isLocationGranted(for: status), let coordinate = locationManager.location?.coordinate else {
            locationManager.requestWhenInUseAuthorization()
            if status == .denied {
                showOkAlert(title: .locationDeniedTitle, message: .locationDeniedMessage)
            }
            return
        }
        performRequest(with: coordinate)
    }
    
    private func performRequest(with coordinate: CLLocationCoordinate2D) {
        showLoading()
        viewModel.fetchWeatherInfo(with: coordinate) { [weak self] error in
            self?.hideLoading()
            guard error == nil, let self = self else {
                self?.showErrorAlert(retry: { self?.performRequest(with: coordinate) })
                return
            }
            self.updateTableViewState()
        }
    }
}

// MARK: - Table view data source
extension WeatherForecastTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDays()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastTableViewCell.reuseIdentifier) as? WeatherForecastTableViewCell,
            let weather = viewModel.weather(forDay: indexPath.row)
        else {
            return UITableViewCell()
        }
        
        cell.configure(title: weather.day)
        cell.configure(climate: weather.temp)
        cell.configure(image: weather.type?.icon)
        cell.hideSeperator()
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherForecastTableViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        performRequestIfNeed(for: status)
    }
    
    private func isLocationGranted(for status: CLAuthorizationStatus) -> Bool {
        return status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways
    }
}

// MARK: - Strings
fileprivate extension String {
    static let locationDeniedTitle = NSLocalizedString("LOCATION_DENIED_TITLE", comment: "")
    static let locationDeniedMessage = NSLocalizedString("LOCATION_DENIED_MESSAGE", comment: "")
}
