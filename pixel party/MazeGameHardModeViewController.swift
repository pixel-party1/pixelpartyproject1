//
//  MazeGameHardModeViewController.swift
//  pixel party
//
//  Created by Tatyana Leahy on 05/04/2026.
//

import UIKit

class MazeGameHardModeViewController: UIViewController {
    var hardGameEnded = false
    
    @IBAction func hardModeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mazeGameHardModeTimer: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    @IBOutlet weak var hardMazeBoardView: UIView!
    let hardMaze = [
        "############",
        "#S..##....##",
        "#....#G##..#",
        "#..#.....#.#",
        "##....#..#.#",
        "#...##..#..#",
        "#....#.#.#.#",
        "#.#......#.#",
        "#....#..#..#",
        "#.....#..#.#",
        "#...#..#...#",
        "##..#...#.##",
        "#..........#",
        "############",
        
    ]
    var playerRow = 0
    var playerCol = 0
    
    //find start position (where it says S on maze)
    func findStartPosition() {
        for row in 0..<hardMaze.count {
            let currentRow = Array(hardMaze[row])
            
            for col in 0..<currentRow.count {
                if currentRow[col] == "S" {
                    playerRow = row
                    playerCol = col
                    return
                }
            }
        }
    }
    
    func drawHardMaze(){
        // subviews -  (explaination to be added)
        hardMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        // Ensure start position is set before drawing
        if playerRow == 0 && playerCol == 0 {
            findStartPosition()
        }
        
        let rows = hardMaze.count
        let cols = hardMaze[0].count
        
        // makes the frame more square
        let tileSize = min(hardMazeBoardView.bounds.width / CGFloat(cols), hardMazeBoardView.bounds.height / CGFloat(rows))
        
        let totalWidth = tileSize * CGFloat(cols)
        let totalHeight = tileSize * CGFloat(rows)
        
        let xOffset = (hardMazeBoardView.bounds.width - totalWidth) / 2
        let yOffset = (hardMazeBoardView.bounds.height - totalHeight) / 2
        
        for row in 0..<rows {
            let currentRow = Array(hardMaze[row])
            
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
                
                hardMazeBoardView.addSubview(tileView)
            }
        }
        
        let playerX = xOffset + CGFloat(playerCol) * tileSize + 5
        let playerY = yOffset + CGFloat(playerRow) * tileSize + 5
        
        let playerView = UIView(frame: CGRect(x: playerX, y: playerY, width: tileSize - 10, height: tileSize - 10))
        playerView.backgroundColor = .systemBlue
        playerView.layer.cornerRadius = min(tileSize - 10, tileSize - 10) / 2
        
        hardMazeBoardView.addSubview(playerView)
    }
    
    // wall check
    func isWall(row: Int, col: Int) -> Bool{
        if row < 0 || row >= hardMaze.count{
            return true
        }
        
        let currentRow = Array(hardMaze[row])
        
        if col < 0 || col >= currentRow.count {
            return true
        }
        
        return currentRow[col] == "#"
    }
    
    //
    func checkWin() {
        let currentRow = Array(hardMaze[playerRow])
        let character = currentRow[playerCol]
        
        if character == "G"{
            hardGameEnded = true
            timer?.invalidate()
            let alert = UIAlertController(title: "YOU WIN!!", message: "Easy Maze complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawHardMaze()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findStartPosition()
        drawHardMaze()
        // Do any additional setup after loading the view.
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        mazeGameHardModeTimer.text = String(format: "%02d:%02d", minutes, seconds)

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
