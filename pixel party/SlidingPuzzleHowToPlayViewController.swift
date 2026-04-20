//
//  SlidingPuzzleHowToPlayViewController.swift
//  pixel party
//
//  Created by Matthew Green on 2026/04/20.
//

import UIKit

class SlidingPuzzleHowToPlayViewController: UIViewController {
    
    
    
    @IBOutlet weak var slidingPuzzleHowToPlayLabel: UILabel!
    @IBOutlet weak var slidingPuzzleInstructionsLabel: UILabel!
    @IBAction func slidingPuzzleHowToPlayHomeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slidingPuzzleHowToPlayLabel.font = UIFont(name: "Kenney-Rocket", size: 28)
        
        slidingPuzzleInstructionsLabel.font = UIFont(name: "Kenney-Rocket", size: 18)
        slidingPuzzleInstructionsLabel.text = """
        +--------------------------------------+
        |          SLIDING PUZZLE              |
        +--------------------------------------+

         1) Tap a tile next to the empty
            space to slide it into place

         2) Only tiles touching the blank
            space can move

         3) Each move shifts the puzzle
            around the empty space

         4) Rearrange all tiles to rebuild
            the picture

         5) Solve the puzzle to win!

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
