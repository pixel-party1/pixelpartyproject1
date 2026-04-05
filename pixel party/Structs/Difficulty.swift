//
//  Difficulty.swift
//  pixel party
//
//  Created by Mitev, Viktor on 18/03/2026.
//

import UIKit

struct Difficulty {
    let gridSize: Int
    let title: String
    let shuffleSteps: Int

    static let easy   = Difficulty(gridSize: 3, title: "Easy  3×3",   shuffleSteps: 50)
    static let medium = Difficulty(gridSize: 6, title: "Medium  4x4", shuffleSteps: 100)
    static let hard   = Difficulty(gridSize: 8, title: "Hard  6x6",   shuffleSteps: 200)
}
