//
//  GearCellTableViewCell.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/9/21.
//

import UIKit

protocol GearListToggleDelegate: AnyObject {
func toggleIsPackedFor(gearList: GearList)
}

class GearCellTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemCountLable: UILabel!
    @IBOutlet weak var packedButton: UIButton!
    
    var gear: GearList? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: GearListToggleDelegate?
    
    //MARK: - Actions
   

    
    
    @IBAction func packedButtonTapped(_ sender: Any) {
        guard let gearList = gear else { return }
        delegate?.toggleIsPackedFor(gearList: gearList)
        
    }
    

    func updateViews(){
        guard let gearItem = gear else { return }
        cellView.layer.cornerRadius = 15
        itemLabel.text = gearItem.item
        itemCountLable.text = gearItem.quantity
        cellView.layer.opacity = 0.92
        
        if gearItem.isToggled {
            packedButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        } else {
            packedButton.setImage(UIImage(systemName: "camera"), for: .normal)
        }
    }

}//end of class

