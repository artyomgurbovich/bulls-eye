//
//  ViewController.swift
//  BullseyeGame
//
//  Created by Artyom Gurbovich on 11/7/19.
//  Copyright © 2019 Artyom Gurbovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var startOverButton: UIButton!
    
    let minSliderValue = 1
    let maxSliderValue = 100
    let defaultSliderValue = 50
    
    var targetValue = 0
    var round = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hitMeButton.layer.cornerRadius = 21
        startOverButton.layer.cornerRadius = 21
        startNewGame()
    }

    @IBAction func hitMePressed(_ sender: UIButton) {
        let guess = Int(slider.value)
        let difference = abs(guess - targetValue)
        var points = maxSliderValue - difference
        let alertTitle: String
        switch difference {
        case 0:
            alertTitle = "Bullseye!"
            points += 100
        case 1..<5:
            alertTitle = "You almost had it!"
            points += 50
        case 5..<20:
            alertTitle = "Good!"
            points += 25
        default:
            alertTitle = "Not even close..."
        }
        score += points
        let alertMessage = "Received \(points) points!"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "New Round", style: .default, handler: { _ in self.startNewRound() })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOverPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Start Over", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { _ in self.startNewGame() })
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
    
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: minSliderValue...maxSliderValue)
        upadteUI()
    }
    
    func upadteUI() {
        slider.setValue(Float(defaultSliderValue), animated: true)
        targetLabel.text = "Put the slider as close as you can to: \(targetValue)"
        scoreLabel.text = "Score: \(score)"
        roundLabel.text = "Round: \(round)"
    }
}
