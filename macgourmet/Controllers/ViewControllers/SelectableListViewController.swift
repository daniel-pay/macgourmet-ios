//Created for macgourmet  (22.06.2020 )

import UIKit

enum SelectableListTitle: String { case
    equipment = "Select equipment",
    course = "Select course",
    category = "Select category",
    addRecipe = "Add recipes"
}

protocol SelectableListDelegate {
    func SelectedItems(_ items: [Any?], forView: SelectableListTitle?)
}


class SelectableListViewController: CommonViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchView: roundedView!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var bottomButton: GradientDoneButton!
    
    var delegate: SelectableListDelegate?
    
    /// Options / data source
    var isSearchEnable = false
    var showBottomButton = false
    var singleSelectionMode = true
    
    var asRecipesPicker = false
    
    var viewTitle: SelectableListTitle = .equipment
    
    
    var inputData: [Any?] = []
    var selectedItems: [Any?] = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        setupUI()
    }
    
    
    private func setupUI() {
        
        listTableView.allowsMultipleSelection = !singleSelectionMode
        
        if !isSearchEnable { view.subviews.first {$0 == searchView}?.removeFromSuperview() }
        
        
        
        if !showBottomButton { view.subviews.first {$0 == bottomButton}?.removeFromSuperview() }
        
        
        
        setTitle(viewTitle)
         
    }
    
    
    
    private func setTitle(_ title: SelectableListTitle) {
        print(title.rawValue)
        titleLabel.text = title.rawValue
    }
    
    @IBAction func bottomButtonTapped(_ sender: UIButton) {
        //todo: backend logic here!
        delegate?.SelectedItems(self.selectedItems, forView: self.viewTitle)
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func updateButtonCounter() {
        let count = selectedItems.count
        
        bottomButton.isEnabled = count >= 1
        bottomButton.setTitle(appStrings.addRecipesButton(count) , for: .normal)
        
    }
    
}


extension SelectableListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inputData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clickableTableViewCell
        let row = indexPath.row
        
        /// define input data
        if let input = inputData as? [Recipe] {
            cell.setData(input[row].title)
            
        } else if let input = inputData as? [selectableData] {
            cell.setData(input[row].name)
        }
         
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! clickableTableViewCell
         
        let select = inputData[indexPath.row]
        
        
        
        cellTapped(cell.isSelected, item: select)
        
        
        if asRecipesPicker {updateButtonCounter()}
//        print("+++ selectedItems +++")
//        print(selectedItems)
//        print("+++ inputData +++")
//        print(inputData)
    }
    
    
    private func cellTapped(_ isSelect: Bool, item: Any?) {
         
        if
            let item = item as? Recipe,
            let selected = selectedItems as? [Recipe]
        
        {
            if isSelect  {
                let contains = selected.contains(where: {item.id == $0.id})
                 
                if  !contains {
                    selectedItems.append(item)
                }
            } else {
                if let i = selected.firstIndex(where: { $0.id == item.id }) {
                    selectedItems.remove(at: i)
                }
            }
        }
            
        else if
            let item = item as? selectableData,
            let selected = selectedItems as? [selectableData]
        
        {
            if isSelect {
                let contains = selected.contains(where: {item.id == $0.id})
                
                if !contains {
                    selectedItems.append(item)
                }
            } else {
                if let i = selected.firstIndex(where: { $0.id == item.id }) {
                    selectedItems.remove(at: i)
                }
            }
        }
         
        // skip for recipe picker
        if !asRecipesPicker {
            delegate?.SelectedItems(self.selectedItems, forView: self.viewTitle)
        }
    }
}
