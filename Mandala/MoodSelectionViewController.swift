//
//  ViewController.swift
//  Mandala
//
//  Created by Adrian Lesniak on 27/02/2021.
//

import UIKit

class MoodSelectionViewController: UIViewController {

    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    var moodsConfigurable: MoodsConfigurable!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
        
            moodSelector.images = moods.map { $0.image }
            moodSelector.highlightColors = moods.map { $0.color }
        }
    }
    
    var currentMood: Mood? {
        didSet {
            
            guard let currentMood = currentMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil
                return
            }
            
            addMoodButton.setTitle("I'm \(currentMood.name)", for: .normal)
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                self.addMoodButton?.backgroundColor = currentMood.color
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .meh]
    }
    
    @IBAction private func moodSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex

        currentMood = moods[selectedIndex]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "embedContainerViewController" {
            
            guard let moodConfigurable = segue.destination as? MoodsConfigurable else {
                return
            }
            
            self.moodsConfigurable = moodConfigurable
            
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
            
        }
    }
    @IBAction func addMoodTapped(_ sender: Any) {
        
        guard let currentMood = currentMood else {
            return
        }
        
        self.moodsConfigurable.add(MoodEntry(mood: currentMood, timestamp: Date()))
    }
    
}

