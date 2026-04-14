//
//  PuzzleBoard.swift
//  pixel party
//
//  Created by Mitev, Viktor on 18/03/2026.
//

import Foundation

struct PuzzleBoard {
    
    // MARK: - Properties
    let size: Int
    var tiles: [Int]
    var moveCount: Int
    var undoStack: [[Int]] = []  // stores previous tile states
    var redoStack: [[Int]] = []  // stores undone tile states
    
    // MARK: - Init
    init(size: Int) {
        self.size = size
        self.tiles = Array(1..<(size * size)) + [0] //Array(1..<9) gives you [1,2,3,4,5,6,7,8] for a 3×3, then you append 0 for the blank. That's the solved state.
        self.moveCount = 0
    }
    
    // MARK: - Computed
    var blankIndex: Int {
        return tiles.firstIndex(of: 0)! //"!" force unwrap, safe here because there will always be exactly one 0 in the array
    }
    
    var isSolved: Bool {
        let goal = Array(1..<(size * size)) + [0]
        return tiles == goal
    }
    
    // MARK: - Helpers
    //Helper functions to find the row and col of a square given its index in the tiles array.
    func row(of index: Int) -> Int { return index / size }
    func col(of index: Int) -> Int { return index % size }
    
    // MARK: - Game Logic
    func movableTileIndices() -> [Int] {
        let b = blankIndex
        let r = row(of: b)
        let c = col(of: b)
        var neighbours: [Int] = []

        if r > 0        { neighbours.append((r - 1) * size + c) } // above
        if r < size - 1 { neighbours.append((r + 1) * size + c) } // below
        if c > 0        { neighbours.append(r * size + (c - 1)) } // left
        if c < size - 1 { neighbours.append(r * size + (c + 1)) } // right

        return neighbours
    }
    
    //Checks if that tile is allowed to move. If it is, it slides it into the blank space and adds 1 to the move counter. It also reports back yes it worked or no it didn't.
    mutating func moveTile(at index: Int) -> Bool {
        guard movableTileIndices().contains(index) else { return false }
        tiles.swapAt(index, blankIndex)
        moveCount += 1
        return true
    }
    
    mutating func shuffle(steps: Int = 50) {
        tiles = Array(1..<(size * size)) + [0]
        moveCount = 0
        var lastBlankIndex = -1
        for _ in 0..<steps {
            var candidates = movableTileIndices()
            if candidates.count > 1 {
                candidates = candidates.filter { $0 != lastBlankIndex }
            }
            let chosen = candidates.randomElement()!
            lastBlankIndex = blankIndex
            tiles.swapAt(chosen, blankIndex)
        }
        moveCount = 0 // reset move count — shuffling isn't a player action
    }
    mutating func saveStateForUndo(limit: Int = 3) {
        undoStack.append(tiles)
        if undoStack.count > limit { undoStack.removeFirst() }
        redoStack.removeAll() // a new move wipes the redo history
    }

    mutating func undo() -> Bool {
        guard let previous = undoStack.popLast() else { return false }
        redoStack.append(tiles)
        tiles = previous
        return true
    }

    mutating func redo() -> Bool {
        guard let next = redoStack.popLast() else { return false }
        undoStack.append(tiles)
        tiles = next
        return true
    }
}
