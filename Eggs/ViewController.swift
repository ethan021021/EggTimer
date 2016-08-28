//
//  ViewController.swift
//  Menu Bars
//
//  Created by Ethan Thomas on 8/28/16.
//  Copyright © 2016 Ethan Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIBarButtonItem!
    @IBOutlet weak var pauseBtn: UIBarButtonItem!
    @IBOutlet weak var subtract10Btn: UIBarButtonItem!
    @IBOutlet weak var add10Btn: UIBarButtonItem!
    @IBOutlet weak var resetBtn: UIBarButtonItem!
    
    var timer: Timer!
    var timerCounter: Int = 210
    var isPaused: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func processTimer() {
        timerCounter -= 1
        timerLabel.text = convertTimer(timer: timerCounter)
    }
    
    func convertTimer(timer: Int) -> String {
        let minutes = (timer % 3600) / 60
        let seconds = (timer % 3600) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @IBAction func startTimerBtnPressed(_ sender: UIBarButtonItem) {
        subtract10Btn.isEnabled = true
        add10Btn.isEnabled = true
        resetBtn.isEnabled = true
        pauseBtn.isEnabled = true
        isPaused = false
        if !isPaused {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.processTimer), userInfo: nil, repeats: true)
        } else {
            let interval: Int
            
            if timerCounter == 0 {
                interval = 1
            } else {
                interval = timerCounter
            }
            
            timer = Timer.scheduledTimer(timeInterval: Double(interval), target: self, selector: #selector(self.processTimer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func pauseTimerBtnPressed(_ sender: UIBarButtonItem) {
        isPaused = true
        timer.invalidate()
    }
    
    @IBAction func resetBtnPressed(_ sender: UIBarButtonItem) {
        timer.invalidate()
        timer = nil
        timerCounter = 210
        timerLabel.text = "3:30"
        subtract10Btn.isEnabled = false
        add10Btn.isEnabled = false
        resetBtn.isEnabled = false
        pauseBtn.isEnabled = false
    }
    
    @IBAction func add10BtnPressed(_ sender: UIBarButtonItem) {
        timerCounter += 10
        
        if isPaused {
            timerLabel.text = convertTimer(timer: timerCounter)
        }
    }
    
    @IBAction func subtract10BtnPressed(_ sender: UIBarButtonItem) {
        if timerCounter == 0 {
            let ac = UIAlertController(title: "Error", message: "Sorry but you cant -10 from 0!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            timerCounter -= 10
            
            if isPaused {
                timerLabel.text = convertTimer(timer: timerCounter)
            }
        }
    }

}

