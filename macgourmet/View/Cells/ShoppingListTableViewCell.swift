//Created for macgourmet  (19.06.2020 )

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cellLabelText: UILabel!
    @IBOutlet weak var cellsubLabelText: UILabel!
    
    var isCellCheked: Bool = false {
        didSet {
            icon.image = isCellCheked ? UIImage(named: "checked-mark") : UIImage(named: "uncheck-mark")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ item: ShoppingItem) {
        
        cellLabelText.text = item.name
        
        if item.bought {
            
            let attributedText =  NSMutableAttributedString(string: item.name)
            attributedText.addAttributes([
                            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                            .strikethroughColor: UIColor.black,
                            .font : commonAppearance.SFProTextMedium.withSize(14.0)
                            ], range: NSMakeRange(0, attributedText.length))
            
            cellLabelText.attributedText = attributedText
        } else {
            
        }
        
        self.isCellCheked = item.bought
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setSelected(false, animated: true)
        }
        
    }
}
