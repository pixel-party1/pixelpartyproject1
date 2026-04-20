//
//  GameSelectViewController.swift
//  pixel party
//
//  Created by Mitev, Viktor on 03/03/2026.
//

import UIKit

class GameSelectViewController: UIViewController {
    

    @IBAction func toHome(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var selectGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectGameLabel.font = UIFont(name: "Kenney-Rocket", size: 32)
    
    }
}

    
