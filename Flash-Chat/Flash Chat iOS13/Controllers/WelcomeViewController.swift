
import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    private var titleText = Array("⚡️FlashChat".reversed())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func postCharToTitle(_ char:Character?){
        if let ch = char {
            titleLabel.text?.append(ch)
        }
        runOnMainThread(delaySec: 0.05){
            if let ch = self.titleText.popLast(){
                self.postCharToTitle(ch)
            }
        }
        
//        var index = 1
//        for ch in titleText.reversed(){
//            runOnMainThread(delaySec: 0.1 * Double(index)){
//                self.titleLabel.text?.append(ch)
//            }
//            index += 1
//        }
    }
    
    @IBAction func registerButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        showTitleAnimation()
    }
    
    func showTitleAnimation(){
        titleText = Array("⚡️FlashChat".reversed())
        titleLabel.text = ""
        postCharToTitle(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}

extension UIViewController{
    func runOnMainThread(delaySec:Double,what task: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+delaySec){
            task()
        }
    }
}
