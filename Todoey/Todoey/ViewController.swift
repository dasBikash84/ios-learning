import UIKit
import RealmSwift
import SwipeCellKit

class TodoListViewController: SwipableTableViewController,UISearchBarDelegate {
    
    @IBOutlet weak var uiSearchBar: UISearchBar!
    var itemArray: Results<TodoItem>?
    
    var selectedCategory : TodoCategory? {
        didSet{
            loadItems()
        }
    }
    
    let defaults = UserDefaults.standard
    let itemArrayKey = "TodoListViewController.itemArrayByEncoderWithTsKey"
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSearchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        itemArray = itemArray?.filter(NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!))
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func loadItems(){
        print(#function)
        print(selectedCategory)
        itemArray = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func getCellIdentifier() -> String {
        return "TodoItemCell"
    }
    
    override func setCellData(cell: SwipeTableViewCell, index: Int) {
        if let todoItem = itemArray?[index]{
            cell.textLabel?.text = "\(todoItem.name) | \(todoItem.time) "
            cell.accessoryType = todoItem.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Item found"
        }
    }
    
    override func deleteAction(index: Int) {
        try! realm.write{
            self.realm.delete(itemArray![index])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let item = itemArray?[indexPath.row]{
            try! realm.write{
                item.done = !item.done
            }
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item
    fileprivate func saveData(_ todoItem:TodoItem) {
        try! realm.write{
            selectedCategory?.items.append(todoItem)
        }
        self.tableView.reloadData()
    }
    
    @IBAction func addItemBttonPressed(_ sender: UIBarButtonItem) {
        var alertTextField:UITextField?
        let alert = UIAlertController(title: "Add todo item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("Item entered")
            if let newItemName = alertTextField?.text{
                print("New task name: \(newItemName)")
                let item = TodoItem()
                item.name = newItemName
                item.done = false
                item.time = Date()
                self.saveData(item)
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
