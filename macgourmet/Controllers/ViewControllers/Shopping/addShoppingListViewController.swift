//Created for macgourmet  (18.06.2020 )

import UIKit

class addShoppingListViewController: CommonViewController {

    @IBOutlet weak var listNameField: UITextField!
    @IBOutlet weak var nextButton: GradientDoneButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listNameField.delegate = self
        
        checkView()
    }
    
    private func checkView(_ len: Int? = nil) {
        
        if let name = listNameField.text,
            name.count >= 3 {
            nextButton.isEnabled = true
            
            
        } else if let len = len, len >= 3 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = false
        }
    }
     
    
    @IBAction func addNewTapped(_ sender: UIButton) {
         /// todo: verify && create new
        
        guard let name = listNameField.text else {return}
         
        let list = ShoppingList(id: "\(Date().timeIntervalSince1970)", name: name, items: [])
        
        userManager.addNewShoppingList(list: list)
        
        let VC = storyBoard.instantiateViewController(withIdentifier: "editShoppingListViewController") as! editShoppingListViewController
        VC.inputData = list
        
        self.present(VC, animated: true, completion: nil)
        
    }
}


extension addShoppingListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        //checkView()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// define query length
         var searchLength = (textField.text?.count ?? 0) + (string != "" ? string.count : -1)
         
         /// if user select all text and remove it
         if string == "" && range.length > 1 && searchLength + 1 == range.length {searchLength = 0}
         
         checkView(searchLength)
        
        return true
    }
}
