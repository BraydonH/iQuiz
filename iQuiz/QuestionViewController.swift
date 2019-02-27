//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by cse-loaner on 2/26/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var questionTableView: UITableView!
  @IBOutlet weak var submitButton: UIButton!
  
  var quiz : NSDictionary? = nil
  var questionIndex = 0
  var question : NSDictionary? = nil
  var selectedIndex = -1
  var numCorrect = 0
  
  var index : Int {
    get { return questionIndex }
    set { questionIndex = newValue }
  }
  
  var quizDict : NSDictionary {
    get { return quiz! }
    set {
      quiz = newValue
    }
  }
  
  var correct : Int {
    get { return numCorrect }
    set { numCorrect = newValue }
  }
  
  var questionNum : Int {
    get { return questionIndex }
    set { questionIndex = newValue }
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
    if question != nil {
      let answers = question?.value(forKey: "answers") as! NSArray
      cell.textLabel?.text = (answers[indexPath.row] as! String)
    }
    NSLog("Cell #\(indexPath.row)")
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    for i in 0...3 {
      if i != indexPath.row {
        tableView.deselectRow(at: IndexPath(row:i, section:0), animated: true)
      }
    }
    submitButton.isEnabled = true
    submitButton.backgroundColor = UIColor.blue
    selectedIndex = indexPath.row
    
  }
  


  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionTableView.delegate = self
    questionTableView.dataSource = self
    for i in 0...3 {
      questionTableView.deselectRow(at: IndexPath(row:i, section:0), animated: true)
    }
    // Do any additional setup after loading the view.
    submitButton.backgroundColor = UIColor.gray
    question = ((quiz!.value(forKey: "questions") as! NSArray)[questionIndex] as! NSDictionary)
    questionLabel.text = question!.value(forKey: "text") as! String
    questionTableView.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "questionToAnswer":
      let destination = segue.destination as! AnswerViewController
      let answerIndex = Int(question!.value(forKey: "answer") as! String)! - 1
      let answers = question!.value(forKey:"answers") as! NSArray
      let questions = (quiz!.value(forKey: "questions") as! NSArray)
      destination.questionAsked = question!.value(forKey: "text") as! String
      destination.answer = answers[answerIndex] as! String
      let wasCorrect = answerIndex == selectedIndex
      destination.wasCorrect = wasCorrect
      destination.numAnswered = questionIndex + 1
      destination.finalQuestion = questionIndex == questions.count - 1
      destination.numCorrect = numCorrect + (wasCorrect ? 1 : 0)
      destination.numAnswered = questionIndex + 1
      destination.quizDict = quiz!
      
    default:
      NSLog("Unknown segue identifier: \(segue.identifier!)")

    }
  }
  
  
}
