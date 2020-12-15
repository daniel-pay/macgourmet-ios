//Created for macgourmet  (18.06.2020 )

import UIKit

class clickableTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cellLabelText: UILabel!
    
//    var isCellCheked: Bool = false {
//        didSet {
//            icon.image = isSelected ? UIImage(named: "checked-mark") : UIImage(named: "uncheck-mark")
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }
    
    func setData(_ text: String, isChecked: Bool = false) {
        cellLabelText.text = text
        isSelected = isChecked
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        icon.image = isSelected ? UIImage(named: "checked-mark") : UIImage(named: "uncheck-mark")
        
    }

}
