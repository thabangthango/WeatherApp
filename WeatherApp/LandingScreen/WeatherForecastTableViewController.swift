import UIKit

class WeatherForecastTableViewController: UITableViewController {
    private let viewModel: WeatherForcastViewModel = {
        let dataProvider = WeatherService()
        return WeatherForcastViewModel(dataProvider: dataProvider)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        performRequest()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: String(describing: WeatherForecastTableViewCell.self), bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: WeatherForecastTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func configureSummaryView(_ headerView: WeatherSummaryView) {
        let currentWeather = viewModel.currentWeather
        headerView.configure(minClimate: currentWeather?.minTemp)
        headerView.configure(maxClimate: currentWeather?.maxTemp)
        headerView.configure(currentClimate: currentWeather?.temp)
        headerView.configure(backgroundImage: currentWeather?.type?.backgroundImage)
        headerView.configure(climateDescription: currentWeather?.type?.rawValue ?? "")
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
    
    private func performRequest() {
        showLoading()
        viewModel.fetchWeatherInfo(forCity: "London") { [weak self] error in
            self?.hideLoading()
            guard error == nil, let self = self else {
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
