//Created for macgourmet  (19.06.2020 )

import UIKit

class UserManager {

    // MARK: - Properties

    private static var sharedUserManager: UserManager = {
        let userManager = UserManager()

        // Configuration
        // ...

        return userManager
    }()

    // MARK: -
    /// set init data for demo
    private var data: UserAccount = UserAccount()
 
    var userFontSize : fontSizeSettings = .medium
    
    
    
    // Initialization
    private init( ) {
     
    }

    
    // Methods
    func getRecipes() -> [Recipe] {
         return data.recipesList
    }
    
    func getShoppingList() -> [ShoppingList] {
        return data.shoppingList
    }
    
    
    func addNewShoppingList(list: ShoppingList) {
        self.data.shoppingList.append(list)
    }
    
    func modifyShoolingListItem(_ list: ShoppingList) {
//         
        
    }
    
    
    
    func removeRecipe(_ index: Int) {
        data.deletedList.append(data.recipesList[index])
        data.recipesList.remove(at: index)
    }
    
    func getDeletedRecipesList() -> [Recipe] {
        return data.deletedList
    }
    
    func getMoreItems() -> [moreTableData] {
        return dataList
    }
    
    
    
    // MARK: - Accessors
    class func shared() -> UserManager {
        return sharedUserManager
    }
}
