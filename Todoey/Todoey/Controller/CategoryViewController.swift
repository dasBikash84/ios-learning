//
//  CategoryViewController.swift
//  Todoey
//
//  Created by bikash on 1/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories : [TodoCategory] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell",for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = "\(category.name!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        performSegue(withIdentifier: "gotoTodoView", sender: self)
    }
    
    //MARK: - Add new item
    fileprivate func saveData() {
        try! context.save()
    }
    
    func readData(){
        let request : NSFetchRequest<TodoCategory> = TodoCategory.fetchRequest()
        categories = try! context.fetch(request)
        tableView.reloadData()
    }
    
    func addNewCategory(_ name:String){
        let category = TodoCategory(context : self.context)
        category.name = name
        self.saveData()
        self.categories.append(category)
        print(self.categories)
        self.tableView.reloadData()
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
            destinationVc.selectedCategory = categories[indexPath.row]
        }
    }
}
