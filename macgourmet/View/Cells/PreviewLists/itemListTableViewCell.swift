//Created for macgourmet  (20.06.2020 )

import UIKit


class itemListTableViewCell: UITableViewCell {
    
    let cellTitle: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = commonAppearance.SFProTextRegular.withSize(14.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightCellText: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = commonAppearance.SFProTextSemibold.withSize(14.0)
        label.textAlignment = .right
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }
    
    
    private func setupView() {
        
    
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectionStyle = .none
     
        
        
        contentView.addSubview(cellTitle)
        contentView.addSubview(rightCellText)
        
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            //cellTitle.heightAnchor.constraint(equalToConstant: 20),
            cellTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            cellTitle.trailingAnchor.constraint(equalTo: rightCellText.leadingAnchor),
            
            rightCellText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightCellText.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightCellText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    
}
