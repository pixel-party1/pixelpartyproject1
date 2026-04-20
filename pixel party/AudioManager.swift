//
//  AudioManager.swift
//  pixel party
//
//  Created by Matthew Green on 2026/04/20.
//

import Foundation
import AVFoundation

class AudioManager {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error")
        }
    }
    
    
    static let shared = AudioManager()
    
    private var musicPlayer: AVAudioPlayer?
    private var sfxPlayer: AVAudioPlayer?
    private var sfxPlayers: [AVAudioPlayer] = []
    
    var isMusicOn = true
    var isSfxOn = true
    
    func playMusic() {
        guard isMusicOn else { return }
        
        guard let url = Bundle.main.url(
            forResource: "the-return-of-the-8-bit-era-301292",
            withExtension: "mp3"
        ) else { return }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.play()
        } catch {
            print("Error playing music")
        }
    }
    
    func stopMusic() {
        musicPlayer?.stop()
    }
    
    private func playSFX(_ name: String) {
        guard isSfxOn else { return }
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: url)
            sfxPlayer?.play()
        } catch {
            print("Error playing SFX")
        }
    }
    
    func playButtonClick() {
        guard isSfxOn else { return }
        
        guard let url = Bundle.main.url(
            forResource: "202311__7778__button-1",
            withExtension: "mp3"
        ) else { return }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            sfxPlayers.append(player)   // 👈 KEEP IT ALIVE
            player.play()
        } catch {
            print("Error playing SFX")
        }
    }
    
    func playSlide() {
        playSFX("677373__robinhood76__12012-buttlet-swish")
    }
    
    func playCardFlip() {
        playSFX("344403__jawbutch__knife-swish-1")
    }
    
    func playWin() {
        playSFX("274182__littlerobotsoundfactory__jingle_win_synth_05")
    }
}
