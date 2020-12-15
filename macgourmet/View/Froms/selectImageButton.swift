//Created for macgourmet  (19.06.2020 )

import UIKit

protocol ImagePickerButtonDelegate {
    func tappedOnChange()
}

@IBDesignable
class SelectImageButton: UIButton {
     
    private let dashedLineColor = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
    private let dashedLinePattern: [NSNumber] = [6, 3]
    private let dashedLineWidth: CGFloat = 1

    private let borderLayer = CAShapeLayer()
    
    
    var isSetImage = false {
        didSet {animateContainer(isSet: !isSetImage)}
    }
    
    var delegate: ImagePickerButtonDelegate?
    
    
    // image was selected
    private let selectedContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    private let imageThumbnailer: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        imageView.backgroundColor = .lightGray
        
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
         
        return imageView
    }()
    
    
    private let imageNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 1
        label.font = commonAppearance.SFProTextSemibold.withSize(14.0)
        label.textColor = .black
        label.text = "unknown"
        
        
        return label
    }()

    private let imageSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 1
        label.font = commonAppearance.SFProTextSemibold.withSize(12.0)
        label.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        label.text = "0.0 MB"
        
        
        return label
    }()
    
    private let rightFakeBtn: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 14.0
        label.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        label.clipsToBounds = true
        
        label.numberOfLines = 1
        label.font = commonAppearance.SFProTextBold.withSize(12.0)
        label.textColor = .black
        label.text = "Change"
        label.textAlignment = .center
        
        return label
    }()
    
    
    func setImageForButton(img: UIImage) { 
        imageThumbnailer.image = img
        isSetImage = true
    }
    
    
    override func draw(_ rect: CGRect) {
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius).cgPath
        
        
        self.bringSubviewToFront(selectedContainer)
        
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
        
        // init
        layer.cornerRadius = 4
        
        borderLayer.strokeColor = dashedLineColor.cgColor
        borderLayer.lineDashPattern = dashedLinePattern
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = dashedLineWidth
        layer.addSublayer(borderLayer)
        

        addPreview()
    }
     
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.tappedOnChange()
    }
    
    private func addPreview() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_ :)))
        selectedContainer.addGestureRecognizer(tap)
        
        selectedContainer.isHidden = true
        addSubview(selectedContainer)
        
        
        selectedContainer.addSubview(imageThumbnailer)
        selectedContainer.addSubview(imageNameLabel)
        selectedContainer.addSubview(imageSizeLabel)
        selectedContainer.addSubview(rightFakeBtn)
        
         
        // add constraints
        NSLayoutConstraint.activate([
        
            selectedContainer.topAnchor.constraint(equalTo: topAnchor),
            selectedContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectedContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            imageThumbnailer.heightAnchor.constraint(equalToConstant: 50.0),
            imageThumbnailer.widthAnchor.constraint(equalToConstant: 50.0),
            imageThumbnailer.leadingAnchor.constraint(equalTo: selectedContainer.leadingAnchor, constant: 16.0),
            imageThumbnailer.centerYAnchor.constraint(equalTo: selectedContainer.centerYAnchor),
            
            imageNameLabel.topAnchor.constraint(equalTo: imageThumbnailer.topAnchor, constant: 8.0),
            imageNameLabel.leadingAnchor.constraint(equalTo: imageThumbnailer.trailingAnchor, constant: 16.0),
            
            imageSizeLabel.topAnchor.constraint(equalTo: imageNameLabel.bottomAnchor, constant: 2.0),
            imageSizeLabel.leadingAnchor.constraint(equalTo: imageNameLabel.leadingAnchor),
            imageSizeLabel.trailingAnchor.constraint(equalTo: imageNameLabel.trailingAnchor),
            
            rightFakeBtn.heightAnchor.constraint(equalToConstant: 28.0),
            rightFakeBtn.widthAnchor.constraint(equalToConstant: 74.0),
            rightFakeBtn.trailingAnchor.constraint(equalTo: selectedContainer.trailingAnchor, constant: -22.0),
            rightFakeBtn.centerYAnchor.constraint(equalTo: selectedContainer.centerYAnchor),
             
        ])
    }
    
    private func showContainer() {
        selectedContainer.isHidden = false
        selectedContainer.alpha = 0
    }
    
    private func animateContainer(isSet: Bool) {
        borderLayer.lineDashPattern = !isSet ? nil : dashedLinePattern
        
        if !isSet {self.selectedContainer.isHidden = isSet;print("S set .isHidden = \(isSet)")}
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.1,
            options: .curveEaseIn,
        
            animations: {
            self.selectedContainer.alpha = isSet ? 0.0 : 1.0
            
        }) { (finished) in 
            if isSet {self.selectedContainer.isHidden = isSet;print("E set .isHidden = \(isSet)")}
        }
    }
}
