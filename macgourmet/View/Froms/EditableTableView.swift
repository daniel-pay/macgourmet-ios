//Created for macgourmet  (30.06.2020 )

import UIKit

protocol EditableViewDelegate {
    func delete(_ index: Int)
}
//@IBDesignable
class EditableTableView: UITableView {
 
    var isNutrition: Bool = false
    var isDirections: Bool = false
    
    var data: [cellDataList] = [] {
        didSet {
            self.reloadData()
            
        }
    }
     
    private var heightConstraint = NSLayoutConstraint()
     
    /// initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorColor = .clear
         
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         
        heightConstraint.constant = contentSize.height
    }
    
    
    private func setupView() {
        delegate = self
        dataSource = self
        
        register(editableTableViewCell.self, forCellReuseIdentifier: "cell")
        
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        allowsSelection = false
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension
        
        
        /// define height constraint
        heightConstraint = NSLayoutConstraint(item: self,
        attribute: .height,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: 20)
        
        NSLayoutConstraint.activate([ heightConstraint ])
    }
}

extension EditableTableView: EditableViewDelegate {
    func delete(_ index: Int) {
        if data.count > 1 {
             
            
            beginUpdates()
            data.remove(at: index)
            deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            endUpdates() 
        }
    }
     
}


extension EditableTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? editableTableViewCell else {return UITableViewCell()}
         
        
        cell.delegate = self
        
        cell.isNutrition = isNutrition
        cell.isDirections = isDirections
 
        cell.textChanged {[weak tableView] (_) in
                    // Possible solution: 3
                    // Seems to work
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
            
                    tableView?.layoutIfNeeded()
        }
        
        
        cell.index = indexPath.row
        cell.data = data[indexPath.row]
        
        return cell
    }
}



class editableTableViewCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    
    var delegate: EditableViewDelegate?
    var textChanged: ((String) -> Void)?
 
    var data: cellDataList? { didSet {updateCell()} }
    var isNutrition: Bool = false
    var isDirections: Bool = false { didSet {setupAsTextView()} }
    
    var index = 0
    
    private var ContainerMargins: (top: NSLayoutConstraint?, bottom: NSLayoutConstraint?, left: NSLayoutConstraint?, right: NSLayoutConstraint?)
    
    private var contentContainer: formRoundedView = {
        let view = formRoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.showBorder = false
         
        return view
    }()
    private var inputField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
         
        let placeholderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        tf.attributedPlaceholder = NSAttributedString(string: " ", attributes: [.foregroundColor: placeholderColor])
        tf.textAlignment = .left
        tf.font = commonAppearance.SFProTextRegular.withSize(14.0)
        
        return tf
    }()
    private var inputTextView: KMPlaceholderTextView = {
        let tv = KMPlaceholderTextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.placeholderLabel.text = "Start by heating the oven..."
        tv.font = commonAppearance.SFProTextRegular.withSize(14.0)
        
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        
        return tv
    }()
    private var icon: UIImageView = {
        let i = UIImageView()
        
        i.translatesAutoresizingMaskIntoConstraints = false
         
        i.contentMode = .scaleAspectFit
        i.image = UIImage(named: "icon-move")
        
        return i
    }()
    private var removeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setImage(UIImage(named: "cell-x"), for: .normal)
        btn.setTitle("", for: .normal)
        
         
        return btn
    }()
    private var indexLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = commonAppearance.SFProTextRegular.withSize(14.0)
        
        return lbl
    }()
    
    var isIndexEnabled: Bool = false {
        didSet {}
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func removeTapped() { 
        delegate?.delete(index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        configureContents()
//        addConstraints()
    }
    
    private func updateCell() {
        guard let d = data else {return}
            
        
        inputField.text = d.name
        inputField.placeholder = isNutrition ? "e.g. 400 kcal" : "Ingredient \(index+1)"
        removeButton.isHidden = d.name.isEmpty
        
        
        if let value = d.value {
            indexLabel.text = value
        }
    }
    
    // MARK:- Direction Text View
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    
    
    private func configureContents() {
        
        contentView.addSubview(contentContainer)
        
        contentContainer.addSubview(icon)
        contentContainer.addSubview(indexLabel)
        contentContainer.addSubview(removeButton)
        contentContainer.addSubview(inputTextView)
        contentContainer.addSubview(inputField)
         
        
        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
        inputField.delegate = self
        inputTextView.delegate = self
        
        addConstraints()
    }
    
    private func setupAsTextView() {
        if isDirections {
            let margins: (top: CGFloat,left: CGFloat) = (6,0)
            
            inputField.removeFromSuperview()
            // setup borders & margins
            contentContainer.showBorder = true
            ContainerMargins.top?.constant = margins.top
            ContainerMargins.bottom?.constant = -margins.top
            ContainerMargins.left?.constant = margins.left
            ContainerMargins.right?.constant = margins.left
            
        } else {
            inputTextView.removeFromSuperview()
            indexLabel.removeFromSuperview()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
        
            removeButton.isHidden = updatedText.isEmpty
        }
        
        return true
    }
    
    private func addConstraints() {
        
        /// Container
        ContainerMargins = (
            top: contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            bottom: contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            left: contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            right: contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        )
        
        ContainerMargins.top?.isActive = true
        ContainerMargins.bottom?.isActive = true
        ContainerMargins.left?.isActive = true
        ContainerMargins.right?.isActive = true
         
        
        NSLayoutConstraint.activate([
            // right icon
            icon.heightAnchor.constraint(equalToConstant: 7),
            icon.widthAnchor.constraint(equalToConstant: 7),
            icon.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 13.0),
            icon.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            
            // Index Label
            indexLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 13),
            indexLabel.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            
            // UITextView as Directions
            inputTextView.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10.0),
            inputTextView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -10.0),
            inputTextView.leadingAnchor.constraint(equalTo: indexLabel.leadingAnchor, constant: 10.0),
            inputTextView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -45.0),
            
            // textfield as other elements
            inputField.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10.0),
            inputField.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -10.0),
            inputField.leadingAnchor.constraint(equalTo: icon.leadingAnchor, constant: 14.0),
            inputField.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -45.0),
             
            // remove button
            removeButton.centerYAnchor.constraint(equalTo: contentContainer.centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -14.0),
            removeButton.heightAnchor.constraint(equalToConstant: 14),
            removeButton.widthAnchor.constraint(equalToConstant: 14),
        ])
         
    }
}
