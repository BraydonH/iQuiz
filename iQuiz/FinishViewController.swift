//
//  FinishViewController.swift
//  iQuiz
//
//  Created by cse-loaner on 2/27/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

  @IBOutlet weak var feedbackLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  var numCorrect = 0
  var numQuestions = 0
  var perfectFeedback = "Perfect! Tubular!"
  var okayFeedback = "Almost!"
  var badFeedback = "Are you even trying?"
  
  var correct : Int {
    get { return numCorrect }
    set { numCorrect = newValue }
  }
  
  var questions : Int {
    get { return numQuestions }
    set { numQuestions = newValue }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    scoreLabel.text = "Your score: \(numCorrect) / \(numQuestions)"
    var fraction = Double(numCorrect) / Double(numQuestions)
    if numCorrect == numQuestions {
      feedbackLabel.text = perfectFeedback
    } else if fraction >= 0.5 {
      feedbackLabel.text = okayFeedback
    } else {
      feedbackLabel.text = badFeedback
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

}
