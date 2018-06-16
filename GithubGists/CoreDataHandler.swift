//
//  CoreDataHandler.swift
//  GithubGists
//
//  Created by Владимир Микищенко on 16.06.2018.
//  Copyright © 2018 Vladimir Mikishchenko. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
   
   // MARK: - Получение текущего контекста
   private class func getContext() -> NSManagedObjectContext {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return appDelegate.persistentContainer.viewContext
   }
   
   // MARK: - Сохранение объекта в сущность Gist
   class func saveObject(userAvatar: String, gistName: String, userName: String, gistContent: String) {
      let context = getContext()
      let entity = NSEntityDescription.entity(forEntityName: "Gist", in: context)
      let manageObject = NSManagedObject(entity: entity!, insertInto: context)
      
      manageObject.setValue(userAvatar, forKey: "userAvatar")
      manageObject.setValue(gistName, forKey: "gistName")
      manageObject.setValue(userName, forKey: "userName")
      manageObject.setValue(gistContent, forKey: "gistContent")
      
      do {
         try context.save()
         return
      } catch {
         print("Сохранить объект не удалось")
         return
      }
   }
   
   // MARK: - Получение всех объектов сущности
   class func fetchObject() -> [Gist]? {
      let context = getContext()
      var objects: [Gist]? = nil
      do {
         objects = try context.fetch(Gist.fetchRequest())
         return objects
      } catch {
         print("Получить объекты не удалось")
         return objects
      }
   }
}
