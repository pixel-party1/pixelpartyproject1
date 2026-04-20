//
//  MazeGameHowToPlayViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameHowToPlayViewController: UIViewController {

    @IBAction func howToPlayButtonTapped(_ sender: Any) {
        AudioManager.shared.playButtonClick()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var mazeGameHowToTitle: UILabel!
    
    
    @IBOutlet weak var mazeGameHowTo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mazeGameHowToTitle.font = UIFont(name: "Kenney-Rocket", size: 28)
        

        
        mazeGameHowTo.font = UIFont(name: "Kenney-Rocket", size: 18)
        mazeGameHowTo.text = """
        +--------------------------------------+
        |            MAZE SLIDER               |
        +--------------------------------------+

         1) Slide in a direction and keep
            moving until you hit a wall

         2) Plan your moves carefully —
            you cannot stop mid-slide

         3) Reach the yellow block to win

         4) Avoid getting stuck in tricky
            spots

         5) Have fun!

        +--------------------------------------+
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
