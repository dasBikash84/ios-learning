
import UIKit

class ResultViewController: UIViewController {
    
    var perPersonBill:Double?=nil
    var personCount:Int?=nil
    var tipPct:Double?=nil
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(format: "%.02f", perPersonBill!)
        settingsLabel.text = "Split between \(Int(personCount!)) people, with \(Int(tipPct! * 100.0))% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
