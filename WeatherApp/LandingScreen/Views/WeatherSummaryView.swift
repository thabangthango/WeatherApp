import UIKit

class WeatherSummaryView: UIView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var maxClimateLabel: UILabel!
    @IBOutlet weak var currentClimateLabel: UILabel!
    @IBOutlet weak var minClimateLabel: UILabel!
    @IBOutlet weak var backgroundImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var boldCurrentClimateLabel: UILabel!
    @IBOutlet weak var climateDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyling()
    }

    private func configureStyling() {
        configureMinClimateLabelStyling()
        configureCurrentClimateLabelStyling()
        configureMaxClimateLabelStyling()
        configureBoldCurrentClimateLabel()
        configureClimateDescriptionLabel()
        backgroundImageHeightConstraint.constant = UIScreen.main.bounds.height * 0.44
    }

    private func configureMaxClimateLabelStyling() {
        maxClimateLabel.textColor = .white
        maxClimateLabel.numberOfLines = 2
        maxClimateLabel.textAlignment = .center
    }

    private func configureCurrentClimateLabelStyling() {
        currentClimateLabel.textColor = .white
        currentClimateLabel.numberOfLines = 2
        currentClimateLabel.textAlignment = .center
    }

    private func configureMinClimateLabelStyling() {
        minClimateLabel.textColor = .white
        minClimateLabel.numberOfLines = 2
        minClimateLabel.textAlignment = .center
    }

    private func configureBoldCurrentClimateLabel() {
        boldCurrentClimateLabel.textColor = .white
        boldCurrentClimateLabel.textAlignment = .center
        boldCurrentClimateLabel.numberOfLines = 0
        boldCurrentClimateLabel.font = .boldSystemFont(ofSize: 60)
    }

    private func configureClimateDescriptionLabel() {
        climateDescriptionLabel.textColor = .white
        climateDescriptionLabel.numberOfLines = 0
        climateDescriptionLabel.font = .systemFont(ofSize: 35, weight: .regular)
    }

    func configure(minClimate: String?) {
        minClimateLabel.text = "\(minClimate!) \nmin"
    }

    func configure(maxClimate: String?) {
        maxClimateLabel.text = "\(maxClimate!) \nmax"
    }

    func configure(currentClimate: String?) {
        currentClimateLabel.text = "\(currentClimate!) \n current"
        boldCurrentClimateLabel.text = currentClimate
    }

    func configure(climateDescription: String?) {
        climateDescriptionLabel.text = climateDescription
    }

    func configure(backgroundImage: UIImage?) {
        backgroundImageView.image = backgroundImage
    }

    class public func loadViewFromNib(owner: Any) -> WeatherSummaryView {
        let nibName = String(describing: WeatherSummaryView.self)
        guard let headerView = Bundle(for: WeatherSummaryView.self)
                .loadNibNamed(nibName, owner: owner, options: nil)?
                .last as? WeatherSummaryView
        else {
            return WeatherSummaryView()
        }
        return headerView
    }
}
