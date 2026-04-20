//
//  SlidingPuzzleMainMenuViewController.swift
//  pixel party
//
//  Created by Matthew Green on 2026/04/20.
//

import UIKit

class SlidingPuzzleMainMenuViewController: UIViewController {
    
    
    @IBAction func slidingPuzzleMainMenuHomeButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var slidingPuzzleTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slidingPuzzleTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
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
