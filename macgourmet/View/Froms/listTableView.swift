//Created for macgourmet  (20.06.2020 )

import UIKit

struct cellDataList {
    let name: String
    var value: String? = nil
}
 
class ListTableView: UITableView {

    private let cellHeight: CGFloat = 43.0
    
    var heightConstraint = NSLayoutConstraint()
      
    var isDirections = false {
        didSet {
            update()
            
        }
    }
    
    var listData : [cellDataList] = [] {
        didSet {update()}
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    /// initWithFrame to init view from code
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
    
    /// initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heightConstraint.constant = self.contentSize.height
        
    }
    private func update() { 
        if isDirections { separatorColor = .clear}
        reloadData()
    }
      
    private func setupView() {
        delegate = self
        dataSource = self
        
        isScrollEnabled = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension
        
        separatorInset = UIEdgeInsets(top: 0, left: 9999, bottom: 0, right: 0)
        
        heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .greaterThanOrEqual,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 25
        )
        
        heightConstraint.constant = 20
        
        addConstraint(heightConstraint)
          
        register(itemListTableViewCell.self, forCellReuseIdentifier: "cell")
        register(DirectionsListTableViewCell.self, forCellReuseIdentifier: "cell01")
    }
}


extension ListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listData[indexPath.row]
        
        if isDirections {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell01", for: indexPath) as! DirectionsListTableViewCell
            
            cell.cellNum.text = data.name
            cell.CellText.text = data.value
            //cell.layoutIfNeeded()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemListTableViewCell
             
            cell.cellTitle.text = data.name
            if let rightText = data.value {cell.rightCellText.text = rightText}
             
            
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isDirections {
            return UITableView.automaticDimension
        } else {
            return cellHeight
            
        }
    }
}








