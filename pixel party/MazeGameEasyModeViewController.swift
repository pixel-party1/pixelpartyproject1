//
//  MazeGameEasyModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameEasyModeViewController: UIViewController {

    // adding the buttons or links needed
    @IBAction func easyModeButtonTapped(_ sender: Any) {dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var easyMazeBoardView: UIView!
    
    //maze definition (to be changed when logic is finished)
    let easyMaze = [
        "#######",
        "#S.#.G#",
        "#.....#",
        "#######",
    ]
    
    // player position variables
    var playerRow = 0
    var playerCol = 0
    
    //find start position (where it says S on maze)
    func findStartPosition() {
        for row in 0..<easyMaze.count {
            let currentRow = Array(easyMaze[row])
            
            for col in 0..<currentRow.count {
                if currentRow[col] == "S" {
                    playerRow = row
                    playerCol = col
                    return
                }
            }
        }
    }
    
   // maze drawing function
    func drawEasyMaze() {
        easyMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        let rows = easyMaze.count
        let cols = easyMaze[0].count
        
        let tileWidth = easyMazeBoardView.bounds.width / CGFloat(cols)
        let tileHeight = easyMazeBoardView.bounds.height / CGFloat(rows)
        
        for row in 0..<rows {
            let currentRow = Array(easyMaze[row])
            
            for col in 0..<cols {
                let x = CGFloat(col) * tileWidth
                let y = CGFloat(row) * tileHeight
                
                let tileView = UIView(frame: CGRect(x: x, y: y, width: tileWidth, height: tileHeight))
                
                let character = currentRow[col]
                if character == "#"{
                    tileView.backgroundColor = .black
                } else if character == "G"{
                    tileView.backgroundColor = .yellow
                } else {
                    tileView.backgroundColor = .lightGray
                }
                
                tileView.layer.borderWidth = 1
                tileView.layer.borderColor = UIColor.black.cgColor
                
                easyMazeBoardView.addSubview(tileView)
            }
        }
        
        let playerX = CGFloat(playerCol) * tileWidth + 5
        let playerY = CGFloat(playerRow) * tileHeight + 5
        
        let playerView = UIView(frame: CGRect(x: playerX, y: playerY, width: tileWidth - 10, height: tileHeight - 10))
        playerView.backgroundColor = .systemBlue
        playerView.layer.cornerRadius = min(tileWidth - 10, tileHeight - 10) / 2
        
        easyMazeBoardView.addSubview(playerView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawEasyMaze()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //function to find the start position
        findStartPosition()
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

