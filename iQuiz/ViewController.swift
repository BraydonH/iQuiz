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
  
  let JSON_URL = "http://tednewardsandbox.site44.com/questions.json"
  var subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
  var json: NSArray? = nil
  var selectedRow = -1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    downloadData()
    tableView.dataSource = self
    tableView.delegate = self
    NSLog("ViewDidLoad")
  }
  
  func downloadData() {
    DispatchQueue.global(qos: .userInitiated).async {
      
      if let url = URL(string: self.JSON_URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
          if let jsonArr : NSArray = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray {
            NSLog((jsonArr[0] as! NSObject).value(forKey: "title") as! String)
            DispatchQueue.main.async { [unowned self] in
              self.useJSON(jsonArr)
            }
          } else {
            DispatchQueue.main.async { [unowned self] in
              self.useJSON(self.loadJSONFromDisk())
            }
          }
        }).resume()
      }
    }
  }
  
  func loadJSONFromDisk() -> NSArray? {
    let fileManager : FileManager = FileManager.default
    let fileURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("quiz.json")
    do {
      let savedJSON = try Data(contentsOf: fileURL)
      let jsonData =  try JSONSerialization.jsonObject(with: savedJSON, options: .mutableContainers) as! NSArray
      return jsonData
    } catch let error {
      NSLog("parse error: \(error.localizedDescription)")
      return nil
    }
  }
  
  func useJSON(_ json: NSArray?) {
    if let jsonArr = json {
      saveJSON(jsonArr)
      self.json = jsonArr
      tableView.reloadData()
    } else {
      // alert user
    }
  }
  
  func saveJSON(_ json: NSArray) {
    let fileManager : FileManager = FileManager.default
    let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    let fileURL = docDirectory.first!.appendingPathComponent("quiz").appendingPathExtension("json")
    do {
      let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
      try data.write(to: fileURL)
      NSLog("JSON was written to \(fileURL)")
    } catch let error as NSError {
      NSLog("Couldn't write to file: \(error.localizedDescription)")
    }
  }
  
  @IBAction func settingsPressed(_ sender: Any) {
    let alert = UIAlertController(title: "Settings Alert", message: "Settings go here", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in NSLog("\"OK\" pressed")}))
    self.present(alert, animated: true)
    
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizTableViewCell
    if let jsonArr = self.json {
      let quiz = jsonArr[indexPath.row] as! NSDictionary
      let subject = quiz.value(forKey: "title") as! String
      let description = quiz.value(forKey: "desc") as! String
      cell.subject = subject
      cell.desc = description
      cell.logo = UIImage(named: "test_image")
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let jsonArr = self.json {
      return jsonArr.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NSLog("You selected cell #\(indexPath.row)!")
    selectedRow = indexPath.row
    performSegue(withIdentifier: "questionSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier! {
    case "questionSegue":
      let destination = segue.destination as! QuestionViewController
      destination.quizDict = json![selectedRow] as! NSDictionary
      NSLog("Segue to Question Page")
    default:
      NSLog("Unknown segue identifier: \(segue.identifier!)")
    }
  }
}


