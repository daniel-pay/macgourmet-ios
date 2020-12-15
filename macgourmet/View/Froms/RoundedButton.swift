//Created for macgourmet  (19.06.2020 )

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func draw(_ rect: CGRect) {
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
         
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /// initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    /// initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        clipsToBounds = true
        
    }
}
