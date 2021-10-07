//
//  GearListController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/3/21.
//

import Foundation
import UIKit

class GearListController {
    ///shared instance
    static let shared = GearListController()
    
    ///Source of Truth
    var gearList: [GearList] = []
    
    
    //MARK: - CRUD Methods
    
    func createItem(item: String, quantity: String?){
        let newItem = GearList(item: item, quantity: quantity)
        gearList.append(newItem)
        saveToPersistenceStore()
    }
    
    func updateItem(gear: GearList, item: String, quantity: String) {
        gear.item = item
        gear.quantity = quantity
        saveToPersistenceStore()
    }
    
    func deleteItem(gear: GearList) {
        guard let index = self.gearList.firstIndex(of: gear) else { return }
        self.gearList.remove(at: index)
        saveToPersistenceStore()
        
        
    }
    
    func toggleIsPacked(gear: GearList) {
        gear.isToggled.toggle()
        saveToPersistenceStore()
    }
    
    func resetGears() {
        for gear in gearList {
            if gear.isToggled {
                gear.isToggled = false
            }
        }
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
            let data = try JSONEncoder().encode(gearList)
            try data.write(to: persistenceStoreURL())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        print("Saved succesfully")
    }
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: persistenceStoreURL())
            gearList = try JSONDecoder().decode([GearList].self, from: data)
        }catch{
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}//End of class
