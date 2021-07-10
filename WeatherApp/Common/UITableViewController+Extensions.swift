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
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    func showErrorAlert(retry: @escaping () -> Void) {
        let controller = UIAlertController(title: "Oops", message: "Something went wrong", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        controller.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}
