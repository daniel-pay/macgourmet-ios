//Created for macgourmet  (15.06.2020 )


import UIKit

let storyBoard = UIStoryboard(name: "Main", bundle: nil)

let tabBarAppearance = AppAppearance.TabBarAppearance()
let commonAppearance = AppAppearance.CommonAppearance()

struct AppAppearance {
    
    struct CommonAppearance {
        let SFProTextRegular = UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
        let SFProTextBold = UIFont(name: "SFProText-Bold", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
        
        /// SF-Pro-Text-Medium.ttf
        let SFProTextMedium = UIFont(name: "SFProText-Medium", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
        
        /// SF-Pro-Text-Heavy.ttf
        let SFProTextHeavy = UIFont(name: "SFProText-Heavy", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)

        /// SF-Pro-Text-Semibold.ttf
        let SFProTextSemibold = UIFont(name: "SFProText-Semibold", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
        
    }
    struct TabBarAppearance {
        let shadowColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.3)
        let sliderColor = UIColor(red: 1.0, green: 0.48, blue: 0.0, alpha: 1.0)
        let sliderRadius: CGFloat = 2.0
        
    }
    
//    struct SearchFieldAppearance {
//        /// searchField
//        let borderColor = #colorLiteral(red: 0.7882352941, green: 0.8156862745, blue: 0.8509803922, alpha: 1).cgColor
//        let borderWidth: CGFloat = 1
//        let placeholderColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
//        let minQueryLength = 1
//        /// cells
//        let defaultCellFont = UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0)
//        let cellHeaderFont =  UIFont(name: "HelveticaNeueMedium", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
//        let headerTextColor = #colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)
//
//    }
}
