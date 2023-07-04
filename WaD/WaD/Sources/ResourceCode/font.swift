import UIKit

extension UIFont {
    enum Family: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }

    static func notoSansFont(ofSize: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "NotoSansKR-\(family.rawValue)", size: ofSize)!
    }
}
