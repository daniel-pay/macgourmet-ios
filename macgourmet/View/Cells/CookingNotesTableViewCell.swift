//Created for macgourmet  (17.06.2020 )

import UIKit

class CookingNotesTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    
    func setData<T>(_ data: T) {
        
        
        if let d = data as? CookingNotes {
            cellTitle.text = d.name
            subTitle.text = d.source
             
            cellImg.image = d.image != nil ? d.image : UIImage(named: "cookingImgPlaceholder")!
            
            /// todo: img placeholder needed ?
        } else if let d = data as? moreTableData {
            cellTitle.text = d.title
            subTitle.text = d.subTitle
            cellImg.image = d.icon
        } else if let d = data as? ShoppingList {
            cellTitle.text = d.name
            
            let bought = d.items.filter {
                $0.bought == true
            }.count
            
            subTitle.text = appStrings.shopingCellSubTitle+" \(bought)/\(d.items.count)"
        }
        
        
        
    }
     
    
    
    private func setupView() {
        cellImg.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setSelected(false, animated: true)
        }
        // Configure the view for the selected state
    }

}
