//
//  PersonViewController.swift
//  CoredataRelationship
//
//  Created by Md. Mehedi Hasan on 28/1/20.
//  Copyright © 2020 Md. Mehedi Hasan. All rights reserved.
//

import UIKit
import CoreData

class PersonViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var people = [Person]()
    var items = [Item]()
    @IBOutlet weak var tableview: UITableView!
    let cellIdentifiar : String = "cell"
    var numberOfCellsTable:Int = 0
    var selectedPerson: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
            do{
            people = try PersistanceServic.context.fetch(fetchRequest)

            }catch{
                print("error loading previous data !")
            }
        
      
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("people.count")
        print(people.count)
        numberOfCellsTable = people.count
        return numberOfCellsTable
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiar, for: indexPath) as UITableViewCell
        cell.textLabel?.text =  people[indexPath.row].name
        return cell
    }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print( people[indexPath.row].name )
        selectedPerson = indexPath.row
        self.performSegue(withIdentifier: "personDetails", sender: self)

          }
    func addPerson()  {

        let item1 = Item(context: PersistanceServic.context)
        item1.name = "123"
        let item2 = Item(context: PersistanceServic.context)
        item2.name = "456"
        let person1 = Person(context: PersistanceServic.context)
        person1.name = "abc"
        person1.addToItems(item1)
        person1.addToItems(item2)
        PersistanceServic.saveContext()


    }
    func addItem()  {
          let item1 = Item(context: PersistanceServic.context)
          item1.name = "item 1"
          PersistanceServic.saveContext()
          let item2 = Item(context: PersistanceServic.context)
          item2.name = "item 2"
          PersistanceServic.saveContext()

      }
    
    func showAllPerson()  {
        let fetchRequest : NSFetchRequest<Person> = Person.fetchRequest()
        do{
          let people = try PersistanceServic.context.fetch(fetchRequest)
            self.people = people
            print("==========")
            print(people.count)
            for item in people{
                print(item.name)
            }

        }catch{
            print("error loading previous data !")
        }
    }
    func showAllItem()  {
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        do{
          let items = try PersistanceServic.context.fetch(fetchRequest)
            self.items = items
            print(people.count)
            for item in items{
                print(item.name)
            }

        }catch{
            print("error loading previous data !")
        }
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let ItemViewController = segue.destination as? ItemViewController else {return}
            ItemViewController.person = people[selectedPerson]

    }
  
    
}

