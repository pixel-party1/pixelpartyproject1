//
//  BoardView.swift
//  pixel party
//
//  Created by Mitev, Viktor on 18/03/2026.
//

import UIKit

final class BoardView: UIView {

    // MARK: - Properties
    
    // The closure GameViewController assigns to know which tile was tapped
    var onMove: ((Int) -> Void)?
    
    // Flat array of tile views, matches the order of PuzzleBoard.tiles
    private var tileViews: [TileView] = []
    
    // We need to know the grid size to calculate tile frames and convert touch positions
    private var gridSize: Int = 3
    
    // Gap between tiles in points
    private let gap: CGFloat = 6

    // MARK: - Setup
    
    // Called once from GameViewController after the board is created.
    // Builds all the TileViews and positions them in the grid.
    func setup(board: PuzzleBoard) {
        // Remove any existing tiles first (important when reshuffling)
        subviews.forEach { $0.removeFromSuperview() }
        tileViews.removeAll()
        gridSize = board.size

        let ts = tileSize()

        for i in 0..<(gridSize * gridSize) {
            let tile = TileView()
            tile.value = board.tiles[i]
            tile.frame = frameFor(index: i, tileSize: ts)
            addSubview(tile)
            tileViews.append(tile)
        }
    }

    // MARK: - Refresh
    
    // Instantly updates every tile's value and position.
    // Used after a move or shuffle — no animation.
    func refresh(board: PuzzleBoard) {
        let ts = tileSize()
        for (i, tile) in tileViews.enumerated() {
            tile.value = board.tiles[i]
            tile.frame = frameFor(index: i, tileSize: ts)
        }
    }

    // MARK: - Touch Handling
    
    // touchesBegan fires the moment a finger touches the screen.
    // We convert the touch point into a row/col, then into a board index,
    // and pass that index up to GameViewController via the onMove closure.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)

        let ts = tileSize()
        let col = Int(point.x / (ts + gap))
        let row = Int(point.y / (ts + gap))

        // Ignore taps outside the valid grid area
        guard row >= 0, row < gridSize, col >= 0, col < gridSize else { return }

        let index = row * gridSize + col
        onMove?(index)
    }

    // MARK: - Layout Helpers
    
    // Calculates how wide/tall each tile should be to fill the view evenly
    private func tileSize() -> CGFloat {
        return (min(bounds.width, bounds.height) - gap * CGFloat(gridSize + 1)) / CGFloat(gridSize)
    }

    // Returns the CGRect frame for a tile at a given flat index
    private func frameFor(index: Int, tileSize: CGFloat) -> CGRect {
        let row = index / gridSize
        let col = index % gridSize
        let x = gap + CGFloat(col) * (tileSize + gap)
        let y = gap + CGFloat(row) * (tileSize + gap)
        return CGRect(x: x, y: y, width: tileSize, height: tileSize)
    }

    // Re-layout tiles if the view is resized (e.g. rotation)
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !tileViews.isEmpty else { return }
        let ts = tileSize()
        for (i, tile) in tileViews.enumerated() {
            tile.frame = frameFor(index: i, tileSize: ts)
        }
    }
}
