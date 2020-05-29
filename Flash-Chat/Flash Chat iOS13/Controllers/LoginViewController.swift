
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
        
    private var launcerName:String?=nil
    
    func setLauncerSegueName(_ callerVc:String) {
        launcerName = callerVc
    }
    
    override func viewDidLoad() {
        print("LoginViewController launched by: \(launcerName ?? "No segue")")
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier:Defs.Segues.loginToChat,sender:self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Defs.Segues.loginToChat {
            let destVc = segue.destination as! ChatViewController
            destVc.setLauncerSegueName(Defs.Segues.loginToChat)
        }
    }
    
}
