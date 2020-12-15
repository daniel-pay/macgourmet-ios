//Created for macgourmet  (17.06.2020 )

import UIKit

class FoodDetailsViewController: UIViewController, DetailsImageViewDelegate {
 
    @IBOutlet weak var header :DetailsImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
     
    var inputData: CookingNotes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        setData(inputData)
        
        header.delegate = self
    }
    
    
    func setData(_ data: CookingNotes?) {
        
        guard let d = data else {return}
        
        header.setData(image: d.image)
        
        titleLabel.text = d.name
        subTitleLabel.text = d.source
        
        
        textView.text = d.text
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
    
 

}
