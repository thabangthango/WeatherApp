import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyling()
    }

    private func configureStyling() {
        self.backgroundColor = .clear
        configureTitleLabelStyling()
        configureClimateLabelStyling()
    }

    private func configureClimateLabelStyling() {
        climateLabel.textColor = UIColor.white
        climateLabel.numberOfLines = 1
        climateLabel.font = .systemFont(ofSize: 15)
    }

    private func configureTitleLabelStyling() {
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 15)
    }

    func configure(title: String?) {
        titleLabel.text = title
    }

    func configure(climate: String?) {
        climateLabel.text = climate
    }

    func configure(image: UIImage?) {
        weatherTypeImageView.image = image
    }
}
