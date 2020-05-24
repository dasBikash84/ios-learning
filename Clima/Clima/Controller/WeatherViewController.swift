import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.delegate = self
    }

    @IBAction func searchTextEntered(_ sender: UITextField) {
        print("searchTextEntered")
        print(searchText.text!)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        print("textFieldShouldReturn")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear")
        return true
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchText.endEditing(true)
        searchTextEntered(searchText)
    }
}

