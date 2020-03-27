//
//  SoundBlock.swift
//  MusicButtons
//
//  Created by Matus on 27/03/2020.
//  Copyright © 2020 Matus. All rights reserved.
//
import UIKit
import Foundation
import AVFoundation

class SoundBlock {
    var button: UIButton?
    var soundName: String?
    
    // State explanation
    // 0 - Doesn't play
    // 1 - Plays on all beats
    // 2 - Plays on 1st and 3rd beat
    // 3 - Plays on 1st beat
    let STATES = [0, 1, 2, 3]
    var state: Int = 0
    var audioPlayer: AVAudioPlayer?
    
    init(button: UIButton, soundName: String) {
        self.button = button
        self.soundName = soundName
    }
    
    func playSound() {
        let soundURL = Bundle.main.url(forResource: self.soundName, withExtension: "wav")
        audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer?.play()
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
    
    func getState() -> Int {
        return self.state
    }
    
    func nextState() {
        let maxState = self.STATES.count
        self.state = (self.state + 1) % maxState
        self.updateTitle()
        print(self.state)
    }
    
    func updateTitle() {
        let state = self.getState()
        var title: String?
        switch state {
        case 0:
            title = ""
        case 1:
            title = "1"
        case 2:
            title = "2/4"
        case 3:
            title = "1/4"
        default:
            title = ""
        }
        self.button?.setTitle(title, for: .normal)
    }
    
    func shouldPlay(beat: Int) -> Bool {
        // Play on every beat
        if(self.state == 1) {
            return true
        }
        // Play on 1st and 3rd beat
        if(self.state == 2 && (beat == 0 || beat == 2)) {
            return true
        }
        // Play on 1st and 3rd beat
        if (self.state == 3 && beat == 0) {
            return true
        }
        return false
    }
}
