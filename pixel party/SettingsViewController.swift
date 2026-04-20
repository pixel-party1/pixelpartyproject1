//
//  SettingsViewController.swift
//  pixel party
//
//  Created by Mitev, Viktor on 16/03/2026.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTitleLabel: UILabel!
    
    @IBAction func toHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "signedIn")
        loginButton.isHidden = false
        registerButton.isHidden = false
        userLabel.isHidden = true
        signOutButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 32)
        
        loginButton.isHidden = true
        registerButton.isHidden = true
        userLabel.isHidden = true
        signOutButton.isHidden = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let signedIn = UserDefaults.standard.bool(forKey: "signedIn")
        let currentUser = UserDefaults.standard.string(forKey: "currentUser")
        
        if (signedIn == true) {
            loginButton.isHidden = true
            registerButton.isHidden = true
            userLabel.isHidden = false
            signOutButton.isHidden = false
            userLabel.text = "User: \(currentUser ?? "")"
        }
        if (signedIn == false) {
            loginButton.isHidden = false
            registerButton.isHidden = false
            userLabel.isHidden = true
            signOutButton.isHidden = true
        }
    }
}
