
import UIKit
import CoreData

class TodoListViewController: UITableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var uiSearchBar: UISearchBar!
    var itemArray: [TodoItem] = []
    
    var selectedCategory : TodoCategory? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    let itemArrayKey = "TodoListViewController.itemArrayByEncoderWithTsKey"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSearchBar.delegate = self
        print(selectedCategory)
        print(FileManager.default.urls(for: .documentDirectory,in: .userDomainMask))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        loadItems(NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func loadItems(_ predicate:NSPredicate?=nil){
        
        let request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let reqPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [reqPredicate,categoryPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        itemArray = try! context.fetch(request)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for: indexPath)
        
        let todoItem = itemArray[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = "\(todoItem.name!) | \(todoItem.time!) "
        cell.accessoryType = todoItem.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        var item = itemArray[indexPath.row]
        item.done = !item.done
        
        itemArray[indexPath.row] = item
        saveData()
        
        tableView.cellForRow(at: indexPath)!.accessoryType = item.done ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item
    fileprivate func saveData() {
//        self.defaults.set(itemArray.getEncodedData(), forKey: self.itemArrayKey)
        try! context.save()
    }
    
    @IBAction func addItemBttonPressed(_ sender: UIBarButtonItem) {
        var alertTextField:UITextField?
        let alert = UIAlertController(title: "Add todo item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("Item entered")
            if let newItemName = alertTextField?.text{
                print("New task name: \(newItemName)")
                let item = TodoItem(context : self.context)
                item.name = newItemName
                item.done = false
                item.time = Date()
                item.parentCategory = self.selectedCategory
                self.saveData()
                self.itemArray.append(item)
                print(self.itemArray)
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

