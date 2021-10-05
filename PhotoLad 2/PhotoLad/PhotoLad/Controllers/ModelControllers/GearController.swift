//
//  GearListController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/3/21.
//

import Foundation
import UIKit

class GearController {
    
    static let shared = GearController()
    
    var gears: [Gear] = []
    
    
    //MARK: - CRUD
    func createItem(name: String, detail: String?, gearPhoto: UIImage?){
        let newItem = Gear(name: name, detail: detail, gearPhoto: gearPhoto)
        gears.append(newItem)
        saveToPersistenceStore()
    }
    
    func updateItem(with gear: Gear, name: String, detail: String?, gearPhoto: UIImage?) {
        if let index = gears.firstIndex(of: gear) {
            var gear = gears.remove(at: index)
            gear.name = name
            gear.detail = detail
            gear.gearPhoto = gearPhoto
            
            gears.insert(gear, at: index)
            saveToPersistenceStore()
        }
    }
    
    func deleteItem(gear: Gear) {
        guard let index = self.gears.firstIndex(of: gear) else { return }
        self.gears.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func persistenceStoreURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("PhotoLad.json")
        return fileURL
    }

    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(gears)
            try data.write(to: persistenceStoreURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        print("Saved succesfully")
    }
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: persistenceStoreURL())
            gears = try JSONDecoder().decode([Gear].self, from: data)
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}//End of class
