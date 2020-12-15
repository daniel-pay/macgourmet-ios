//Created for macgourmet  (18.06.2020 )

import UIKit




class FontSettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension FontSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontSizeSettings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clickableTableViewCell
        
        let curCase = fontSizeSettings.allCases[indexPath.row]
          
        cell.setData(
            "\(curCase)".capitalized,
            isChecked: curCase == userManager.userFontSize
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = fontSizeSettings.allCases[indexPath.row]
        
        for (i, c) in fontSizeSettings.allCases.enumerated() {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! clickableTableViewCell
            //cell.isCellCheked = c == selected < - TODO!
        }
         
        userManager.userFontSize = selected
    }
}
