//
//  MemoryMatchPlayViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchPlayViewController: UIViewController {
    
    
    @IBAction func memoryMatchPlayBackButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var memoryMatchSelectDifficultyLabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()

        memoryMatchSelectDifficultyLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
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
