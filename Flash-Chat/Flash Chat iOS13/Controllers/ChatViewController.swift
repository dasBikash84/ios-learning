
import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    private var messages:[Message] = [
        Message(sender: "u1", body: "M1"),
        Message(sender: "u2",body: "M2"),
        Message(sender: "u3",body: "M3")
    ]
    
    @IBAction func sendPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion:{})
    }
        
    private var launcerName:String?=nil
    
    func setLauncerSegueName(_ callerVc:String) {
        launcerName = callerVc
    }
    
    override func viewDidLoad() {
        print("ChatViewController launched by: \(launcerName ?? "No segue")")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }

}

struct Message {
    let sender:String
    let body:String
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell",for: indexPath) as! TableCell
        cell.label.text = "Message from \(messages[indexPath.row].sender)"
        return cell
    }
}

extension ChatViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)th row selected.")
    }
}

