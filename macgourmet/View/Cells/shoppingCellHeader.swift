//Created for macgourmet  (19.06.2020 )

import UIKit

class shoppingCellHeader: UITableViewHeaderFooterView {
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
    
    func toBuy() {
        title.text = NSLocalizedString("TO BUY", comment: "Shopping tableView, section header 0 title")
    }
    
    func bought() {
        title.text = NSLocalizedString("BOUGHT", comment: "Shopping tableView, section header 1 title")
    }
    
    
    
    private func configureContents() {
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.textAlignment = .left
        title.font = commonAppearance.SFProTextHeavy.withSize(14.0)
        title.textColor = .black
        
         
        contentView.backgroundColor = .clear
        tintColor = .white
        
        contentView.addSubview(title)
        
          
        NSLayoutConstraint.activate([
            title.heightAnchor.constraint(equalToConstant: 14+25+25), 
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
}
