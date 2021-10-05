//
//  LocationListTableViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/31/21.
//

import UIKit

class LocationListTableViewController: UITableViewController {
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        showLoadingView()
        LocationsController.shared.fetchAllLocations {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Successfully fetched")
                    self.dismissLoadingView()
                    self.updateViews()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    self.dismissLoadingView()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateViews()
    }
    
    func updateViews(){
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return LocationsController.shared.locations.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell()}
        
        let location = LocationsController.shared.locations[indexPath.row]
        cell.location = location
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let locationToDelete = LocationsController.shared.locations[indexPath.row]
            
            guard let index = LocationsController.shared.locations.firstIndex(of: locationToDelete) else { return }
            
            LocationsController.shared.deleteLocation(locationToDelete) { (result) in
                switch result {
                case .success(let bool):
                    if bool == true {
                        LocationsController.shared.locations.remove(at: index)
                        DispatchQueue.main.async {
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        } else if editingStyle == .insert {
            
        }    
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLocationDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? LocationDetailViewController else { return }
            
            let locationToSend = LocationsController.shared.locations[indexPath.row]
            destinationVC.locations = locationToSend
            
        }
    }
}//End of class
