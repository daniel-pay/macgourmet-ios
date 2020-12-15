//Created for macgourmet  (21.06.2020 )

import UIKit

@IBDesignable
class DifficultyPicker: UIStackView {
  
    var selectedDiff: Int? {
        didSet { updateView()}
    }
    
    private let firstButton: UIButton = {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 101
        btn.backgroundColor = .white
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = commonAppearance.SFProTextMedium.withSize(14.0)
        
        btn.addTarget(
            self,
            action: #selector(buttonTapped(_:)),
            for: .touchUpInside)
        
        return btn
    }() 
    
    /// initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// initWithCode to init view from xib or storyboard
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func createNewButton(_ index: Int) -> UIButton {
        let btn = UIButton()
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 100+index
        btn.backgroundColor = .white
        btn.setTitle("\(index)", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = commonAppearance.SFProTextMedium.withSize(14.0)
        
        btn.addTarget(
            self,
            action: #selector(buttonTapped(_:)),
            for: .touchUpInside)
        
        return btn
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        selectedDiff = sender.tag-100
    }
    
    
    private func updateView() {
        for btn in subviews {
            guard let btn = btn as? UIButton else { continue }
            
            
            if
                let diff = selectedDiff,
                btn.tag == diff+100 {
                
                btn.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
                btn.titleLabel?.font = commonAppearance.SFProTextBold.withSize(14.0)
            } else {
                
                btn.backgroundColor = .white
                btn.titleLabel?.font = commonAppearance.SFProTextMedium.withSize(14.0)
            }
        }
    }
     
    
    private func setupView() {
        
        axis = .horizontal
        spacing = 0.0
        alignment = .fill
        contentMode = .scaleToFill
        
         
        addArrangedSubview(firstButton)
         
        for i in 2...5 {
            addArrangedSubview(createNewButton(i))
        }
        
        /// add constraints
        for btn in subviews { 
            NSLayoutConstraint.activate([
                btn.widthAnchor.constraint(equalTo: firstButton.widthAnchor, multiplier: 1.0),
            ])
        }
    }
}
