//Created for macgourmet  (22.07.2020 )

import UIKit
import GRDB

let macgourmentDB = MacgourmentDB.shared

class MacgourmentDB {
 
    static let shared: MacgourmentDB = MacgourmentDB()
    
    fileprivate let fileManager = FileManager.default
    fileprivate let defaultDatabaseType = ".mgdb"
    
    enum DatabaseFiles: String, CaseIterable {
        case MacGourmet
        //case Mealplan
        case MyNutrition
        case Cookbook
    }
     
    func databaseQueue() -> DatabaseQueue? {
        let patch = getFilePatch(for: .MacGourmet)
         
        do {
            let db = try DatabaseQueue(path: patch.dbPath)
            return db 
             
        }catch let error as NSError {
            print("Error occurred, here are the details:\n \(error)")
            return nil
        }
        
        
    }
    
    
    //MARK: - Copy DataBase files
    func initDatabaseFiles() {
        for dbName in DatabaseFiles.allCases {
            copyDataBase(with: dbName)
        }
    }
    
    //MARK: - Get file Patch (bundle, documents)
    private func getFilePatch(for name: DatabaseFiles) -> (BundlePath: String?, dbPath: String) {
        guard
            let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as NSString?
            
            else {
                print("📖 DB: ❌ can't define doumentDirectoryPath !")
                return (nil, "nil")
        }
         
        let pathBundle = Bundle.main.path(forResource: name.rawValue, ofType: defaultDatabaseType)
        let dbPath = doumentDirectoryPath.appendingPathComponent(name.rawValue+defaultDatabaseType)
        
        return (pathBundle, dbPath)
    }
    
    //MARK: - Copy DataBase file (if needed)
    func copyDataBase(with name: DatabaseFiles) {
        
        let patch = getFilePatch(for: name)
        
        let fileExists = fileManager.fileExists(atPath: patch.dbPath)
        print("📖 DB: \(fileExists ? "File \(name.rawValue+defaultDatabaseType) exist" : "Copy file to \(patch.dbPath)")")
        if fileExists { return }
        
        do{
            try fileManager.copyItem(atPath: patch.BundlePath!, toPath: patch.dbPath)
        }catch let error as NSError {
            print("Error occurred, here are the details:\n \(error)")
        }
    }
}
