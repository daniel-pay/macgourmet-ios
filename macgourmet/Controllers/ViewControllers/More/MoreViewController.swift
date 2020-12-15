//Created for macgourmet  (15.06.2020 )

import UIKit

 
class MoreViewController: UIViewController {

    @IBOutlet weak var moreTableView: UITableView!
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
 
extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userManager.getMoreItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CookingNotesTableViewCell
        
        cell.setData(userManager.getMoreItems()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var VC: UIViewController?
        
        
       
        
        switch indexPath.row {
        case 0:
            print("0")
            
        case 1:
            VC = storyBoard.instantiateViewController(withIdentifier: "FontSettingsViewController") as! FontSettingsViewController
        case 2:
            print("Tapped")
        case 3: 
            VC = storyBoard.instantiateViewController(withIdentifier: "DeletedRecipesViewController") as! DeletedRecipesViewController
        default:
            break
        }
        
        if let vc = VC {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}



