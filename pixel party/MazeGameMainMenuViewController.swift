//
//  MazeGameMainMenuViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameMainMenuViewController: UIViewController {
    
    
    @IBAction func mazeGameMainMenuHomeButtonPressed(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true)
    }
    
    
    @IBOutlet weak var mazeGameTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mazeGameTitleLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
        


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
