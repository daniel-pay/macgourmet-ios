//Created for macgourmet  (15.06.2020 )

import UIKit

/*
 Fill: Solid
 rgba 1.0, 1.0, 1.0, 1.0
 Effect: Drop Shadow
 Radius: 10 pt
 Offset: 0 pt, 2 pt
 rgba 0.6, 0.6, 0.6, 0.3
 */
 


enum DevOrientation {
    case portrait, landscape
}


class mainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let slider = UIView(frame: .zero)
    
    private var sliderWidth: CGFloat = 10 // default
    private var devOrientation: DevOrientation = .portrait
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        setupTabBar()
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func rotated() {
        devOrientation = UIDevice.current.orientation.isLandscape ? .landscape : .portrait
    }
    
     
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         
        moveSliderTo(position: selectedIndex+1, animated: false)
    }
    
  
    
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        var pageIndex = 1
        
        switch viewController {
        case is RecipesViewController:
            pageIndex = 1
        case is NotesViewController:
            pageIndex = 2
        case is ShoppingListsViewController:
            pageIndex = 3
        case is MoreViewController:
            pageIndex = 4
        default:
            pageIndex = 1
        }
        
        moveSliderTo(position: pageIndex)
        
        return true
    }

    private func setupTabBar() {
        
        delegate = self
        
        /// offset
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        
        //removes the topline for @iOS 13.0
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        //tabBar.standardAppearance = appearance;
        
        
        
        // removes the topline for iOS 12.0 and earlier
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        
        tabBar.backgroundColor = .white
          
        //Shadow
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.shadowColor = tabBarAppearance.shadowColor.cgColor
        tabBar.layer.shadowOpacity = 1
         
        slider.backgroundColor = tabBarAppearance.sliderColor
        slider.layer.cornerRadius = tabBarAppearance.sliderRadius
        
        self.tabBar.addSubview(slider)
    }
    
    
    private func moveSliderTo(position: Int = 1, animated: Bool = true) {
         
        let tabBarFrame = tabBar.frame
        var sliderX: CGFloat = 0
        
        tabBar.layoutSubviews()
        
        //if devOrientation == .landscape {sliderWidth = 50} else {sliderWidth = 10}
        
        if let selected = tabBar.items?[position-1].value(forKey: "view") as? UIView {
             
            sliderX = selected.frame.midX - sliderWidth/2
             
        }
        
        
        let sliderY = tabBarFrame.height - tabBar.safeAreaInsets.bottom - 3 - 2 // todo: -2 ?
          
        if animated {
            
            UIView.animate(withDuration: 0.3) {
                self.slider.frame = CGRect(x:  sliderX  , y: sliderY, width: self.sliderWidth, height: 3)
            }
            
        } else {
           self.slider.frame = CGRect(x:  sliderX  , y: sliderY, width: sliderWidth, height: 3)
        }
    }
}

class TabBar51h: UITabBar {
     
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        /// 101 - 67 = 34 ?
        
        
        //guard let window = UIApplication.shared.keyWindow else {
        
        guard
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
        else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        
        if #available(iOS 11.0, *) {
            sizeThatFits.height = keyWindow.safeAreaInsets.bottom + 51
        } else {
            // Fallback on earlier versions
            sizeThatFits.height = 51
        }
        return sizeThatFits
    }
}
