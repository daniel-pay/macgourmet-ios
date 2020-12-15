//Created for macgourmet  (19.06.2020 )

import UIKit

class RecipeDetailsViewController: CommonViewController {

    /// ============ header =================
    @IBOutlet weak var header: DetailsImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var isFav: UIImageView!
    @IBOutlet weak var ratingStack: UIStackView!
    
    /// ============ INGREDIENTS ============
    
    
    @IBOutlet weak var ingredientsList: ListTableView!
    @IBOutlet weak var directionsList: ListTableView!
    
    @IBOutlet weak var servingsLabel: UILabel!
    
    
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var equipmentList: ListTableView!
    
    
    @IBOutlet weak var nutritionList: ListTableView!
    @IBOutlet weak var additionalsList: ListTableView!
    @IBOutlet weak var alreadyCooked: UISwitch!
    
    
    
    var recipt: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        header.delegate = self
        
        setupData()
    }
    
    
    private func setupData() {
        guard
            let r = recipt,
            let favSelected = UIImage(named: "add-to-fav-red"),
            let fav = UIImage(named: "add-to-fav")
        else {return}
        
        print(r.dirs)
        
        header.setData(image: r.img)
        nameLabel.text = r.title
        sourceLabel.text = r.source
        setRating(r.rating)
        servingsLabel.text = "for \(r.servings) servings" //todo: Localized string ?
        
        isFav.image = r.isFavorite ? favSelected : fav
         
        
        ingredientsList.listData = r.toDataList(r.ingredients)
        
        directionsList.isDirections = true 
        directionsList.listData = r.toDataList(r.directions)
                
        
        notesLabel.text = r.notes
        
        equipmentList.listData = r.toDataList(r.equipment)
        nutritionList.listData = r.toDataList(r.nutrition)
        additionalsList.listData = r.toDataList("",asAdditionalDetails: true)
        alreadyCooked.setOn(r.alreadyCooked, animated: false)
    }
    
    @IBAction func cookModeTapped(_ sender: UIButton) {
        let VC = storyBoard.instantiateViewController(withIdentifier: "CookModeViewController") as! CookModeViewController
        VC.recipt = recipt
        
        self.present(VC, animated: true, completion: nil)
    }
}


extension RecipeDetailsViewController: DetailsImageViewDelegate {
    func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func shareTapped() {
        //
    }
    
    func editTapped() { 
        let VC = storyBoard.instantiateViewController(withIdentifier: "AddEditRecipesViewController") as! AddEditRecipesViewController
        VC.recipe = self.recipt
        
        self.present(VC, animated: true, completion: nil)
         
    }
}

/// helpers maybe need to refactor
extension RecipeDetailsViewController {
    private func setRating(_ r: Float) {
        guard let stars = ratingStack.arrangedSubviews as? [UIImageView] else {return}
        
        for (index, star) in stars.enumerated() {
            star.tintColor = r > Float(index) ? #colorLiteral(red: 1, green: 0.4784313725, blue: 0, alpha: 1) : #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        }
    }
}
