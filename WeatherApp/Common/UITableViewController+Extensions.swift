import UIKit

// MARK: - Loading view
public extension UITableViewController {
    private var loaderViewTag: Int { 222 }
    
    func showLoading() {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.tag = loaderViewTag
        indicatorView.startAnimating()
        indicatorView.center = self.view.center
        indicatorView.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        self.view.addSubview(indicatorView)
    }
    
    func hideLoading() {
        let indicatorView = self.view.viewWithTag(loaderViewTag) as? UIActivityIndicatorView
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
    }
}

// MARK: - Alerts
public extension UITableViewController {
    
    func showOkAlert(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: .okTitle, style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    func showErrorAlert(retry: @escaping () -> Void) {
        let controller = UIAlertController(title: .errorAlertTitle, message: .errorAlertMessage, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: .tryAgainTitle, style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: .cancelTitle, style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}

fileprivate extension String {
    static let errorAlertTitle = NSLocalizedString("ERROR_ALERT_TITLE", comment: "")
    static let errorAlertMessage = NSLocalizedString("ERROR_ALERT_MESSAGE", comment: "")
    static let cancelTitle = NSLocalizedString("CANCEL_TEXT", comment: "")
    static let tryAgainTitle = NSLocalizedString("PLEASE_TRY_AGAIN_TITLE", comment: "")
    static let okTitle = NSLocalizedString("OK_TEXT", comment: "")
}
