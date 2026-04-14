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
    
    @IBOutlet weak var mazeGameEasyModeTimer: UILabel!
    
    var timer: Timer?
    var timerCount = 0
    
    
    @IBOutlet weak var easyMazeBoardView: UIView!
    
    //maze definition (to be changed when logic is finished)
    let easyMaze = [
        "#######",
        "#S.#.G#",
        "#..#..#",
        "#..#..#",
        "#.....#",
        "#...#.#",
        "#...#.#",
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
        //
        easyMazeBoardView.subviews.forEach({$0.removeFromSuperview()})
        
        let rows = easyMaze.count
        let cols = easyMaze[0].count
        
        // makes the frame more square
        // CGFloat - used in iOS for sizes, positions and layout measurements. It measures items on screen so in this case it would measure the maze board
        let tileSize = min(easyMazeBoardView.bounds.width / CGFloat(cols), easyMazeBoardView.bounds.height / CGFloat(rows))
        
        let totalWidth = tileSize * CGFloat(cols)
        let totalHeight = tileSize * CGFloat(rows)
        
        //xOffset and yOffset are used to centre the maze inside easyMazeBoardView. They calculate the extra space left in the view and divide it by 2 so the maze appears centred both horizontally and vertically.
        let xOffset = (easyMazeBoardView.bounds.width - totalWidth) / 2
        let yOffset = (easyMazeBoardView.bounds.height - totalHeight) / 2
        
        for row in 0..<rows {
            let currentRow = Array(easyMaze[row])
            
            for col in 0..<cols {
                let x = xOffset + CGFloat(col) * tileSize
                let y = yOffset + CGFloat(row) * tileSize
                
                let tileView = UIView(frame: CGRect(x: x, y: y, width: tileSize, height: tileSize))
                
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
        
        let playerX = xOffset + CGFloat(playerCol) * tileSize + 5
        let playerY = yOffset + CGFloat(playerRow) * tileSize + 5
        
        let playerView = UIView(frame: CGRect(x: playerX, y: playerY, width: tileSize - 10, height: tileSize - 10))
        playerView.backgroundColor = .systemBlue
        playerView.layer.cornerRadius = min(tileSize - 10, tileSize - 10) / 2
        
        easyMazeBoardView.addSubview(playerView)
    }
    //swiping gesture recognistion
    
    //checking if the player ran into a wall
    func isWall(row: Int, col: Int) -> Bool{
        if row < 0 || row >= easyMaze.count{
            return true
        }
        
        let currentRow = Array(easyMaze[row])
        
        if col < 0 || col >= currentRow.count {
            return true
        }
        
        return currentRow[col] == "#"
    }
    
    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        slideUp()
        drawEasyMaze()
        checkWin()
    }
    
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        slideDown()
        drawEasyMaze()
        checkWin()
        print("swipe detected")
    }
    
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        slideLeft()
        drawEasyMaze()
        checkWin()
    }
    
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        slideRight()
        drawEasyMaze()
        checkWin()
    }
    
    // each individual slide function
    func slideUp(){
        while !isWall(row: playerRow - 1, col: playerCol) {
            playerRow = playerRow - 1
        }
    }
    
    func slideDown(){
        while !isWall(row: playerRow + 1, col: playerCol) {
            playerRow = playerRow + 1
        }
    }
    func slideLeft(){
        while !isWall(row: playerRow, col: playerCol - 1) {
            playerCol = playerCol - 1
        }
    }
    
    func slideRight(){
        while !isWall(row: playerRow, col: playerCol + 1) {
            playerCol = playerCol + 1
        }
    }
    
    // actually seeing if the player has reached the goal
    func checkWin() {
        let currentRow = Array(easyMaze[playerRow])
        let character = currentRow[playerCol]
        
        if character == "G"{
            let alert = UIAlertController(title: "YOU WIN!!", message: "Easy Maze complete", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        drawEasyMaze()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mazeGameEasyModeTimer.text = "00"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        //function to find the start position
        findStartPosition()
    }
    
    @objc func timerFired() {
        timerCount += 1
        
        let seconds = timerCount % 60
        let minutes = timerCount / 60
        
        mazeGameEasyModeTimer.text = String(format: "%02d:%02d", minutes, seconds)

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

