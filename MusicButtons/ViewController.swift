//
//  ViewController.swift
//  MusicButtons
//
//  Created by Matus on 25/03/2020.
//  Copyright © 2020 Matus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bassButton1: UIButton!
    @IBOutlet weak var bassButton2: UIButton!
    @IBOutlet weak var bassButton3: UIButton!
    
    @IBOutlet weak var drumButton1: UIButton!
    @IBOutlet weak var drumButton2: UIButton!
    @IBOutlet weak var drumButton3: UIButton!
    
    var soundLoop: SoundLoop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.soundLoop = SoundLoop(beatDuration: 1.6)
        self.initializeButtons()
        self.startSoundLoop()
    }
    
    // Set button state
    @IBAction func buttonTap(_ sender: UIButton) {
        let block = self.soundLoop?.getSoundBlock(index: sender.tag)
        if ((block) != nil) {
            block!.nextState()
        }
    }
    
    func initializeButtons() {
        let bass1 = SoundBlock(button: bassButton1, soundName: "bass1")
        let bass2 = SoundBlock(button: bassButton2, soundName: "bass2")
        let bass3 = SoundBlock(button: bassButton3, soundName: "bass3")
        let drum1 = SoundBlock(button: drumButton1, soundName: "drum1")
        let drum2 = SoundBlock(button: drumButton2, soundName: "drum2")
        let drum3 = SoundBlock(button: drumButton3, soundName: "drum3")

        self.soundLoop!.addSoundBlock(SoundBlock: bass1)
        self.soundLoop!.addSoundBlock(SoundBlock: bass2)
        self.soundLoop!.addSoundBlock(SoundBlock: bass3)
        self.soundLoop!.addSoundBlock(SoundBlock: drum1)
        self.soundLoop!.addSoundBlock(SoundBlock: drum2)
        self.soundLoop!.addSoundBlock(SoundBlock: drum3)
    }
    
    func startSoundLoop() {
        self.soundLoop?.start()
    }
    
}

