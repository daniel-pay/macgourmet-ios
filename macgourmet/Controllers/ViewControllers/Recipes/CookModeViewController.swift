//Created for macgourmet  (28.06.2020 )

import UIKit

class CookModeViewController: CommonViewController {

    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    var recipt: Recipe?
    
    private var isLast = false {
        didSet {
            nextBtn.setTitle(isLast ? "Done" : "Next step", for: .normal)
        }
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        guard let r = recipt else {return}
         
        stageLabel.text = "1 of \(r.directions.count)"
        
        addStages(r)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let r = recipt else {return}
        
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        let intPage = Int(page)+1
        
        let isLast = intPage == r.directions.count
        
        
    
        
        if isLast {
            self.dismiss(animated: true, completion: nil)
        } else {
            scrollToPage(page: intPage, animated: true)
        }
        
        
    }
    
    private func addStages(_ r : Recipe) {
    
        let stages = r.directions.sorted { ( k1, k2) -> Bool in
            k1.key < k2.key
        }
        
        for (i, stage) in stages.enumerated() {
             
            let lbl = generateLabel("\(stage.value)")
            lbl.tag = 100+i
                
            scrollContainerView.addSubview(lbl)
            
            
            NSLayoutConstraint.activate([
                lbl.topAnchor.constraint(equalTo: scrollContainerView.topAnchor),
                lbl.bottomAnchor.constraint(equalTo: scrollContainerView.bottomAnchor),
                
                lbl.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
                lbl.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            ]) 
        }
        
        /// 
        
        for label in scrollContainerView.subviews {
            guard let lbl = label as? UILabel else {continue}
            
            if lbl.tag == 100 {
                NSLayoutConstraint.activate([
                lbl.leadingAnchor.constraint(equalTo: scrollContainerView.leadingAnchor)
                ])
                 
            } else if
                let prevLabel = scrollContainerView.viewWithTag(lbl.tag-1) as? UILabel,
                let nextLabel = scrollContainerView.viewWithTag(lbl.tag+1) as? UILabel,
                lbl.tag > 100 &&  lbl.tag < r.directions.count+100 {
                NSLayoutConstraint.activate([
                    lbl.leadingAnchor.constraint(equalTo: prevLabel.trailingAnchor),
                    lbl.trailingAnchor.constraint(equalTo: nextLabel.leadingAnchor),
                ])
                
                
            } else if label.tag == r.directions.count+100-1 {
                NSLayoutConstraint.activate([
                    lbl.trailingAnchor.constraint(equalTo: scrollContainerView.trailingAnchor)
                ])
                
            }
        }
    }
     
    private func generateLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.text = text
        label.textColor = .black
        label.font = commonAppearance.SFProTextRegular.withSize(24.0)
        label.textAlignment = .left
         
        return label
    }
}

extension CookModeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        let intPage = Int(page)+1
        
        let cur = (intPage == recipt?.directions.count ?? 0)
         
        if isLast != cur {isLast = cur}
          
        stageLabel.text = "\(intPage) of \(recipt?.directions.count ?? 0)"
    }
    
    
    private func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
}
