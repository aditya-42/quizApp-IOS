//
//  ViewController.swift
//  QuizApp
//
//  Created by Aditya Purohit on 05/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    var questionList = QuestionManager.shared

    @IBOutlet weak var startQuiz: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if questionList.questions.isEmpty {
                startQuiz.isEnabled = false
            } else {
                startQuiz.isEnabled = true
            }
        }

    
}


