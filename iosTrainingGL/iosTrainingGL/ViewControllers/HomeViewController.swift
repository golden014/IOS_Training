//
//  HomeViewController.swift
//  iosTrainingGL
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfInitial = [String]()
    var arrNames = [String]()
    var context:NSManagedObjectContext!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfInitial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AssistantTableViewCell
        cell.initialtxt.text = arrayOfInitial[indexPath.row]
        
        cell.updateHandler = {
            self.updateData(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func updateData(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
    func loadData() {
        //load data berdasarkan array yang ada
        arrayOfInitial.removeAll()
        
        //select all dri db trus masukin ulang ke array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Assistants")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrayOfInitial.append(data.value(forKey: "initial") as! String)
                arrNames.append(data.value(forKey: "name") as! String)
            }
            
            assistantTv.reloadData()
        } catch {
            
        }
        
    }
    

    @IBOutlet var assistantTv: UITableView!
    @IBOutlet var initialTxt: UITextField!
    
    @IBOutlet var nameTxt: UITextField!
    
    @IBAction func doInsert(_ sender: Any) {
        //ambil txt
        //bikin entity
        // bikin new assistant
        // save
        let name = nameTxt.text!
        let initial = initialTxt.text!
        
        let entity = NSEntityDescription.entity(forEntityName: "Assistants", in: context)
        let newAssistant = NSManagedObject(entity: entity!, insertInto: context)
        newAssistant.setValue(initial, forKey: "initial")
        newAssistant.setValue(name, forKey: "name")
        do {
            try context.save()
            loadData()
        }
        catch {
            
        }
    }
    
    //update
    //reload data
    //delete
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        assistantTv.delegate = self
        assistantTv.dataSource = self
        loadData()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
