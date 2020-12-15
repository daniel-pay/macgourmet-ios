//Created for macgourmet  (15.06.2020 )

import UIKit

class ShoppingListsViewController: UIViewController {

    @IBOutlet weak var shoppingTableView: UITableView!
    @IBOutlet weak var shoopingCounterLabel: UILabel!
    
    private let shoopingList = userManager.getShoppingList
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shoppingTableView.reloadData()
    } 
}

extension ShoppingListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count  = shoopingList().count
        shoopingCounterLabel.text = appStrings.shoppingCounter(count)
         
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CookingNotesTableViewCell
        cell.setData(shoopingList()[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = storyBoard.instantiateViewController(withIdentifier: "editShoppingListViewController") as! editShoppingListViewController
        VC.inputData = shoopingList()[indexPath.row]
        
        self.present(VC, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //userManager.removeRecipe(indexPath.row)
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
} 
