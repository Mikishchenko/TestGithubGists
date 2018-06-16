//
//  CommitTableViewCell.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 16.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

class CommitTableViewCell: UITableViewCell {
   
   // MARK: - Outlets
   @IBOutlet weak var commitsDateLabel: UILabel!
   @IBOutlet weak var codeStringsPlusLabel: UILabel!
   @IBOutlet weak var codeStringsMinusLabel: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
}
