//
//  MazeGameMediumModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameMediumModeViewController: UIViewController {
    var medGameEnded = false
    var mediumMaze: [String] = []
    
    @IBAction func mediumModeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //maze definition (to be changed when logic is finished)
    let mediumMazes = [[
        "#########",
        "#S..##..#",
        "#....#..#",
        "#..#....#",
        "##..#..##",
        "#.......#",
        "##.#..#.#",
        "#...##G.#",
        "#########",
    ],[
        "#########",
        "#.#....##",
        "#....#..#",
        "#.#.....#",
        "#...#...#",
        "#.....#.#",
        "#.##.##.#",
        "##G.....#",
        "#S...#..#",
        "#########",
    ]
    ]
    
    
    // player position variables
    var playerRow = 0
    var playerCol = 0
    
    //find start position (where it says S on maze)
    func findStartPosition() {
        for row in 0..<mediumMaze.count {
            let currentRow = Array(mediumMaze[row])
            
            for col in 0..<currentRow.count {
                if currentRow[col] == "S" {
                    playerRow = row
                    playerCol = col
                    return
                }
            }
        }
    }
    
    
    @IBOutlet weak var mazeGameMediumModeTimer: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    
    @IBOutlet weak var mediumMazeBoardView: UIView!
    
    func drawMediumMaze(){
        // subviews -  (explaination to be added)
        mediumMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        // Ensure start position is set before drawing
        if playerRow == 0 && playerCol == 0 {
            findStartPosition()
        }
        
        let rows = mediumMaze.count
        let cols = mediumMaze[0].count
        
        // makes the frame more square
        let tileSize = min(mediumMazeBoardView.bounds.width / CGFloat(cols), mediumMazeBoardView.bounds.height / CGFloat(rows))
        
        let totalWidth = tileSize * CGFloat(cols)
        let totalHeight = tileSize * CGFloat(rows)
        
        let xOffset = (mediumMazeBoardView.bounds.width - totalWidth) / 2
        let yOffset = (mediumMazeBoardView.bounds.height - totalHeight) / 2
        
        for row in 0..<rows {
            let currentRow = Array(mediumMaze[row])
            
            for col in 0..<cols {
                let x = xOffset + CGFloat(col) * tileSize
                let y = yOffset + CGFloat(row) * tileSize
                
                let tileView = UIView(frame: CGRect(x: x, y: y, width: tileSize, height: tileSize))
                
                let character = currentRow[col]
                if character == "#" {
                    tileView.backgroundColor = .black
                } else if character == "G" {
                    tileView.backgroundColor = .yellow
                } else {
                    tileView.backgroundColor = .lightGray
                }
                
                tileView.layer.borderWidth = 1
                tileView.layer.borderColor = UIColor.black.cgColor
                
                mediumMazeBoardView.addSubview(tileView)
            }
        }
        
        let playerX = xOffset + CGFloat(playerCol) * tileSize + 5
        let playerY = yOffset + CGFloat(playerRow) * tileSize + 5
        
        let playerView = UIView(frame: CGRect(x: playerX, y: playerY, width: tileSize - 10, height: tileSize - 10))
        playerView.backgroundColor = .systemBlue
        playerView.layer.cornerRadius = min(tileSize - 10, tileSize - 10) / 2
        
        mediumMazeBoardView.addSubview(playerView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawMediumMaze()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let randomMaze = mediumMazes.randomElement() {
                mediumMaze = randomMaze
            }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        mazeGameMediumModeTimer.text = String(format: "%02d:%02d", minutes, seconds)

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
