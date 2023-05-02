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
        
        cell.deleteHandler = {
            self.deleteData(indexPath: indexPath)
        }
                
        return cell
    }
    
    func updateData(cell: AssistantTableViewCell, indexPath: IndexPath) {
        let oldSongName = arrayOfInitial[indexPath.row]
        let artistname = arrNames[indexPath.row]
        

        let newSongName = cell.initialtxt.text
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Songs")
        request.predicate = NSPredicate(format: "artistName == %@", artistname)
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                data.setValue(newSongName, forKey: "songName")
            }
            
            try context.save()
            loadData()
        } catch {
            print("fail")
        }
        
        
    }
    
    func deleteData(indexPath: IndexPath) {
        let songName = arrayOfInitial[indexPath.row]
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Songs")
        req.predicate = NSPredicate(format: "songName == %@", songName)
        do {
            let res = try context.fetch(req) as! [NSManagedObject]
            for data in res {
                context.delete(data)
            }
            try context.save()
            loadData()
        }
        catch {
            
        }
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if (editingStyle == .delete) {
//            deleteData(indexPath: indexPath)
//        }
//
//    }
//    func deleteData(indexPath : IndexPath) {
//        let songName = arrayOfInitial[indexPath.row]
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Songs")
//
//        request.predicate = NSPredicate(format: "songName == %@", songName)
//
//        do {
//
//        } catch {
//
//        }
//    }
    
    
    func loadData() {
        //load data berdasarkan array yang ada
        arrayOfInitial.removeAll()
        
        //select all dri db trus masukin ulang ke array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Songs")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrayOfInitial.append(data.value(forKey: "songName") as! String)
                arrNames.append(data.value(forKey: "artistName") as! String)
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
        
        let entity = NSEntityDescription.entity(forEntityName: "Songs", in: context)
        let newAssistant = NSManagedObject(entity: entity!, insertInto: context)
        newAssistant.setValue(initial, forKey: "songName")
        newAssistant.setValue(name, forKey: "artistName")
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
