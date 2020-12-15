//Created for macgourmet  (19.06.2020 )

import UIKit

class editShoppingListViewController: CommonViewController {

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listSubTitle: UILabel!
    
    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var inputData: ShoppingList?
    
    private var boughtItems: [ShoppingItem] = []
    private var toBuyItems: [ShoppingItem] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupData()
        tableView.register(shoppingCellHeader.self, forHeaderFooterViewReuseIdentifier: "shoppingCellHeader")
    }
    
    func setupData() {
        guard let data = inputData else {return}
        
        boughtItems = data.items.filter({$0.bought == true})
        toBuyItems = data.items.filter({$0.bought == false})
        
        
        let boughtItems = data.items.filter {$0.bought == true}.count
        
        listTitle.text = data.name
        listSubTitle.text = "\(boughtItems)/\(data.items.count) "+appStrings.shoppingEditSubTitle
        
        separator.isHidden = data.items.count == 0
        
        tableView.reloadData()
    }
    
    
    @IBAction func addRecipeTapped (_ sender : UIButton) {
        addRecipe()
    }
    
    
    
    private func addRecipe() {
        
        let VC = storyBoard.instantiateViewController(withIdentifier: "SelectableListViewController") as! SelectableListViewController
        VC.delegate = self
        
        VC.isSearchEnable = true
        VC.singleSelectionMode = true
        
        // set title
        VC.viewTitle = .addRecipe
        VC.asRecipesPicker = true
        VC.showBottomButton = true
        
        
        
        VC.inputData = {
            return userManager.getRecipes()
        }()
        
        self.present(VC, animated: true, completion: nil)
    }
}


extension editShoppingListViewController: SelectableListDelegate {
    func SelectedItems(_ items: [Any?], forView: SelectableListTitle?) {
        print(items)
    }
    
    
}

extension editShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? toBuyItems.count : boughtItems.count
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {

        return 2
        //if boughtItems.count == 0 || toBuyItems.count == 0 {return 1} else {return 2}
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "shoppingCellHeader") as! shoppingCellHeader
         
        section == 0 ? header.toBuy() : header.bought()
         
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShoppingListTableViewCell
        let section = indexPath.section == 0
        
        let data = section ? toBuyItems[indexPath.row] : boughtItems[indexPath.row]
            cell.setData(data)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //var d = indexPath.section == 0 ? toBuyItems[indexPath.row] : boughtItems[indexPath.row]
         
        //d.bought = !d.bought
        
        //userManager.modifyShoolingListItem(d)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setupData()
        }
        
        
    }
    
    
}
