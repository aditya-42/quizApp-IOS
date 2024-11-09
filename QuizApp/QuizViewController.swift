//
//  Question.swift
//  QuizApp
//
//  Created by Aditya Purohit on 07/11/24.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var questionList = QuestionManager.shared
    var selectedAnswers: [String?] = []
    var answeredQuestions: [Bool] = []
    
    @IBOutlet weak var questionNumber: UILabel!
    var selectedIndex: Int = 0

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var optionsTable: UITableView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        optionsTable.dataSource = self
        optionsTable.delegate = self
        
        questionList.shuffleAllAnswers()
        
        selectedAnswers = Array(repeating: nil, count: questionList.questions.count)
        answeredQuestions = Array(repeating: false, count: questionList.questions.count)

//        submitButton.isHidden = true
        updateQuestion()
    }
    
    func updateQuestion() {
        let currentQuestion = questionList.questions[selectedIndex]
        
        questionText.text = currentQuestion.questionText
        questionNumber.text = "\(selectedIndex + 1)/\(questionList.questions.count)"
        
        progressBar.progress = Float(selectedIndex + 1) / Float(questionList.questions.count)
        
        optionsTable.reloadData()
        
        if let selectedAnswer = selectedAnswers[selectedIndex], selectedAnswer != "" {
            answeredQuestions[selectedIndex] = true
        } else {
            answeredQuestions[selectedIndex] = false
        }
        
        if selectedIndex == questionList.questions.count - 1 && !answeredQuestions.contains(false) {
            //submitButton.isHidden = false
        } else {
            //submitButton.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.questions[selectedIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        let question = questionList.questions[selectedIndex]
        let answer = question.answers[indexPath.row]
        
        cell.textLabel?.text = answer.text
        
        if selectedAnswers[selectedIndex] == answer.text {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let question = questionList.questions[selectedIndex]
        let selectedAnswer = question.answers[indexPath.row].text
        
        selectedAnswers[selectedIndex] = selectedAnswer
        answeredQuestions[selectedIndex] = true
        tableView.reloadData()
        
        if selectedIndex == questionList.questions.count - 1 && !answeredQuestions.contains(false) {
                   //submitButton.isHidden = false
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if selectedIndex < questionList.questions.count - 1 {
            selectedIndex += 1
            updateQuestion()
        } else {
            print("Quiz Completed")
        }
    }
    
    @IBAction func prevPressed(_ sender: Any) {
        if selectedIndex > 0 {
            selectedIndex -= 1
            updateQuestion()
        } else {
            print("First question")
        }
    }
    
//    @IBAction func submitPressed(_ sender: Any) {
//        var score = 0
//        
//        if answeredQuestions.contains(false) {
//            let alert = UIAlertController(title: "Error", message: "Please answer all questions before submitting.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
//        
//        for (index, selectedAnswerText) in selectedAnswers.enumerated() {
//            guard let selectedAnswerText = selectedAnswerText else { continue }
//            
//            let currentQuestion = questionList.questions[index]
//
//            if let selectedAnswer = currentQuestion.answers.first(where: { $0.text == selectedAnswerText }) {
//                if currentQuestion.isAnswerCorrect(selectedAnswer: selectedAnswer) {
//                    score += 1
//                }
//            }
//        }
//        
//        let average = (Float(score) / Float(questionList.questions.count)) * 100
//        
//        performSegue(withIdentifier: "showScore", sender: ["score": score, "totalQuestions": questionList.questions.count, "average": average])
//    }
    
    
    func submitQuiz() -> Int{
        var score = 0
        
        if answeredQuestions.contains(false) {
            let alert = UIAlertController(title: "Error", message: "Please answer all questions before submitting.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        for (index, selectedAnswerText) in selectedAnswers.enumerated() {
            guard let selectedAnswerText = selectedAnswerText else { continue }
            
            let currentQuestion = questionList.questions[index]

            if let selectedAnswer = currentQuestion.answers.first(where: { $0.text == selectedAnswerText }) {
                if currentQuestion.isAnswerCorrect(selectedAnswer: selectedAnswer) {
                    score += 1
                }
            }
        }
        
        return score
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showScore" {
               if let destinationVC = segue.destination as? ScoreViewController {
                        destinationVC.score = submitQuiz()
                   }
               }
               
           }
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    


    


    
    
   



    


