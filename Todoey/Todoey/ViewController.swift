
import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray: TodoItems = TodoItems()
    
    let defaults = UserDefaults.standard
    let itemArrayKey = "TodoListViewController.itemArrayByEncoderWithTsKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let savedItems = defaults.data(forKey: itemArrayKey){
            itemArray = try! CoderHelper.decoder.decode(TodoItems.self, from: savedItems)
            tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for: indexPath)
        
        let todoItem = itemArray.items[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = "\(todoItem.name) | \(todoItem.time) "
        cell.accessoryType = todoItem.checked ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        var item = itemArray.items[indexPath.row]
        item.checked = !item.checked
        
        itemArray.items[indexPath.row] = item
        saveData()
        
        tableView.cellForRow(at: indexPath)!.accessoryType = item.checked ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item
    fileprivate func saveData() {
        self.defaults.set(itemArray.getEncodedData(), forKey: self.itemArrayKey)
    }
    
    @IBAction func addItemBttonPressed(_ sender: UIBarButtonItem) {
        var alertTextField:UITextField?
        let alert = UIAlertController(title: "Add todo item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("Item entered")
            if let newItemName = alertTextField?.text{
                print("New task name: \(newItemName)")
                self.itemArray.items.append(TodoItem(name: newItemName, checked: false))
                
                print(self.itemArray)
                self.saveData()
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter task name"
            alertTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true) {
            print("Add item alert displayed.")
        }
    }
    
}

