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
      var appDelegate = AppDelegate()
      DispatchQueue.main.async {
         appDelegate = UIApplication.shared.delegate as! AppDelegate
      }
      return appDelegate.persistentContainer.viewContext
   }
   
   // MARK: - Сохранение объекта в сущность Gist
   class func saveObject(userAvatar: Data, gistName: String, userName: String, gistContent: String,
                         userID: String, commitsDate: String, additions: UInt, deletions: UInt) {
      let context = getContext()
      let entity = NSEntityDescription.entity(forEntityName: "Gist", in: context)
      let manageObject = NSManagedObject(entity: entity!, insertInto: context)
      
      manageObject.setValue(userAvatar, forKey: "userAvatar")
      manageObject.setValue(gistName, forKey: "gistName")
      manageObject.setValue(userName, forKey: "userName")
      manageObject.setValue(gistContent, forKey: "gistContent")
      manageObject.setValue(userID, forKey: "userID")
      manageObject.setValue(commitsDate, forKey: "commitsDate")
      manageObject.setValue(additions, forKey: "additions")
      manageObject.setValue(deletions, forKey: "deletions")
      
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
   
   // MARK: - Очистка CoreData (удаление всех объектов)
   class func cleanDelete() -> Bool {
      let context = getContext()
      let delete = NSBatchDeleteRequest(fetchRequest: Gist.fetchRequest())
      do {
         try context.execute(delete)
         return true
      } catch {
         return false
      }
   }
   
   // MARK: - Обновление некоторых значений объекта
   class func refreshObjectsParametrs(userID: String, gistContent: String,
                                      commitsDate: String, additions: UInt, deletions: UInt) {
      let context = getContext()
      var objects: [Gist]? = nil
      do {
         objects = try context.fetch(Gist.fetchRequest())
         guard (objects?.count)! > 0 else { return }
         for object in objects! {
            if object.userID == userID {
               object.setValue(object.gistContent, forKey: "gistContent")
               object.setValue(object.commitsDate, forKey: "commitsDate")
               object.setValue(object.additions, forKey: "additions")
               object.setValue(object.deletions, forKey: "deletions")
            }
         }
         try context.save()
         return
      } catch {
         print("Обновить значения параметров объекта не удалось")
         return
      }
   }
}
