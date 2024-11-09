//
//  AddQuestionViewController.swift
//  QuizApp
//
//  Created by Aditya Purohit on 07/11/24.
//

import UIKit

protocol AddQuestionDelegate{
    func saveQuestion(newQuestion: Question)
    func cancel()
}

class AddQuestionViewController: UIViewController {
    
    var delegate : AddQuestionDelegate?
    
    @IBOutlet weak var questionText: UITextField!
    
    
    @IBOutlet weak var correctAnswer: UITextField!
    
    
    @IBOutlet weak var wrongAnswer1: UITextField!
    
    @IBOutlet weak var wrongAnswer2: UITextField!
    
    @IBOutlet weak var wrongAnswer3: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveQuestion(_ sender: Any) {
        
        if let questionText = questionText.text , let correctAnswer = correctAnswer.text,
           let wrongAnswer1 = wrongAnswer1.text,
           let wrongAnswer2 = wrongAnswer2.text,
           let wrongAnswer3 = wrongAnswer3.text

        {
            if !questionText.isEmpty , !correctAnswer.isEmpty, !wrongAnswer1.isEmpty,
               !wrongAnswer2.isEmpty, !wrongAnswer3.isEmpty
            {
                let newQuestion = Question(questionText: questionText, answers: [
                    Answer(text: correctAnswer, isCorrect: true),
                    Answer(text: wrongAnswer1, isCorrect: false),
                    Answer(text: wrongAnswer2, isCorrect: false),
                    Answer(text: wrongAnswer3, isCorrect: false)
                ])
                delegate?.saveQuestion(newQuestion: newQuestion)
                dismiss(animated: true)
            }
            
            
        }
        
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Cancel", message: "Are you sure you want to cancel? ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive,handler: { action in
            self.delegate?.cancel()
            self.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default))
//
       present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
