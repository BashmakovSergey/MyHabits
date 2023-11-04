import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}

public extension UIStackView {
    func addArrangedSubviews(_ arrangedSubview: UIView...) {
        for i in arrangedSubview {
            self.addArrangedSubview(i)
        }
    }
}
