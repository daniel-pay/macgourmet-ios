//Created for macgourmet  (16.06.2020 )

import UIKit


let debugData = DebugData()
let userManager = UserManager.shared()

 
struct UserAccount {
    var deletedList: [Recipe] = []
    var recipesList : [Recipe] = DebugData().recipesList
    var notesFoodList: [CookingNotes] = DebugData().notesFood
    var notesWineList: [WineNotes] = DebugData().wineNotes
    var shoppingList: [ShoppingList] = DebugData().shoppingList
}






struct DebugData {
    
    
    let recipesList: [Recipe] = [
        
    ]
    
//    let recipesList: [Recipe] = [
//        Recipe(
//            id: "1",
//            title: "Apricot Chicken",
//            source: "bestrecipes.com",
//            img: UIImage(named: "Image01")!,
//            rating: 4.0,
//
//            ingredients: ["16 chicken thighs, with bones and skin","2 ½ cups chicken broth", "1 ½ tablespoons grated ginger", "5 cloves large garlic, crushed", "2⁄3 cup sweet cooking rice wine", "3 teaspoons Szechuan spicy stir fry sauce", "2 tablespoons soy sauce", "2 tablespoons virgin olive oil", "​3⁄4 lbs. soft dried apricots", "1 cup cashew pieces"],
//
//            directions: [
//
//                1 : "In medium bowl, mix together chicken broth, ginger, garlic, rice wine, Szechuan sauce and soy sauce",
//                2 : "In large frypan over medium heat place olive oil. Add chicken and cook about 10 minutes",
//                3 : "Remove chicken, discard oil and return chicken to pan",
//                4 : "Pour chicken broth mixture over chicken thighs and bring to boil. Add apricots, lower heat to medium, cover and cook for 15 minutes. Then uncover, reduce heat and continue to cook about 1 hour, turning chicken occasionally, until sauce thickens.",
//                5 : "Remove chicken to serving dish and sprinkle with cashews.",
//            ],
//
//            notes: "Make sure you have a large frying pan. Also, don’t cook at very high temperature.",
//
//            equipment: [ "Large frypan", "Medium bowl", "Oven"],
//            nutrition: [
//            "350 calories",
//            "22 g fat",
//            "12 g carbohydrates",
//            "2 g sugar",
//            "65 g protein",
//            ],
//            servings: 8,
//
//            additionalDetails: AdditionalDetails(
//                yield: "24",
//                preparationTime: 140,
//                difficulty: 3,
//                sourceInfo: "Best of 2020",
//                course: "Main",
//                category: [],
//                //category: ["Chicken", "Healthy", "Main"],
//                keywords: ["chicken", "apricot", "meat", "best"])
//
//
//
//        )
//    ]
    
    
    let shoppingList = [
    ShoppingList(
        id: "1",
        name: "Apricot Chicken",
        items: [ShoppingItem(id: "1", name: "Cashew pieces", amount: 1, units: "(3/8 cups)", bought: false)]),
    
    ShoppingList(
        id: "2",
        name: "Bangkok Beef & Basil",
        items: [
                    ShoppingItem(id: "2", name: "Cashew pieces", amount: 1, units: "(3/8 cups)", bought: true),
                    ShoppingItem(id: "3", name: "Cashew pieces", amount: 1, units: "(3/8 cups)", bought: false)
        ]
        )
    ]
    
    
    let notesFood = [
        CookingNotes(name: "Crockpot Cooking Tips & Tricks", source: "TipNut.com", text: RandomData().loremText, keywords: ["key1","key2"], image: UIImage(named: "Cooking1")!),
        CookingNotes(name: "How to butterfly a Chicken", source: "MacGourmet.com", text: RandomData().loremText, keywords: ["key1","key2"]),
        CookingNotes(name: "10 Quick Tips for Stir Fry Cooki...", source: "TipNut.com", text: RandomData().loremText, keywords: ["key1","key2"], image: UIImage(named: "Cooking2")!),
        CookingNotes(name: "5 Simple Tips for Cooking Perf...", source: "TipNut.com", text: RandomData().loremText, keywords: ["key1","key2"], image: UIImage(named: "Cooking3")!),
            
    ]
    
    
    
    
    let wineNotes: [WineNotes] = [
        WineNotes(
            name: "Cabernet Sauvignon",
            winery: "J. Garcia",
            image: UIImage(named: "Wine1")!,
            isFavorite: false,
            rating: 3.0,
            region: "California",
            subRegion: "Sonoma County",
            year: 2005,
            style: "Light",
            keywords: ["cabernet", "garcia", "white"]
            
            
            ),
        
        
        
        WineNotes(
            name: "Chardonnay",
            winery: "Bernardus",
            image: UIImage(named: "Wine2")!,
            isFavorite: true,
            rating: 5.0,
            region: "Blackwood",
            subRegion: "Sonoma County",
            year: 1990,
            style: "Light",
            keywords: ["Light", "rernardus", "white"]
            
            )
    ]
                                 
         
    
    
    let equipment = [
        selectableData(id: 0, name: "Angel food cake pan"),
        selectableData(id: 0, name: "Asparagus pot"),
        selectableData(id: 0, name: "Baking spatula"),
        selectableData(id: 0, name: "Balloon whisk"),
        selectableData(id: 0, name: "Blender"),
        selectableData(id: 0, name: "Braiser pan"),
        selectableData(id: 0, name: "Bread Machine"),
        selectableData(id: 0, name: "Broiler"),
        selectableData(id: 0, name: "Brownie pan"),
        selectableData(id: 0, name: "Buffet casserole"),
        selectableData(id: 0, name: "Bundt cake pan"),
        selectableData(id: 0, name: "Casserole"),
        selectableData(id: 0, name: "Cassoulet"),
        selectableData(id: 0, name: "Chafing dish"),
        selectableData(id: 0, name: "Charcoal Grill"),
       
       ]
    
    let course = [
        selectableData(id: 0, name: "Appetizer"),
        selectableData(id: 0, name: "Cheese"),
        selectableData(id: 0, name: "Dessert"),
        selectableData(id: 0, name: "Fruit"),
        selectableData(id: 0, name: "Main"),
        selectableData(id: 0, name: "Salad"),
        selectableData(id: 0, name: "Snack"),
        selectableData(id: 0, name: "Vegatable"),
    ]
    
    let category = [
         selectableData(id: 0, name: "30 Minute"),
         selectableData(id: 0, name: "Appetizer"),
         selectableData(id: 0, name: "Baked Goods"),
         selectableData(id: 0, name: "Basic"),
         selectableData(id: 0, name: "Beef"),
         selectableData(id: 0, name: "Beverages"),
         selectableData(id: 0, name: "Breads"),
         selectableData(id: 0, name: "Breakfast"),
         selectableData(id: 0, name: "Brownies"),
         selectableData(id: 0, name: "Brunch"),
         selectableData(id: 0, name: "Burgers"),
    ] 
}



struct RandomData {
        let loremText = """
        Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.


        Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.


"""
}


let dataList: [moreTableData] = [
    moreTableData("Sync account", "Account is currently not synced", "sync-icon"),
    moreTableData("Font size", "Medium", "font-icon"),
    moreTableData("Import recipes", "Import sample recipes from the internet", "plus-more-icon"),
    moreTableData("Deleted recipes", "List of deleted recipes", "trash-icon"),
    moreTableData("Reset account", "Reset your database for a clean sync", "reset-icon"),
]
 
