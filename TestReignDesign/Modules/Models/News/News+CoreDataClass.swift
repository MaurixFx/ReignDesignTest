//
//  News+CoreDataClass.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

public class News: NSManagedObject {

    // Declaramos el contexto
    var managedContext: NSManagedObjectContext!
    var storysId = [Int64]()
    
    func MappingNews(DataJson: JSON) {
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            managedContext = container.viewContext
        }
        // Recorremos cada noticia y la vamos agregando
        for result in DataJson["hits"].arrayValue {
            // Preguntamos si la historia existe, si no la agregamos
            let idStory = result["story_id"].int64 ?? 0
            let fetch: NSFetchRequest<News> = News.fetchRequest()
            fetch.predicate = NSPredicate(format: "storyId == \(idStory)")
            do {
                let results = try managedContext.fetch(fetch)
                // Si no existe y no fue eliminada la guardamos
                if results.count == 0 && !getStoryWasDeleted(idStory: idStory) {
                    // Declaramos la entidad de Usuario
                    let news = News(context: managedContext)
                    news.storyId = result["story_id"].int64 ?? 0
                    if let title = result["title"].string {
                        news.storyTitle = title
                    } else {
                        news.storyTitle = result["story_title"].string
                    }
                    news.author = result["author"].string
                    news.createdAt = result["created_at"].string
                    news.storyLink = result["story_url"].string
                    try managedContext.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllNews() -> [News]? {
        // Obtenemos el persistentContainer desde el AppDelegate
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            managedContext = container.viewContext
        }
        var newsList: [News]?
        let fetch: NSFetchRequest<News> = News.fetchRequest()
        fetch.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))]
        do{
            // Obtenemos el resultado
            newsList = try managedContext.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
        
        return newsList
    }
    
    func deleteStory(idStory: Int64) {
        // Obtenemos el persistentContainer desde el AppDelegate
        if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
            managedContext = container.viewContext
        }
        let fetch: NSFetchRequest<News> = News.fetchRequest()
        fetch.predicate = NSPredicate(format: "storyId == \(idStory)")
        do{
            let results = try managedContext.fetch(fetch)
            if results.count > 0 {
                managedContext.delete(results.first!)
                try managedContext.save()
                setStoryIdDeleted(idStory: idStory)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setStoryIdDeleted(idStory: Int64) {
        let userDefault = UserDefaults()
        if let arrayStorys = userDefault.object(forKey: STORYS_DELETED) as? [Int64] {
            self.storysId = arrayStorys
            self.storysId.append(idStory)
        }
        saveIdStorysDeletedInSettings(storysId: self.storysId)
    }
    
    func saveIdStorysDeletedInSettings(storysId: [Int64]) {
        let userDefault = UserDefaults()
        userDefault.set(storysId, forKey: STORYS_DELETED)
        userDefault.synchronize()
    }
    
    func getStoryWasDeleted(idStory: Int64) -> Bool {
        let userDefault = UserDefaults()
        if let arrayStorys = userDefault.object(forKey: STORYS_DELETED) as? [Int64] {
            for id in arrayStorys {
                if id == idStory {
                    return true
                }
            }
        }
        return false
    }
}
