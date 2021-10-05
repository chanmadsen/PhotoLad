//
//  GearTViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 10/4/21.
//

import UIKit

class GearTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var gearTableView: UITableView!
    
    var gear: Gear?

    override func viewDidLoad() {
        super.viewDidLoad()
        GearController.shared.loadFromPersistenceStore()
        gearTableView.delegate = self
        gearTableView.dataSource = self
        gearTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gearTableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return GearController.shared.gears.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "gearListCell", for: indexPath) as? GearCellTableViewCell else { return UITableViewCell() }
        let gear = GearController.shared.gears[indexPath.row]
        cell.gear = gear
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let gearToDelete = GearController.shared.gears[indexPath.row]
            GearController.shared.deleteItem(gear: gearToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGearDetailVC" {

            guard let indexPath = gearTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? GearDetailViewController else { return }

            let gearToSend = GearController.shared.gears[indexPath.row]
            destinationVC.gear = gearToSend
        }
    }
}
