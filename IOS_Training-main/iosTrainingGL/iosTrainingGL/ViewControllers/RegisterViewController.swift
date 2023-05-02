//
//  RegisterViewController.swift
//  iosTrainingGL
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet var usernameTxt: UITextField!
    
    @IBOutlet var passwordTxt: UITextField!
    
    @IBOutlet var confPasswordTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    @IBAction func registerClicked(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        let confPassword = confPasswordTxt.text!
        
        //bikin entity, bikin new user, insert db
        
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(password, forKey: "password")
        
        do {
            try context.save()
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
        }
        catch{
            print("Insert Failed")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
     
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
