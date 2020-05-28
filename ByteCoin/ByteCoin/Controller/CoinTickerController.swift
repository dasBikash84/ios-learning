
import UIKit

class CoinTickerController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager : CoinManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager = CoinManager(delegate: self)
    }


}

//MARK: - TickerUpdateHandler

extension CoinTickerController : TickerUpdateHandler {
    
    func didUpdateTicker(with tickerUpdateModel: TickerUpdateModel) {
        print(tickerUpdateModel)
        runOnMainThread {
            self.bitcoinLabel.text = "\(tickerUpdateModel.lastValue)"
            self.currencyLabel.text = tickerUpdateModel.curencySymbol
        }
    }
    
    func didFailWithError(with error: Error) {
        print(error)
    }
}

//MARK: - UIPickerViewDelegate

extension CoinTickerController : UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - UIPickerViewDataSource

extension CoinTickerController : UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager!.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager!.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected row: \(coinManager!.currencyArray[row])")
        self.coinManager!.fetchRate(currencyIndex: row)
    }
    
}

//MARK: - Task post on main thread

extension UIViewController{
    func runOnMainThread(task:@escaping ()->Void){
        DispatchQueue.main.async{task()}
    }
}
