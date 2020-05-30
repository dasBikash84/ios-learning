//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray:[String:Bool] = [:]
    
    let defaults = UserDefaults.standard
    let itemArrayKey = "TodoListViewController.itemArrayModelKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let savedItems = defaults.object(forKey: itemArrayKey) as? [String:Bool]{
            itemArray = savedItems
            tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for: indexPath)
        
        let itemKey = Array(itemArray.keys)[indexPath.row]
        
        cell.textLabel?.text = itemKey
        cell.accessoryType = itemArray[itemKey]! ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let itemKey = Array(itemArray.keys)[indexPath.row]
        itemArray[itemKey] = !itemArray[itemKey]!
        
        tableView.cellForRow(at: indexPath)!.accessoryType = itemArray[itemKey]! ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new item
    @IBAction func addItemBttonPressed(_ sender: UIBarButtonItem) {
        var alertTextField:UITextField?
        let alert = UIAlertController(title: "Add todo item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("Item entered")
            if let newItemName = alertTextField?.text{
                print("New task name: \(newItemName)")
                self.itemArray[newItemName] = false
                print(self.itemArray)
                self.defaults.set(self.itemArray, forKey: self.itemArrayKey)
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

