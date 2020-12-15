//Created for macgourmet  (22.07.2020 )

import UIKit
//import SQLite
import GRDB
  
 
class RecipesManager {
    
    private static var sharedRecipesManager: RecipesManager = {
        let manager = RecipesManager()

        // Configuration
        // ...

        return manager
    }()
    
    func getAll() -> [Recipe] {
        guard
            let dbQueue = macgourmentDB.databaseQueue()
             
        else {return []}
          
            do {
                let result = try dbQueue.read { db in
                       
                    return try Recipe.fetchAll(db, Recipe.including(all: Recipe.dirs))
                        //Recipe.including(optional: Recipe.dirs).asRequest(of: Recipe.self).fetchAll(db)
                        //Recipe.fetchAll(db, Recipe.including(all: Recipe.dirs))
                    
                    
                    
                    
                     //Recipe.fetchAll(db, Recipe.including(all: Recipe.dirs))
                }
                return result
            } catch let error as NSError {
                print("Error occurred, here are the details:\n \(error)")
                return []
            }
            
            
           
//            do {
//                 let directions = directionTableName.alias("dir")
//
//                 let query = tableName
//                    .select(Expression<String>("name"))
//                    .join(directions, on: directions[recipeID] == tableName[recipeID])
//
//
//                let query1 = tableName
//                    .join(directionTableName, on: tableName[id] == directionTableName[id])
//
//                let loadedRecipes: [Recipe] = try db.prepare(query1).map { row in
//
//                    return try row.decode()
//                }
//
//
//    //            let loadedRecipes: [Recipe] = try db.prepare(query).map { row in
//    //
//    //                return try row.decode()
//    //            }
//
//                return loadedRecipes
//
//            }
//            catch let error as NSError {
//
//                print("Error occurred, here are the details:\n \(error)")
//                return []
//            }
        }
    
    
//    func getAll() -> [Recipe] {
//        guard let db = macgourmentDB.connection() else {return []}
//        #if DEBUG
//            db.trace { print($0) }
//        #endif
//        let recipeID = Expression<Int64>("recipe_id")
//        let id = Expression<Int64>("recipe_id")
////        let email = Expression<String>("email")
////        let balance = Expression<Double>("balance")
////        let verified = Expression<Bool>("verified")
//
//        do {
//             let directions = directionTableName.alias("dir")
//
//             let query = tableName
//                .select(Expression<String>("name"))
//                .join(directions, on: directions[recipeID] == tableName[recipeID])
//             // SELECT * FROM "users"
//             // INNER JOIN ("users") AS "managers" ON ("managers"."id" = "users"."manager_id")
//
//
//            let query1 = tableName
//                .join(directionTableName, on: tableName[id] == directionTableName[id])
//
//            let loadedRecipes: [Recipe] = try db.prepare(query1).map { row in
//
//                return try row.decode()
//            }
//
//
////            let loadedRecipes: [Recipe] = try db.prepare(query).map { row in
////
////                return try row.decode()
////            }
//
//            return loadedRecipes
//
//        }
//        catch let error as NSError {
//
//            print("Error occurred, here are the details:\n \(error)")
//            return []
//        }
//    }
    
    
    
    
    
    
    
    
    // MARK: - Accessors
    class func shared() -> RecipesManager {
        return sharedRecipesManager
    }
}
