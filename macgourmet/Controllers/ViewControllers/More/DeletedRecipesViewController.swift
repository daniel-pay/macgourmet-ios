//Created for macgourmet  (18.06.2020 )

import UIKit

class DeletedRecipesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let deletedList = userManager.getDeletedRecipesList
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension DeletedRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deletedList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.setData(deletedList()[indexPath.row])
        
        return cell
    } 
}



