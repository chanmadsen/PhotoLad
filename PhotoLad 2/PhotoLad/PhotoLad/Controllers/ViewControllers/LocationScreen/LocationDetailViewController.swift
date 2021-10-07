//
//  LocationDetailViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 8/31/21.
//

import UIKit
import MapKit
import CoreLocation

class LocationDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var selectPhotoButton: UIButton!
    @IBOutlet weak var addressTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var showMapButton: UIButton!
    @IBOutlet weak var useCurrentLocationButton: UIButton!
    @IBOutlet weak var existingMapView: MKMapView!
    
    
    //MARK: - Properties
    
    var locations: Location? {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
            }
        }
    }
    
    let locationManager = CLLocationManager()
    
    private var currentCoordinate: CLLocationCoordinate2D? = nil
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        updateViews()
        updateButtonView()
        delegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
        delegates()
    }
    
    
    
    func delegates() {
        locationNameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Actions
    @IBAction func imagePickerButtonTapped(_ sender: Any) {
        presentImagePickerActionSheet()
        
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let locationName = locationNameTextField.text,
              let address = addressTextField.text
        else { return }
        
        let fullLocationShared = ("\(locationName)\n ---------\n\(address)")
        
        let shareSheet = UIActivityViewController(activityItems: [fullLocationShared], applicationActivities: nil)
        
        present(shareSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let locationName = locationNameTextField.text, !locationName.isEmpty,
              let fullAddress = addressTextField.text, !fullAddress.isEmpty,
              let locationPhoto = locationImageView.image,
              let latitude = self.currentCoordinate?.latitude,
              let longitude = self.currentCoordinate?.longitude else { return }
        saveButton.isEnabled = false
        
        if let locations = locations {
            LocationsController.shared.updateLocation(locations) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        } else {
            LocationsController.shared.createLocationWith(locationName: locationName, locationPhoto: locationPhoto, locationAddress: fullAddress, latitude: latitude, longitude: longitude) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let location):
                        print("location saved successfully")
                        print(location.locationName)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }//End of saveFunc
    
    @IBAction func useCurrentLocationButtonTapped(_ sender: Any) {
        guard let location = locationManager.location else { return }
        self.currentCoordinate = location.coordinate
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { [weak self](placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                
                return
            }
            
            guard let placemark = placemarks?.first.self else {
                
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            let city = placemark.locality ?? ""
            let state = placemark.administrativeArea ?? ""
            let country = placemark.country ?? ""
            DispatchQueue.main.async {
                self.addressTextField.text = "\(streetNumber) \(streetName) \n \(city), \(state), \(country)"
            }
        }
    }
    
    func updateViews() {
        existingMapView.isHidden = true
        guard let location = locations else { return }
        existingMapView.isHidden = false
        saveButton.isEnabled = false
        useCurrentLocationButton.isHidden = true
        showMapButton.isHidden = true
        locationNameTextField.text = location.locationName
        addressTextField.text = location.locationAddress
        setMapLocation(withLocation: location)
        locationImageView.image = location.locationPhoto
        locationImageView.contentMode = .scaleAspectFill
        locationImageView.layer.cornerRadius = 15
        selectPhotoButton.isHidden = true
    }
    
    func setMapLocation(withLocation location: Location) {
        
        let long = location.longitude
        let lat = location.latitude
        
        let coord = CLLocationCoordinate2DMake(lat, long)
        
        let placemark = MKPlacemark(coordinate: coord)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        
        self.existingMapView.addAnnotation(placemark)
        
        self.existingMapView.showAnnotations([annotation], animated: false)
    }
    
    func updateButtonView() {
        showMapButton.layer.cornerRadius = 25
        showMapButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        showMapButton.layer.shadowOpacity = 0.3
        showMapButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        useCurrentLocationButton.layer.cornerRadius = 25
        useCurrentLocationButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        useCurrentLocationButton.layer.shadowOpacity = 0.3
        useCurrentLocationButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        addressTextField.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapView"{
            let location = locations
            guard let destinationVC = segue.destination as? MapViewController else { return }
            
            destinationVC.delegate = self
            destinationVC.location = location
        }
    }
}//end of class

extension LocationDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            selectPhotoButton.isHidden = true
            locationImageView.image = photo
            
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
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
}

extension LocationDetailViewController: MapViewDelegate {
    func savePinLocationTapped(with location: String, latitude: Double, longitude: Double) {
        addressTextField.text = location
        self.currentCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension LocationDetailViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    //MARK: - LocationFunctions
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            // App first launched, hasn't determined
            case .notDetermined:
                // For use when the app is open
                manager.requestWhenInUseAuthorization()
            case .restricted:
                break
            case .denied:
                break
            case .authorizedAlways:
                break
            // For use when the app is open
            case .authorizedWhenInUse:
                break
            @unknown default:
                break
            }
            
            switch locationManager.accuracyAuthorization {
            
            case .fullAccuracy:
                break
            case .reducedAccuracy:
                break
            @unknown default:
                break
            }
            // This will update us along the way, as the user has our app
            locationManager.startUpdatingLocation()
        }
    

    func startTrackingUserLocation(){
        locationManager.startUpdatingLocation()
    }
    
}//end of extension
