//
//  MemoryMatchHowToPlayViewController.swift
//  pixel party
//
//  Created by Agard, Anna-Maria on 19/03/2026.
//

import UIKit

class MemoryMatchHowToPlayViewController: UIViewController {
    
    
    @IBAction func memoryMatchHowToPlayBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var memoryMatchHowToPlayTitleLabel: UILabel!
    
    
    @IBOutlet weak var memoryMatchInstructionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoryMatchHowToPlayTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
        
        memoryMatchInstructionsLabel.font = UIFont(name: "Kenney-Rocket", size: 18)
        memoryMatchInstructionsLabel.text = """
        🃏 Memory Match 🃏

        1️⃣ Flip cards to reveal their faces
        
        2️⃣ Match pairs to score points ✨
        
        3️⃣ Be quick! 🕒 The faster you match, the higher your score
        
        4️⃣ Match all cards to win 🎉
        
        5️⃣ Have fun! 💥
        """
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
