//
//  MazeGameHowToPlayViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameHowToPlayViewController: UIViewController {

    @IBAction func howToPlayButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mazeGameHowTo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mazeGameHowTo.numberOfLines = 0
        
        mazeGameHowTo.text="""
            Welcome to the Maze Game!!!
            
            The idea is simple,
            
            You want to get to the gold block but be warned when you slide you go all the way to the wall!
            
            Your moves are counted and there will be a timer so be quick!
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
