//
//  SingleGistData.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 18.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation

// MARK: - Получение данных с сервера Github.api по всем gits/public
public func singleGistRequest() {
   let mainURL = URLComponents(string: "https://api.github.com/gists/" + (currentGist?.userID)!)
   
   let task = URLSession.shared.dataTask(with: (mainURL?.url!)!) { (data, response, error) in
      // проверки корректности полученного ответа
      guard let data = data, let httpResponse = response as? HTTPURLResponse,
         httpResponse.statusCode == 200, error == nil else {
            print(String(describing: response))
            print(String(describing: error))
            return
      }
      guard let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] else {
         print("not JSON format expected")
         print(String(data: data, encoding: .utf8) ?? "No data")
         return
      }
      // получаем gistContent
      let files = json["files"] as? [String: Any]
      let fileName = files?.first?.value as? [String: Any]
      let content = fileName!["content"] as? String
      print (content ?? "No content")
      // получаем commitsDate
      let history = json["history"] as? [String: Any]
      let commitsDate = history!["committed_at"] as? String
      print(commitsDate ?? "No commit")
      // получаем additions
      let changeStatus = history!["change_status"] as? [String: Any]
      let additions = changeStatus!["additions"] as? Int
      print(additions ?? "No additios")
      // получаем deletions
      let deletions = changeStatus!["deletions"] as? Int
      print(deletions ?? "No deletions")
      // сохраняем в CoreData
      CoreDataHandler.refreshObjectsParametrs(userID: (currentGist?.userID)!, gistContent: content!, commitsDate: commitsDate!, additions: UInt(additions!), deletions: UInt(deletions!))
   }
   task.resume()
}
