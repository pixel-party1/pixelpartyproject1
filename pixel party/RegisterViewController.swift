//
//  RegisterViewController.swift
//  pixel party
//
//  Created by Roome, Ellis on 15/04/2026.
//

import UIKit
import CoreData
import CryptoKit

class RegisterViewController: UIViewController {
    
    var users: [User] = []
    var userExists: Bool = false

    @IBAction func backToSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Text fields
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    //Press register
    @IBAction func submit(_ sender: Any) {
        userExists = false
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let confirmPassword = confirmPasswordField.text ?? ""
        
        if (password.isEqual(confirmPassword)) {
            let hashed = hash(password)
            for user in users {
                if (username.isEqual(user.username)) {
                    userExists = true
                }
            }
            if (userExists == false) {
                storeUser(theUsername: username, theHashedPassword: hashed)
                UserDefaults.standard.set(true, forKey: "signedIn")
                UserDefaults.standard.set(username, forKey: "currentUser")
                let alert = UIAlertController(title: "User registered", message: "Successfully created local user account", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                present(alert, animated: true)                
            } else if (userExists == true) {
                let alert = UIAlertController(title: "Username already exists", message: "An account with this username already exists", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Passwords do not match", message: "Confirm password must match password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    func fetchUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            users = try managedContext.fetch(fetchRequest) as! [User]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func storeUser(theUsername: String, theHashedPassword: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
        
        user.username = theUsername
        user.hashedPassword = theHashedPassword
        
        do {
            try managedContext.save()
            users.append(user)
            print("SAVED")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func hash(_ input: String) -> String {
        let hashOutput = SHA256.hash(data: Data(input.utf8))
        
        let hashString = hashOutput.map {String(format: "%02x", $0) }.joined()
        return hashString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userExists = false
        fetchUsers()
    }
}
