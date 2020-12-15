//Created for macgourmet  (17.06.2020 )

import UIKit

protocol DetailsImageViewDelegate {
    func backTapped()
    func shareTapped()
    func editTapped()
}

//@IBDesignable
class DetailsImageView: UIView {
    
    
    var delegate: DetailsImageViewDelegate?
    
    var imageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "Image05")!)
        
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        
         
        return i
    }()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "icon-back-white")!, for: .normal)
        button.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        
        
        return button
    }()

    var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "icon-share")!, for: .normal)
        button.addTarget(self, action: #selector(shareAction(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "icon-edit")!, for: .normal)
        button.addTarget(self, action: #selector(editAction(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func backAction(sender: UIButton) {
        delegate?.backTapped()
    }
    
    @objc private func editAction(sender: UIButton) {
        delegate?.editTapped()
    }
    
    @objc private func shareAction(sender: UIButton) {
        delegate?.shareTapped()
    }
      
    override func draw(_ rect: CGRect) { }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setData(image: UIImage?) {
        imageView.image = image ?? UIImage()
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
        
        /// ====== Image =========
        addSubview(imageView)
        addSubview(backButton)
        addSubview(shareButton)
        addSubview(editButton)
        /// ====================
//        addSubview(subView)
        
        
        addConstraints()
    }
    
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            /// Image View
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            /// backButton
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50.0),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13.0),
            backButton.heightAnchor.constraint(equalToConstant: 25.0),
            backButton.widthAnchor.constraint(equalToConstant: 25.0),
            
            /// edit Button
            editButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 36.0),
            editButton.widthAnchor.constraint(equalToConstant: 36.0),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            
            /// share Button
            shareButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 36.0),
            shareButton.widthAnchor.constraint(equalToConstant: 36.0),
            shareButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -17.0), 
        ])
    }
}
