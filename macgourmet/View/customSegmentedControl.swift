//Created for macgourmet  (17.06.2020 )

import UIKit

class customSegmentedControl: UISegmentedControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //roundCorners(radius: frame.height / 2)

//        if #available(iOS 13.0, *) {
//            selectedSegmentTintColor = .clear
//        } else {
//            tintColor = .clear
//        }
         
//        for (index, subview) in subviews.enumerated() {
//
//            subviews[index].layer.cornerRadius = 20
//
//        }
    }

 
    
    private func setupUI() {
        let foregroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9843137255, alpha: 1)
         
        setTitleTextAttributes([.font : commonAppearance.SFProTextBold.withSize(14)], for: .selected)
        setTitleTextAttributes([.font : commonAppearance.SFProTextRegular.withSize(14)], for: .normal)
        
         if #available(iOS 13.0, *) {
            let bgClear = UIImage(color: .clear, size: CGSize(width: 1, height: 1))
            let bgSelected = UIImage(color: foregroundColor, size: CGSize(width: 1, height: 1))
            let DividerImage = UIImage(color: .clear, size: CGSize(width: 1, height: 1))
            
            
            setBackgroundImage(bgClear, for: .normal, barMetrics: .default)
            setBackgroundImage(bgSelected, for: .selected, barMetrics: .default)
            
            setDividerImage(DividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            
         } else {
            tintColor = foregroundColor
         }
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}

//extension UISegmentedControl {
//    /// Tint color doesn't have any effect on iOS 13.
//    func ensureiOS12Style() {
//        if #available(iOS 13, *) {
//            let tintColorImage = UIImage(color: tintColor)
//            // Must set the background image for normal to something (even clear) else the rest won't work
//            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
//            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
//            setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
//            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
//            setTitleTextAttributes([.foregroundColor: tintColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)], for: .normal)
//            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
//            layer.borderWidth = 1
//            layer.borderColor = tintColor.cgColor
//        }
//    }
//}
