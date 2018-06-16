//
//  ViewController.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 16.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit

var gistsList: [Gist]? = []
var currentGist: Gist?

class ListTableVIewController: UITableViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // получаем объекты в виде массива из Core Data
      gistsList = CoreDataHandler.fetchObject()
      self.clearsSelectionOnViewWillAppear = false
   }
   
   // MARK: - TableViewDataSource
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard gistsList?.isEmpty == false  else { return 0 }
      return gistsList!.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "ListsCell",
                                                  for: indexPath) as? ListTableViewCell {
         cell.gist = gistsList?[indexPath.row]
         return cell
      }
      return UITableViewCell()
   }
   
   // MARK: - TableViewDelegate
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView.dequeueReusableCell(withIdentifier: "ListsCell",
                                                  for: indexPath) is ListTableViewCell {
         currentGist = gistsList?[indexPath.row]
         OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: "GistDetailSegue", sender: self)
         }
      }
   }
   
   // MARK: - Кнопка обновления списка
   @IBAction func refreshButton(_ sender: UIBarButtonItem) {
      gistsList = CoreDataHandler.fetchObject()
      self.tableView.reloadData()
   }
}

