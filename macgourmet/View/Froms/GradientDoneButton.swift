//Created for macgourmet  (19.06.2020 )

import UIKit

class GradientDoneButton: UIButton {
    
    private let gradient = CAGradientLayer()
    private let colours = [#colorLiteral(red: 1, green: 0.4784313725, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.7215686275, blue: 0, alpha: 1)]
    private let orientation: GradientOrientation = .horizontal
     
    
    open override var isEnabled: Bool {
        didSet {
            changeButtonState()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = self.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        

    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    /// initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 4
        clipsToBounds = true
        
        backgroundColor = .lightGray
          
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        gradient.zPosition = -1
        
        self.layer.insertSublayer(gradient, at: 0)
        
        let selectedColor = UIColor.gray.withAlphaComponent(0.5)
        setTitleColor(selectedColor, for: .selected)
        setTitleColor(selectedColor, for: .highlighted)
    }
     
    
    private func changeButtonState() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: self.isEnabled ? .curveEaseIn : .curveEaseOut,
            animations: {
                self.alpha = self.isEnabled ? 1.0 : 0.4
            }
        )
    } 
}
