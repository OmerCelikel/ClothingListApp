//
//  ViewController.swift
//  ClothingListApp
//
//  Created by Ömer Oğuz Çelikel on 2.12.2021.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        //call functions
        takeData()
    }
    
    
    func takeData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // needs data taker
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Clothes")
        
        // ıf there is many datas
        fetchRequest.returnsObjectsAsFaults = false
        do{
            // results are empty list NSManagedObkect uses when Core Date uses
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                //gives NSManagedObject  .value(forkey: "name") as? String
                if let name = result.value(forKey: "name") as? String {
                    //print(name)
                    nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    //print(name)
                    idArray.append(id)
                }
                
            }
            // update data
            tableView.reloadData()
        } catch{
            print("there is a error")
        }
        
    }
    
    
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }

}

