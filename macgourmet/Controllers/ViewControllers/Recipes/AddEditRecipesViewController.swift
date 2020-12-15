//Created for macgourmet  (21.06.2020 )

import UIKit

class AddEditRecipesViewController: CommonViewController, ImagePickerButtonDelegate {

    
 
    private enum textFieldsTags: Int {
        case
        recipeName      = 100,
        recipeSource    = 101,
        sourceInfo      = 102,
        servings        = 103,
        yield           = 104,
        note            = 105,
        hours           = 106,
        minutes         = 107,
        keywords        = 108
    }
    
    private enum selectableFields: Int {
        case
            equipment = 200,
            course = 201,
            categories = 202
    }
    
    
    
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet var roundedViews: [formRoundedView]!
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet var rightTopButton: UIButton!
    
    @IBOutlet weak var difficultyPicker: DifficultyPicker!
    @IBOutlet weak var notesTextView: KMPlaceholderTextView!
    @IBOutlet weak var selectImageButton: SelectImageButton!
    
    @IBOutlet weak var ingredientsTable: EditableTableView!
    @IBOutlet weak var nutritionsTable: EditableTableView!
    @IBOutlet weak var directionsTable: EditableTableView!
    
    
    var recipe: Recipe?
    var imagePicker: ImagePicker!
    
    
    private var inEditMode: Bool  {return recipe != nil}
      
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    private func setupView() {
        //
        /// debug
        ingredientsTable.data = [
        cellDataList(name: ""),
        cellDataList(name: ""),
        cellDataList(name: "")
        ]
        
        // set default data
        nutritionsTable.isNutrition = true
        nutritionsTable.data = [cellDataList(name: "")]
        //directions
        directionsTable.isDirections = true
        directionsTable.data = [cellDataList(name: "", value: "1")]
        
        //image button
        selectImageButton.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        if let r = recipe {
            rightTopButton.setImage(UIImage(named: "delete-icon"), for: .normal)
            
            viewLabel.text = appStrings.editRecipe
             
            setTextField(text: r.title, .recipeName)
            setTextField(text: r.source, .recipeSource)
            setTextField(text: r.additionalDetails.sourceInfo, .sourceInfo)
            setTextField(text: "\(r.servings)", .servings)
            setTextField(text: r.additionalDetails.yield, .yield)
             
            // Notes
            notesTextView.text = r.notes
            //
            selectImageButton.setImageForButton(img: r.img)
            
            
            //Ingredients
            ingredientsTable.data = r.ingredients.map({cellDataList(name: $0)})
            
            //Nutritions
            nutritionsTable.data = r.nutrition.map({cellDataList(name: $0)})
            
            // HRS:MINS
            let time = secondsToHoursMinutesSeconds(seconds: r.additionalDetails.preparationTime*60)
             
            setTextField(text: "\(time.0)" , .hours)
            setTextField(text: "\(time.1)", .minutes)
            
            let keywords = r.additionalDetails.keywords.joined(separator: ", ")
            setTextField(text: keywords, .keywords)
            
            difficultyPicker.selectedDiff = r.additionalDetails.difficulty
            
        } else {
            /// User try to add new recipe
            viewLabel.text = appStrings.addRecipe
             
        }
        
        
        ///
        for v in roundedViews {
            if inEditMode {v.placeholderText = nil}
              
            if selectableFields(rawValue: v.tag) != nil {
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                v.addGestureRecognizer(tap)
            }
        }
    }
    // MARK:- ACTIONS
    func tappedOnChange() {
        self.imagePicker.present(from: self.view)
        //self.selectImageButton.isSetImage = !self.selectImageButton.isSetImage
    }
    
    @IBAction func rightTopButton(_ sender: UIButton) {
        if inEditMode {
            print("Edit mode")
        } else {
            print("Add new VC")
        }
    }
    @IBAction func addDireection(_ sender: UIButton) {
        let newEl = cellDataList(name: "", value: "\(directionsTable.data.count+1)")
        directionsTable.data.append(newEl)
    }
    
    @IBAction func addIngretient(_ sender: UIButton) {
        ingredientsTable.data.append(cellDataList(name: ""))
    }
    
    @IBAction func addNutrition(_ sender: UIButton) {
        nutritionsTable.data.append(cellDataList(name: ""))
    }
    
    
    
    @IBAction func selectImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender) /// todo sender ?
         
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    
        guard
            let tag = sender?.view?.tag,
            let tappedOn = selectableFields(rawValue: tag) else {return}
        
        
        let VC = storyBoard.instantiateViewController(withIdentifier: "SelectableListViewController") as! SelectableListViewController
        VC.delegate = self
        
        VC.isSearchEnable = tappedOn == .course ? false : true
        VC.singleSelectionMode = tappedOn == .course ? true : false
        
        // set title
        var title: SelectableListTitle = .equipment
        
        if tappedOn == .categories {title = .category } else if tappedOn == .course {title = .course}
        VC.viewTitle = title
         
        
        VC.inputData = {
            if tappedOn == .categories {
                return debugData.category
            } else if tappedOn == .course {
                return debugData.course
            } else if tappedOn == .equipment {
                return debugData.equipment
            }
            
             return []
        }()
        
        self.present(VC, animated: true, completion: nil)
        
        print("Selectable Tapped: \(tappedOn)")
    }
    
    
    
    
    private func getTextField(_ tag: textFieldsTags) -> UITextField? {
        /// DEBUG
        if textFields.first(where: {$0.tag  == tag.rawValue}) == nil {print("😡 \(self.description):  Can't find \(tag) textField")}
         
        return textFields.first {$0.tag  == tag.rawValue}
    }
    
    private func setTextField(text: String, _ tag: textFieldsTags) {
        getTextField(tag)?.text = text
    }
}


 
extension AddEditRecipesViewController: SelectableListDelegate {
    func SelectedItems(_ items: [Any?], forView: SelectableListTitle?) {
        
        ///todo: (!)
//        if
//            let _ = items as? selectableData,
//            let v = forView {
//
//            if v == .category {
//                //recipe?.additionalDetails.category = items
//            } else if v == .course {
//
//            } else if v == .equipment {
//
//            }
//        }
    }
}


extension AddEditRecipesViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        print("NEW IMAGE SELECTED")
        if let image = image {
            self.selectImageButton.setImageForButton(img: image)
        }
       
        
    }
    
    
}
