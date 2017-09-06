//
//  RealmHelper.swift
//  modoTube
//
//  Created by Guillaume Monot on 7/20/17
//  Copyright (c) 2017 mobizel. All rights reserved.
//

import RealmSwift

class RealmHelper {

    static func objects<T: Object>(type: T.Type) -> Results<T>? {
        
        var allResult: Results<T>? = nil
        
        do {
            let realm = try Realm()
            
            try realm.write {
                allResult = realm.objects(type)
                try realm.commitWrite()
            }
        } catch let error as NSError {
            allResult = nil
            logger.error(error)
        }
        return allResult
    }
    
    static func remove<T: Object>(type: T.Type) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(realm.objects(type))
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
    
    static func update<T: Object>(type: T.Type, dict: [String: Any]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.create(type, value: dict, update: true)
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
    
    static func eraseDatabase() {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
    
    static func update<T: Object>(object: T, updateHandler: (T) -> Void) {
        do {
            let realm = try Realm()
            
            try realm.write {
                updateHandler(object)
                realm.add(object, update: true)
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
}

extension Object {
    
    func addToRealm() {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
    
    func deleteToRealm() {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(self)
            }
        } catch let error as NSError {
            logger.error(error)
        }
    }
}

/*
 if let currrentEventType: eventType = RealmHelper.objects(type: eventType.self)?.filter(NSPredicate(format: "name = %@", self.eventTypeName)).first {
 self.eventTypeId = currrentEventType.id
 }
*/
