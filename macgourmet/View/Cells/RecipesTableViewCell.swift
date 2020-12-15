//Created for macgourmet  (16.06.2020 )
 
import UIKit

class RecipesTableViewCell: UITableViewCell {
  
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var alreadyCookedImageView: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var favImgView: UIImageView!
     
    @IBOutlet weak var starsStackView: UIStackView!
    
    
    var isFavorite: Bool = false {
        didSet {
            favImgView.isHidden = !isFavorite
        }
    }
    var alreadyCooked: Bool = false {
        didSet {
            if !alreadyCooked {alreadyCookedImageView.removeFromSuperview()} else {
                /// todo: add alreadyCooked view ?
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    
    func setData<T>(_ input: T) {
        
        
        if let t = input as? Recipe {
            cellTitle.text = t.title
            subTitle.text = t.source
            cellImg.image = t.img 
            /// todo: img placeholder needed ?
            
            isFavorite = t.isFavorite
            alreadyCooked = t.alreadyCooked
            
            setRating(t.rating)
        } else if let t = input as? WineNotes {
            
            cellTitle.text = t.name
            subTitle.text = t.winery
            cellImg.image = t.image
            
            /// todo: img placeholder needed ?
            
            isFavorite = t.isFavorite
            alreadyCooked = false
            
            setRating(t.rating)
        }
        
        

    }
    
    
    func setRating(_ rating: Float) {
        guard let stars = starsStackView.arrangedSubviews as? [UIImageView] else {return}
        
        for (index, star) in stars.enumerated() {
            star.tintColor = rating > Float(index) ? #colorLiteral(red: 1, green: 0.4784313725, blue: 0, alpha: 1) : #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
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
