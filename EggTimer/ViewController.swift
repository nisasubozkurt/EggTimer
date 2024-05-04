//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes: [String:Int] = ["Soft":3, "Medium":4, "Hard":7] // uygulamayı test etmeniz için verilen sürelerdir. Normal şartlarda 300-420-720 saniyelerdir.
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!//hiç bir zaman nil gelmeyecek
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
        @objc func updateTimer(){
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed)/Float(totalTime)
                print(Float(secondsPassed) / Float(totalTime))
                
            } else {
                timer.invalidate()
                titleLabel.text = "DONE!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
    }
