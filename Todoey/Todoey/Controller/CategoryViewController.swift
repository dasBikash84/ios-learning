
import UIKit
import CoreData
import RealmSwift
import SwipeCellKit

class CategoryViewController: SwipableTableViewController {
    
    
    let realm = try! Realm()
    var categories : Results<TodoCategory>?

    override func viewDidLoad() {
        super.viewDidLoad()
        readData()        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func getCellIdentifier() -> String {
        return "categoryCell"
    }
    
    override func setCellData(cell: SwipeTableViewCell, index: Int) {
        let category = categories?[index]
        cell.textLabel?.text = category?.name ?? "No category found"
    }
    
    override func deleteAction(index: Int) {
        try! realm.write{
            self.realm.delete(categories![index])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories?[indexPath.row]
        performSegue(withIdentifier: "gotoTodoView", sender: self)
    }
    
    //MARK: - Add new item
    fileprivate func saveData(_ category:TodoCategory) {
        try! realm.write{
            realm.add(category)
        }
        tableView.reloadData()
    }
    
    func readData(){
        categories = realm.objects(TodoCategory.self)
        tableView.reloadData()
    }
    
    func addNewCategory(_ name:String){
        let category = TodoCategory()
        category.name = name
        saveData(category)
    }

    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        
        var alertTextField:UITextField?
        let alert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            print("Item entered")
            if let newCategoryName = alertTextField?.text{
                self.addNewCategory(newCategoryName)
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Category name"
            alertTextField = textField
        }
        
        alert.addAction(action)
        present(alert, animated: true) {}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVc.selectedCategory = categories?[indexPath.row]
        }
    }
}
