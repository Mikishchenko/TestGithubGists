//
//  gistsData.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 16.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import Foundation

// MARK: - Получение данных с сервера Github.api по всем gits/public
public func gistsRequest() {
   let mainURL = URLComponents(string: "https://api.github.com/gists/public")
   
   let task = URLSession.shared.dataTask(with: (mainURL?.url!)!) { (data, response, error) in
      // проверки корректности полученного ответа
      guard let data = data, let httpResponse = response as? HTTPURLResponse,
         httpResponse.statusCode == 200, error == nil else {
            print(String(describing: response))
            print(String(describing: error))
            return
      }
      guard let json = try! JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
         print("not JSON format expected")
         print(String(data: data, encoding: .utf8) ?? "No data")
         return
      }
      for i in 0...29 {
         // извлечение из полученного ответа необходимых значений
         let owner = json[i]["owner"] as? [String: Any]
         // получаем ссылку на userAvatar
         let avatarURL = URLComponents(string: owner!["avatar_url"] as! String)
         print(avatarURL ?? "No avatar url")
         var imageData = Data()
         // получаем изображение userAvatar
         let url = URL(string: owner!["avatar_url"] as! String)
         imageData = try! Data(contentsOf: url!)
         // получаем userName
         let login = owner!["login"] as? String
         print(login ?? "No user name")
         // получаем gistName (способ 1)
         let files = json[i]["files"] as? [String: Any]
         let name = files!.keys.first ?? "No gist name"
         print (name)
         // получаем userID
         let userID = json[i]["id"] as? String
         print(userID ?? "No userID")
         // сохраняем в CoreData
         CoreDataHandler.saveObject(userAvatar: imageData, gistName: name, userName: login!, gistContent: "", userID: userID!, commitsDate: "", additions: 0, deletions: 0)
      }
   }
   task.resume()
}

