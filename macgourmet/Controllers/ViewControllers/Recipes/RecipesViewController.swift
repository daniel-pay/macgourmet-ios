//Created for macgourmet  (15.06.2020 )

import UIKit

class RecipesViewController: UIViewController {

    @IBOutlet weak var recipesTableView: UITableView!
    @IBOutlet weak var recipesCounterLabel: UILabel! 
    @IBOutlet weak var emptyListView: UIView!
    
    private var recipesManager = RecipesManager() /// debug data
    
    private var reciptData: [Recipe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updateData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateData()
    }
    
    
    
    @IBAction func hereTapped(_ sender: UIButton) {
    }
    
    
    private func updateData() {
        reciptData = recipesManager.getAll()
        
        
    }
}



extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count  = reciptData.count
        recipesCounterLabel.text = appStrings.recipesCounter(count)
        emptyListView.isHidden = count != 0
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.setData(reciptData[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
        let VC = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        VC.recipt = reciptData[indexPath.row]
        
        self.present(VC, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { 
            userManager.removeRecipe(indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}
