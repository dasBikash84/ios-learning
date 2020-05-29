
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier:Defs.Segues.registerToChat,sender:self)
    }
    
    private var launcerName:String?=nil
    
    func setLauncerSegueName(_ callerVc:String) {
        launcerName = callerVc
    }
    
    override func viewDidLoad() {
        print("RegisterViewController launched by: \(launcerName ?? "No segue")")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Defs.Segues.registerToChat {
            let destVc = segue.destination as! ChatViewController
            destVc.setLauncerSegueName(Defs.Segues.registerToChat)
        }
    }
}
