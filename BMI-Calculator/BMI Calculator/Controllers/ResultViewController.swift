
import UIKit

class ResultViewController: UIViewController {

    var bmi:BMI? = nil
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = String(format: "%.02f",bmi?.value ?? 0.0)
        adviceLabel.text = bmi?.advice
        bgImage.backgroundColor = bmi?.color
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
