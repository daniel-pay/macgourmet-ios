//Created for macgourmet  (18.06.2020 )

import UIKit

class WineDetailsViewController: UIViewController, DetailsImageViewDelegate {

    @IBOutlet weak var header :DetailsImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var keywordsLabel: UILabel!
    
    var inputData: WineNotes?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        header.delegate = self
        setData(inputData)
    }
    
    
    func setData(_ data: WineNotes?) {
        
        guard
            let d = data,
            let favSelected = UIImage(named: "add-to-fav-red"),
            let fav = UIImage(named: "add-to-fav")
            
            else {return}
        
        
        header.setData(image: d.image)
        setRating(d.rating)
        titleLabel.text = d.name
        subTitleLabel.text = d.winery
        favoriteImageView.image = d.isFavorite ? favSelected : fav
        
        regionLabel.text =  d.region
        subRegionLabel.text = d.subRegion
        yearLabel.text = "\(d.year)"
        styleLabel.text = d.style
        keywordsLabel.text = d.keywords.joined(separator: ", ")  
        
    }
    
    func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func shareTapped() {
        print("Share Tapped")
    }
    
    func editTapped() {
        print("Edit Tapped")
    }
    
    /// todo: refactor this - make it reusable
    private func setRating(_ r: Float) {
        guard let stars = ratingStackView.arrangedSubviews as? [UIImageView] else {return}
        
        for (index, star) in stars.enumerated() {
            star.tintColor = r > Float(index) ? #colorLiteral(red: 1, green: 0.4784313725, blue: 0, alpha: 1) : #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        }
    }
}
