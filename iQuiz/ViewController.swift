//
//  ViewController.swift
//  iQuiz
//
//  Created by cse-loaner on 2/20/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var settingsButton: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  
  var subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    NSLog("ViewDidLoad")
  }


  @IBAction func settingsPressed(_ sender: Any) {
    let alert = UIAlertController(title: "Settings Alert", message: "Settings go here", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in NSLog("\"OK\" pressed")}))
    self.present(alert, animated: true)
    
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
    let subject = subjects[indexPath.row]
    cell.subject = subject
    cell.logo = UIImage(named: "test_image")
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return subjects.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NSLog("You selected cell #\(indexPath.row)!")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case "questionSegue":
      let destination = segue.destination as! QuestionViewController
      NSLog("Segue to Question Page")
    default:
      NSLog("Unknown segue identifier: \(segue.identifier!)")
    }
  }
}


