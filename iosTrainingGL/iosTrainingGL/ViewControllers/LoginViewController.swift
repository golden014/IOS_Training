//
//  LoginViewController.swift
//  iosTrainingGL
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
    
    
    @IBOutlet var usernameTxt: UITextField!
    
    @IBOutlet var passwordTxt: UITextField!
    
    var context: NSManagedObjectContext!
    @IBAction func loginClicked(_ sender: Any) {
        // ammbil data dari textfield
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        
        
        //request ke core data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        //coba fetch
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            if result.count == 0 {
                print("Login Failed")
            } else {
                //redirect ke home page
                print("login done")
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
            }
        } catch {
            
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
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
