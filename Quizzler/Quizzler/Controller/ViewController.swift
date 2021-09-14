//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var quizBrain = QuizBrain()
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! //True or False
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
       
        if userGotItRight == true {
            sender.backgroundColor = UIColor.green
        }else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()

//        questionNumber = Int.random(in: 0..<quiz.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateUI()
        }
    }
 
    func updateUI(){
        let answers = quizBrain.getAnswers()
        btnAnswer1.setTitle(answers[0], for: .normal)
        btnAnswer2.setTitle(answers[1], for: .normal)
        btnAnswer3.setTitle(answers[2], for: .normal)
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        lblScore.text = "Score: \(quizBrain.getScore())"
        btnAnswer1.backgroundColor = UIColor.clear
        btnAnswer2.backgroundColor = UIColor.clear
        btnAnswer3.backgroundColor = UIColor.clear
        
    }
    
}

