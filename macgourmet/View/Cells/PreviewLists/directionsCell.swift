//Created for macgourmet  (20.06.2020 )

import UIKit
 
class DirectionsListTableViewCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let cellNum: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = commonAppearance.SFProTextBold.withSize(14.0)
         
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let CellText: UIInsetLabel = {
        let tv = UIInsetLabel()
        
        tv.textColor = .black
        tv.font = commonAppearance.SFProTextRegular.withSize(14.0)
        tv.textAlignment = .left
        tv.contentMode = .scaleToFill
        //tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.numberOfLines = 0
        //tv.isSelectable = false
        
        //label.lineBreakMode = .byWordWrapping
        //tv.setPadding(top: -20, left: 0, bottom: -20, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
        //layoutSubviews()
        //layoutIfNeeded()
        
    }
     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }
    
    
    private func setupView() {
        
        containerView.layer.cornerRadius = 4
        containerView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9843137255, alpha: 1)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectionStyle = .none
     
        contentView.backgroundColor = .clear
         
        containerView.addSubview(cellNum)
        containerView.addSubview(CellText)
        contentView.addSubview(containerView)
         
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            cellNum.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            cellNum.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 16),
            cellNum.widthAnchor.constraint(equalToConstant: 20),
            //cellNum.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
             
            cellNum.trailingAnchor.constraint(equalTo: CellText.leadingAnchor, constant: -8),
            
            CellText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            CellText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            CellText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
        ])
    }
    
    
}
