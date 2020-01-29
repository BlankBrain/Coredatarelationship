//
//  ItemViewController.swift
//  CoredataRelationship
//
//  Created by Md. Mehedi Hasan on 28/1/20.
//  Copyright © 2020 Md. Mehedi Hasan. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    
    var people = [Person]()
    var items = [Item]()
    var item = Item(context: PersistanceServic.context)
    
    var person = Person ()
    var numberOfCellsTable:Int = 0
    let cellIdentifiar : String = "cell"
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var itemForAdd: UITextField!
    @IBOutlet weak var message: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        self.personName.text = person.name

    }
    
    
    
    
    
    @IBAction func addItemClicked(_ sender: Any) {

        item = Item(context: PersistanceServic.context)
        item.name = self.itemForAdd.text
        person.addToItems(item)
         PersistanceServic.saveContext()
         self.tableview.reloadData()
        self.message.text = item.name! + " Added successfully!!"
        
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfCellsTable = person.items?.count ?? 0
        return numberOfCellsTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiar, for: indexPath) as UITableViewCell
        cell.textLabel?.text =  (person.items?.allObjects[indexPath.row] as AnyObject).name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete{
              
            item = ((person.items?.allObjects[indexPath.row] as AnyObject) as! Item)
            person.removeFromItems(item)
            PersistanceServic.saveContext()
               print("Deleted")
            self.tableview.reloadData()
           }
       }
    
}
