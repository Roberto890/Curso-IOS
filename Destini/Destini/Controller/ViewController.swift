//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var brainStory = StoryBrain()
    var choice1Destination = 0
    var choice2Destination = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUpdate()

    }

    @IBAction func choiceMade(_ sender: UIButton) {
        let userChoice = sender.tag
        if userChoice == 1{
            brainStory.nextStory(next: choice1Destination)
        }else{
            brainStory.nextStory(next: choice2Destination)
        }
        
        UIUpdate()
    }
    
    func UIUpdate(){
        let story = brainStory.getStory()
        storyLabel.text = story.title
        choice1Button.setTitle(story.choice1, for: .normal)
        choice2Button.setTitle(story.choice2, for: .normal)
        choice1Destination = story.choice1Destination
        choice2Destination = story.choice2Destination
    }
    
}

