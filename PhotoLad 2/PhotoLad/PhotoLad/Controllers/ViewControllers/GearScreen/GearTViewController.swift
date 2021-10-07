//
//  GearTViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 10/4/21.
//

import UIKit

class GearTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gearTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        GearListController.shared.loadFromPersistenceStore()
        gearTableView.delegate = self
        gearTableView.dataSource = self
        gearTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gearTableView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentGearListAlert()
    }
    
    @IBAction func resetAllGears(_ sender: Any) {
        GearListController.shared.resetGears()
        gearTableView.reloadData()
    }
    
    //MARK: - Helper Methods
    
   
    func presentGearListAlert() {
        let alertController = UIAlertController(title: "Add Gear", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Item..."
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "quantity..."
            textField.keyboardType = .numberPad
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            guard let gearItem = alertController.textFields?[0].text, !gearItem.isEmpty
            else {return}
            let itemQuantity = alertController.textFields?[1].text
            
            GearListController.shared.createItem(item: gearItem, quantity: itemQuantity)
            
            self.gearTableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    

    // MARK: - Table view data source

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GearListController.shared.gearList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? GearCellTableViewCell else { return UITableViewCell() }
        
        let gearList = GearListController.shared.gearList[indexPath.row]
        cell.gear = gearList
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let itemToDelete = GearListController.shared.gearList[indexPath.row]
            GearListController.shared.deleteItem(gear: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}


extension GearTViewController: GearListToggleDelegate{
    func toggleIsPackedFor(gearList: GearList) {
        GearListController.shared.toggleIsPacked(gear: gearList)
        gearTableView.reloadData()
    }
}
