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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
    cell.textLabel?.text = "Answer #\(indexPath.row)"
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
  }

  @IBAction func buttonPressed(_ sender: Any) {
//    let alert = UIAlertController(title: "Submitting Alert", message:  "Please stand by", preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in NSLog("\"OK\" pressed")}))
//    self.present(alert, animated: true)

  }
}
