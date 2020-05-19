import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var personStepper: UIStepper!
    

    @IBAction func tipChanged(_ sender: UIButton) {
        unselectAllPctButtons()
        billTextField.endEditing(true)
        sender.isSelected = true
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        performSegue(withIdentifier:"goToResult",sender:self)
    }
    
    private func unselectAllPctButtons(){
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    private func getTipPctValue() -> Double{
        if zeroPctButton.isSelected {
            return 0.0
        } else if tenPctButton.isSelected{
            return 0.1
        }else{
            return 0.2
        }
    }
    
    private func getBillAmount() -> Double{
        if let billText = billTextField.text {
            return Double(billText) ?? 0.0
        }
        return 0.0
    }
    
    private func getPersonCount() -> Double{
        return personStepper?.value ?? 0.0
    }
    
    private func getPerPersonBill() -> Double{
        return (getBillAmount() * (1.0+getTipPctValue()))/getPersonCount()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVc = segue.destination as! ResultViewController
        if segue.identifier == "goToResult" {
            destVc.personCount = Int(getPersonCount())
            destVc.tipPct = getTipPctValue()
            destVc.perPersonBill = getPerPersonBill()
        }
    }
}

