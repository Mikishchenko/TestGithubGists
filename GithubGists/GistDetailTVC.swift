//
//  GistDetailVC.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 16.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

class GistDetailTableViewController: UITableViewController {
   
   // MARK: - Outlets
   @IBOutlet weak var userAvatarImage: UIImageView!
   @IBOutlet weak var gistNameLabel: UILabel!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var gistContentLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      userAvatarImage.image = UIImage(named: currentGist?.userAvatar! ?? "")
      gistNameLabel.text = currentGist?.gistName ?? ""
      userNameLabel.text = currentGist?.userName ?? ""
      gistContentLabel.text = currentGist?.gistContent ?? ""
   }
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
   
}
