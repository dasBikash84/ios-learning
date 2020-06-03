//
//  SwipableTableViewController.swift
//  Todoey
//
//  Created by bikash on 4/6/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipableTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.00
    }
    
    func getCellIdentifier() -> String {
        fatalError("\(#function) not overridden")
        return ""
    }
    
    func deleteAction(index: Int){
        fatalError("\(#function) not overridden")
    }
    
    func setCellData(cell: SwipeTableViewCell,index: Int){
        fatalError("\(#function) not overridden")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(),for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.numberOfLines = 0
        setCellData(cell: cell, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Delete item at: \(indexPath.row)")
            self.deleteAction(index: indexPath.row)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
