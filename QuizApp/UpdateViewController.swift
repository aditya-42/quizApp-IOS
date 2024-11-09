//
//  UpdateViewController.swift
//  QuizApp
//
//  Created by Aditya Purohit on 07/11/24.
//

import UIKit

protocol UpdateQuestionDelegate{
    func updateQuestion(index: Int,newQuestion: Question)
    func cancel()
}


class UpdateViewController: UIViewController {
    
    var delegate: UpdateQuestionDelegate?
    var selectedIndex : Int = 0
    
    @IBOutlet weak var questionText: UITextField!
    
    @IBOutlet weak var correctAnswer: UITextField!
    
    @IBOutlet weak var wrongAnswer1: UITextField!
    
    @IBOutlet weak var wrongAnswer2: UITextField!
    
    @IBOutlet weak var wrongAnswer3: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        questionText.text = QuestionManager.shared.questions[selectedIndex].questionText;
        correctAnswer.text = QuestionManager.shared.questions[selectedIndex].answers[0].text;
        wrongAnswer1.text = QuestionManager.shared.questions[selectedIndex].answers[1].text;
        wrongAnswer2.text = QuestionManager.shared.questions[selectedIndex].answers[2].text;
        wrongAnswer3.text = QuestionManager.shared.questions[selectedIndex].answers[3].text;
    }
    

    @IBAction func updateQuestion(_ sender: Any) {
        
        
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
                delegate?.updateQuestion(index: selectedIndex, newQuestion: newQuestion)
                dismiss(animated: true)
            }
            
            
        }
        
        
    }
    
    
    @IBAction func cancelUpdate(_ sender: Any) {
        
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
