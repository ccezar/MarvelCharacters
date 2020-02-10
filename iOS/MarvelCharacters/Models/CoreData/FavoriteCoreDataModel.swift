//
//  FavoriteCoreDataModel.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 09/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import CoreData

class FavoriteCoreDataModel: NSObject {
    class func addFavorite(character: Character) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        
        let managedObject = NSManagedObject(entity: favoriteEntity, insertInto: managedContext) as! Favorite
        managedObject.setValue(character.id!, forKeyPath: "id")
        managedObject.setValue(character.resultDescription, forKeyPath: "descriptionText")
        managedObject.setValue(character.name, forKeyPath: "name")
        
        if let thumbnail = character.thumbnail,
            let path = thumbnail.path,
            let thumbnailExtension = thumbnail.thumbnailExtension {
            let imageURL = "\(path).\(thumbnailExtension)"
            managedObject.setValue(imageURL, forKeyPath: "imageURL")
        }

        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
        
    class func getFavorites() -> [FavoriteCharacter] {
        var favorites = [FavoriteCharacter]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return favorites }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result as! [NSManagedObject] {
                let favorite = data as! Favorite
                
                favorites.append(FavoriteCharacter.init(id: Int(favorite.id),
                                                        descriptionText: favorite.descriptionText ?? "",
                                                        imageURL: favorite.imageURL ?? "",
                                                        name: favorite.name ?? "",
                                                        comics: favorite.comics as? [FavoriteProduction] ?? [FavoriteProduction](),
                                                        series: favorite.series as? [FavoriteProduction] ?? [FavoriteProduction]()))
            }
        } catch {
            print("Failed to load favorites")
        }
        
        return favorites
    }
    
    class func updateData(favorite: FavoriteCharacter) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id = %@", favorite.id)
        do
        {
            let result = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = result[0] as! NSManagedObject
            objectUpdate.setValue(favorite.comics, forKey: "comics")
            objectUpdate.setValue(favorite.series, forKey: "series")
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    class func deleteFavorite(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")

        do
        {
            let result = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = result[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}
