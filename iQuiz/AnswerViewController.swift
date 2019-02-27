//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by cse-loaner on 2/26/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

  @IBOutlet var questionLabel: UIView!
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()


  }
    
  @IBAction func buttonPressed(_ sender: Any) {
    let moreQuestions = false 
    if moreQuestions {
      performSegue(withIdentifier: "answerToQuestion", sender: self)
    } else {
      performSegue(withIdentifier: "answerToFinish", sender: self)
    }
  }
  
}
