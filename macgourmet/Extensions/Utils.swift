//Created for macgourmet  (16.06.2020 )

import UIKit
 
class Utils {
     
    /// will display installed fonts
    func displayFonts() {
        for family: String in UIFont.familyNames
        {
             print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
             {
                 print("== \(names)")
             }
        }
    }
}
