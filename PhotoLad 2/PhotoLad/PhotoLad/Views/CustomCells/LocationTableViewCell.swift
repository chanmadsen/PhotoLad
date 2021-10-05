//
//  LocationTableViewCell.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/31/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    
    
    //MARK: - Properties
    
    var location: Location? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews(){
        locationImageView.image = location?.locationPhoto
        locationNameLabel.text = location?.locationName
        cellView.layer.cornerRadius = 20
        
        
        locationImageView.layer.cornerRadius = 8
        locationImageView.contentMode = .scaleAspectFill
    }
    
}
