//
//  QuizTableViewCell.swift
//  iQuiz
//
//  Created by cse-loaner on 2/20/19.
//  Copyright © 2019 uw. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

  @IBOutlet weak var subjectLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var logoView: UIImageView!
  
  
  
  var subject: String? {
    get { return subjectLabel?.text }
    set { subjectLabel.text = newValue }
  }
  
  var logo : UIImage? {
    get { return logoView.image }
    set { logoView.image = newValue }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
