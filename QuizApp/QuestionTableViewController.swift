//
//  QuestionBankViewController.swift
//  QuizApp
//
//  Created by Aditya Purohit on 07/11/24.
//

import UIKit

class QuestionTableViewController: UITableViewController, AddQuestionDelegate, UpdateQuestionDelegate {
    
    func updateQuestion(index: Int, newQuestion: Question) {
        print(index)
        QuestionManager.shared.questions[index] = newQuestion
        tableView.reloadData()
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionManager.shared.questions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableViewCell
        
        let question = QuestionManager.shared.questions[indexPath.row]
        cell.questionText.text = question.questionText
        
        let answers = question.answers
        let answerLabels = [cell.answer1, cell.answer2, cell.answer3, cell.answer4]
        
        for label in answerLabels {
            label?.backgroundColor = UIColor.clear
        }
        
        for (index, label) in answerLabels.enumerated() {
            if index < answers.count {
                let answer = answers[index]
                label?.text = answer.text
                label?.backgroundColor = answer.isCorrect ? UIColor.green : UIColor.red
            }
        }
        
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveQuestion(newQuestion: Question) {
        QuestionManager.shared.addNewQuestion(q: newQuestion)
        tableView.reloadData()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addQuestion"{
            var avc = segue.destination as! AddQuestionViewController
            avc.delegate = self
        }
        else if segue.identifier == "toUpdate"{
            var uvc = segue.destination as! UpdateViewController
            uvc.selectedIndex = tableView.indexPathForSelectedRow!.row
            uvc.delegate = self
        }
        
    }
    
    func cancel() {
        
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
