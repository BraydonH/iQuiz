//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by cse-loaner on 2/26/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var feedbackLabel: UILabel!
  
  var quiz : NSDictionary? = nil
  var question = ""
  var correctAnswer = ""
  var correct = false
  var totalCorrect = 0
  var total = 0
  var lastQuestion = false
  var positiveFeedback = "You got it right! Rock on!"
  var negativeFeedback = "Oops, you didn't get the answer!"
  
  var quizDict : NSDictionary {
    get { return quiz! }
    set { quiz = newValue }
  }
  var questionAsked : String {
    get { return question }
    set { question = newValue }
  }
  
  var answer : String {
    get { return correctAnswer }
    set { correctAnswer = newValue }
  }
  
  var wasCorrect : Bool {
    get { return correct }
    set { correct = newValue }
  }
  
  var finalQuestion : Bool {
    get { return lastQuestion }
    set { lastQuestion = newValue }
  }
  
  var numCorrect : Int {
    get { return totalCorrect }
    set { totalCorrect = newValue }
  }
  
  var numAnswered : Int {
    get { return total }
    set { total = newValue }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionLabel.text = question
    answerLabel.text = correctAnswer
    feedbackLabel.text = correct ? positiveFeedback : negativeFeedback
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "answerToQuestion":
      let destination = segue.destination as! QuestionViewController
      destination.quizDict = quiz!
      destination.correct = totalCorrect
      destination.questionNum = numAnswered
    case "answerToFinish":
      NSLog("Finished!!!")
      let destination = segue.destination as! FinishViewController
      destination.correct = numCorrect
      destination.questions = total
    default:
      NSLog("Unknown segue identifier: \(segue.identifier!)")
    }
  }
  
  @IBAction func buttonPressed(_ sender: Any) {
    if !lastQuestion {
      performSegue(withIdentifier: "answerToQuestion", sender: self)
    } else {
      performSegue(withIdentifier: "answerToFinish", sender: self)
    }
  }
  
}
