//Created for macgourmet  (15.06.2020 )

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var emptyListView: UIView!
    
    private var cookingNotes: [CookingNotes] = debugData.notesFood
    private var wineNotes: [WineNotes] =  debugData.wineNotes
    
    override func viewDidLoad() {
        super.viewDidLoad()

        funcUpdateData()
    }
    
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        funcUpdateData()
    }
    
    @IBAction func plusTapped(_ sender: UIButton) {
        let segueName = segmentControl.selectedSegmentIndex == 0 ? "addNoteCookingSegue" : "addNoteWineSegue"
        
        performSegue(withIdentifier: segueName, sender: nil)
    }
    
    private func funcUpdateData(onlyCounter: Bool = false) {
         
        segmentControl.setTitle(appStrings.foodTitle(cookingNotes.count), forSegmentAt: 0)
        segmentControl.setTitle(appStrings.wineTitle(wineNotes.count), forSegmentAt: 1)
        
        if !onlyCounter {
            notesTableView.reloadData()
        }
        
        
        
    }
    
    private func setup() {
        
    }
}



extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        let count = segmentControl.selectedSegmentIndex == 0 ? cookingNotes.count : wineNotes.count
        emptyListView.isHidden = count != 0
        
        return count
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segIndex = segmentControl.selectedSegmentIndex
         
        
        if segIndex == 0 {
            
            
            let VC = storyBoard.instantiateViewController(withIdentifier: "FoodDetailsViewController") as! FoodDetailsViewController
            VC.inputData = cookingNotes[indexPath.row]
            
            self.present(VC, animated: true, completion: nil)
                    
        } else if segIndex == 1 {
            
            let VC = storyBoard.instantiateViewController(withIdentifier: "WineDetailsViewController") as! WineDetailsViewController
            VC.inputData = wineNotes[indexPath.row]
            
            self.present(VC, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0
        { // CookingNotes
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "cookingCell", for: indexPath) as! CookingNotesTableViewCell
            
            cell.setData(cookingNotes[indexPath.row])
            return cell
             
            
        } else { // Wine Notes
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  RecipesTableViewCell
             
            cell.setData(wineNotes[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             
            if segmentControl.selectedSegmentIndex == 0 {
                cookingNotes.remove(at: indexPath.row)
            } else {
                wineNotes.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            funcUpdateData(onlyCounter: true)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deleteAction = UIContextualAction(style: .destructive, title: " ") {  (contextualAction, view, boolValue) in
//
//              //tableView.deleteRows(at: [indexPath], with: .automatic)
//          }
//          let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
//
//          return swipeActions
//      }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//        }
//
//        let share = UITableViewRowAction(style: .normal, title: "Disable") { (action, indexPath) in
//            // share item at indexPath
//        }
//
//        share.backgroundColor = UIColor.blue
//
//        return [delete, share]
//    }
    
    
    
}
