//
//  AudioManager.swift
//  pixel party
//
//  Created by Matthew Green on 2026/04/20.
//

import Foundation

import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // loop forever
            player?.play()
        } catch {
            print("Error playing music")
        }
    }
    
    func stopMusic() {
        player?.stop()
    }
}
