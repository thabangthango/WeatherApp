import UIKit

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
