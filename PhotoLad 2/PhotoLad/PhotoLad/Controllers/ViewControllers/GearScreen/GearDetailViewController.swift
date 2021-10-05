//
//  GearDetailViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/3/21.
////

import UIKit

class GearDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var gearImageView: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    
    //MARK: - Properties
    var gear: Gear?
    {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        }
    }
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func addImageButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }

        let detailText = detailTextView.text
        let gearPhoto = gearImageView.image
        
        if let gearItem = gear {
            GearController.shared.updateItem(with: gearItem, name: name, detail: detailText, gearPhoto: gearPhoto)
        } else {
            GearController.shared.createItem(name: name, detail: detailText, gearPhoto: gearPhoto)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    //MARK: - Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateViews(){
        nameTextField.layer.cornerRadius = 15
        gearImageView.layer.cornerRadius = 15
        nameTextField.text = gear?.name
        detailTextView.text = gear?.detail
        gearImageView.image = gear?.gearPhoto
        selectPhotoButton.isHidden = gear?.gearPhoto != nil
    }
}

extension GearDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            selectPhotoButton.isHidden = true
            gearImageView.image = photo
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
}//end of extension
