//Created for macgourmet  (17.06.2020 )

import UIKit


let appStrings = AppStrings()

struct AppStrings {
    
    
    /// 
    func recipesCounter(_ count : Int) -> String {
        return NSLocalizedString("\(count) recipes", comment: "recipesVC Label")
    }
    func foodTitle(_ count : Int) -> String {
        NSLocalizedString("Food (\(count))", comment: "Notes: Food - Segmented Control")
    }
    
    func wineTitle(_ count : Int) -> String {
        NSLocalizedString("Wine (\(count))", comment: "Notes: Wine - Segmented Control")
    }
    
    /// Shopping Tab
    let shoppingEditSubTitle = NSLocalizedString("items", comment: "ShoppingVC Edit title")
    let shopingCellSubTitle = NSLocalizedString("Items bought:", comment: "ShoppingVC cell sub title")
    
    func shoppingCounter(_ count : Int) -> String {
        return NSLocalizedString("\(count) lists", comment: "ShoppingVC Label")
    }
    func addRecipesButton(_ c: Int) -> String {
        NSLocalizedString("Add \(c) recipes to Shopping List", comment: "AddRecipesShoppingViewController Add Button")
    }
    
    
    /// Add/Edit Recipe
    let addRecipe = NSLocalizedString("Add recipe", comment: "Add Recipe Label(TOP)")
    let editRecipe = NSLocalizedString("Edit recipe", comment: "Edit Recipe Label(TOP)")
}
