//
//  GearCellTableViewCell.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/9/21.
//

import UIKit

class GearCellTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    
    var gear: Gear? {
        didSet{
            updateViews()
        }
    }

    func updateViews(){
        cellView.layer.cornerRadius = 15
        itemLabel.text = gear?.name
    }

}//end of class

