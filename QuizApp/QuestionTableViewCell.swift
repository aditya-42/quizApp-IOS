//
//  QuestionTableViewCell.swift
//  QuizApp
//
//  Created by Aditya Purohit on 07/11/24.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {


    @IBOutlet weak var questionText: UILabel!
    
    
    @IBOutlet weak var answer1: UILabel!
    
    @IBOutlet weak var answer2: UILabel!
    
    @IBOutlet weak var answer3: UILabel!
    
    @IBOutlet weak var answer4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
