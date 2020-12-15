//Created for macgourmet  (16.06.2020 )

import UIKit
import GRDB

enum fontSizeSettings: CaseIterable {
    case small, medium, large
}

enum AditionalDetailsType {
    case keywords
}

struct Direction: TableRecord {
    static let databaseTableName = "direction"
    
    let id: Int
    let text: String
    let order: Int
}

  
extension Direction: FetchableRecord, EncodableRecord {
    func encode(to container: inout PersistenceContainer) {
        container["direction_id"] = id
        container["directions_text"] = text
        container["sort_order"] = order
    }
    
    init(row: Row) {
        id = row["direction_id"]
        text = row["directions_text"]
        order = row["sort_order"]
    }
}

extension Direction {
//    static let foreignKey = ForeignKey(["direction_id"], to: ["recipe_id"])
//
//    static let recipe = belongsTo(Recipe.self, using: foreignKey)
//    var recipe: QueryInterfaceRequest<Recipe> {
//        request(for: Direction.recipe)
//    }
}






struct Recipe: TableRecord, EncodableRecord {
    func encode(to container: inout PersistenceContainer) {
        //container["id"] = id
        //container["name"] = title
    }
    
    static let databaseTableName = "recipe"
    
    //decoded
    let id: Int
    let title: String
    let source: String
    let rating: Float
    var servings: Int
    var alreadyCooked: Bool
    
    ///Aditional info
    let difficulty: Int
    let yield: String
    var keywords: String
    var direction: [Direction] = []
    var directions: [Int: String] = [:]
    
    // todo:
    let img: UIImage = UIImage()
    var isFavorite: Bool = false

    var ingredients: [String] = []
    //var directions: [Int: String] = [:]
    var notes: String = ""
    var equipment: [String] = []
    var nutrition: [String] = []
    

    var additionalDetails: AdditionalDetails = AdditionalDetails(
        yield: "", //
        preparationTime: 0,
        difficulty: 0, //
        sourceInfo: "",
        course: "",
        category: [],
        keywords: [] //
    )
    
//    enum CodingKeys: String, CodingKey {
//        case id = "recipe_id"
//        case title = "name"
//        case source
//        case rating
//        case difficulty
//        case servings
//        case yield
//        case alreadyCooked = "has_been_prepared"
//        case keywords
//    }
     
    
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//
//        self.id = try! container.decode(Int.self, forKey: .id)
////        self.title = try container.decode(String.self, forKey: .title)
////        self.source = try container.decode(String.self, forKey: .source)
////        self.rating = try container.decode(Float.self, forKey: .rating)
////        self.servings = try container.decode(Int.self, forKey: .servings)
////        self.difficulty = try container.decode(Int.self, forKey: .difficulty)
////        self.yield = try container.decode(String.self, forKey: .yield)
////        self.alreadyCooked = try container.decode(Bool.self, forKey: .alreadyCooked)
////
////        let keywords = try container.decode(String.self, forKey: .keywords)
////
////        self.keywords = keywords.components(separatedBy: ",")
//
//    }
    
    func toDataList<T>(
            _ input: T,
            asAdditionalDetails: Bool = false,
            asType: AditionalDetailsType? = nil) -> [cellDataList] {
        var result: [cellDataList] = []
        
        
        if let type = asType,
            let input = input as? String {
            for i in input.components(separatedBy: " ") {
                result.append(cellDataList(name: i))
            }
        } else if let input = input as? [Int: String]  {
            for i in input {
                result.append(cellDataList(name: "\(i.key)", value: i.value))
            }
            result.sort { (c1, c2) -> Bool in
                c1.name < c2.name
            }
            
        } else if asAdditionalDetails {
            
            result = [
                cellDataList(name: "Yield", value: self.yield),
                cellDataList(name: "Preparation time", value: "preparationTime"),
                cellDataList(name: "Difficulty", value: "\(self.difficulty)/5"),
                cellDataList(name: "Source", value: self.source),
                cellDataList(name: "Source info", value: self.source),
                cellDataList(name: "Course", value: "course"),
                //cellDataList(name: "Category", value: d.category.joined(separator: ", ")),
                cellDataList(name: "Keywords", value: self.keywords)
            ]
        }
         
        return result
        
        
        
    }
}

extension Recipe {
    static let foreignKey = ForeignKey(["recipe_id"], to: ["recipe_id"])
    
    static let dirs = hasMany(Direction.self, using: foreignKey)
    var dirs: QueryInterfaceRequest<Direction> {
        request(for: Recipe.dirs)
    }
   
}

extension Recipe: FetchableRecord {
    init(row: Row) {
        id = row["recipe_id"]
        title = row["name"]
        source = row["source"]
        rating = row["rating"]
        difficulty = row["difficulty"]
        servings = row["servings"]
        yield = row["yield"]
        alreadyCooked = row["has_been_prepared"]
        keywords = row["keywords"]
         
    }
}


struct AdditionalDetails {
    var yield: String
    var preparationTime: Int
    var difficulty: Int
    
    var sourceInfo: String
    var course: String
    var category: [selectableData]
    var keywords: [String] 
 }

struct ShoppingList {
    let id: String
    var name: String
    var items: [ShoppingItem]
}

struct ShoppingItem {
    let id: String
    var name: String
    var amount: Int
    var units: String
    var bought: Bool
}



struct CookingNotes {
    let name: String
    let source: String
    let text: String
    let keywords: [String]
    var image: UIImage? = nil
}

struct WineNotes {
    let name: String
    let winery: String
    let image: UIImage
    
    var isFavorite: Bool
    let rating: Float
    
    var region: String = ""
    var subRegion: String = ""
    var year: Int = 0
    var style: String = ""
    var keywords: [String] = []
    
}



struct moreTableData {
    let title: String
    let subTitle: String
    let icon: UIImage
    
    init(_ title: String, _ subTitle: String, _ iconName: String) {
        self.title = title
        self.subTitle = subTitle
        self.icon = UIImage(named: iconName) ?? UIImage()
    }
}



///////////////////////////////////////
struct selectableData {
    let id: Int
    let name: String
}
