//
//  NotesService.swift
//  Thong_Vuthy_Homework_4
//
//  Created by Adimax Lee on 20/12/17.
//  Copyright © 2017 Adimax Lee. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NotesService : NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    
    class func saveNote(title:String, note:String) -> Bool {
        let context = getContext()
//        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: context)
//        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
//        managedObject.setValue(title, forKey: "title")
//        managedObject.setValue(note, forKey: "note")
        let nt = Notes(context:context)
        nt.note = note
        nt.title = title
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    class func getNotes() -> [Notes]? {
        let context = getContext()
        var notes : [Notes]?
        do {
           notes =  try context.fetch(Notes.fetchRequest())
           return notes
        }catch {
            return notes
        }
    }
    
    
    
    class func updateNote(title : String, note:String , index : Int) -> Bool {
        
        let context = getContext()
        let obj = getNotes()![index] as NSManagedObject
        obj.setValue(title, forKey: "title")
        obj.setValue(note, forKey: "note")
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
    }
    
    
//    class func updateNote(note : Notes) -> Bool {
//        let context = getContext()
//        let obj = note as NSManagedObject
//        obj.setValue(note.title, forKey: "title")
//        obj.setValue(note.note, forKey: "note")
//        do {
//            try context.save()
//            return true
//        }catch {
//            return false
//        }
//
//    }
    
    
    class func deleteNote(note : Notes) -> Bool {
        let context = getContext()
        context.delete(note) 
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
}
