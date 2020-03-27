//
//  SoundSample.swift
//  MusicButtons
//
//  Created by Matus on 26/03/2020.
//  Copyright © 2020 Matus. All rights reserved.
//
import Foundation
import AVFoundation

class SoundLoop {
    // Interval to loop over buttons
    weak var timer: Timer?
    let numOfBeats = 4
    var soundBlocks: [SoundBlock] = []
    var beatDuration: Double
    var currentBeat: Int?
    
    init(beatDuration: Double) {
        self.beatDuration = beatDuration
    }
    
    func addSoundBlock(SoundBlock: SoundBlock) {
        self.soundBlocks.append(SoundBlock)
    }
    
    func getSoundBlock(index: Int) -> SoundBlock {
        return self.soundBlocks[index]
    }
    
    func start() {
        // Just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: self.beatDuration, repeats: true) { [weak self] _ in
            self?.playSamples()
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func playSamples() {
        if (self.currentBeat == nil) {
            self.currentBeat = 0
        } else {
            self.currentBeat = (self.currentBeat! + 1) % self.numOfBeats
        }
        
        print("Starting beat \(String(describing: self.currentBeat)))")
        for (sample) in self.soundBlocks {
            sample.stopSound()
            if(sample.shouldPlay(beat: self.currentBeat!)) {
                sample.playSound()
            }
        }
    }
    
    // If appropriate, make sure to stop your timer in `deinit`
    deinit {
        stop()
    }
}
