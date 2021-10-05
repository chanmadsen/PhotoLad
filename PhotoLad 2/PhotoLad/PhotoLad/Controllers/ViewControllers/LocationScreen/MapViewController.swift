//
//  MapViewController.swift
//  PhotoLad
//
//  Created by Lon Chandler Madsen on 9/1/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinLocationTextView: UITextView!
    @IBOutlet weak var savePinLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation?
    
    //Landing pad
    var location: Location?
    
    weak var delegate: MapViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        checkLocationServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getCenterLocation(for: mapView)
        setCurrentLocationLabel(isInitialLaunch: true)
    }
    
    @IBAction func savePinLocationButtonTapped(_ sender: Any) {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        delegate?.savePinLocationTapped(with: pinLocationTextView.text, latitude: latitude, longitude: longitude)
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews(){
        savePinLocationButton.layer.cornerRadius = 25
        savePinLocationButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        savePinLocationButton.layer.shadowOpacity = 0.3
        savePinLocationButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        pinLocationTextView.layer.cornerRadius = 25
    }
    
    func setupLocationManager(){
//        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            locationManagerDidChangeAuthorization(locationManager)
        } else {
            
        }
    }
    
   
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch locationManager.authorizationStatus {
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
            
            switch manager.accuracyAuthorization {
            
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
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func setCurrentLocationLabel(isInitialLaunch: Bool = false){
        let newCenter = getCenterLocation(for: mapView)
        guard isInitialLaunch || shouldUpdateLabel(basedOn: newCenter) else { return }
        
        let geoCoder = CLGeocoder()
        
        self.previousLocation = newCenter
        
        geoCoder.reverseGeocodeLocation(newCenter) { [weak self](placemarks, error) in
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
                self.pinLocationTextView.text = "\(streetNumber) \(streetName) \n \(city), \(state), \(country)"
            }
        }
    }
    
    private func shouldUpdateLabel(basedOn center: CLLocation) -> Bool {
        guard let previousLocation = self.previousLocation,
              center.distance(from: previousLocation) > 15
        else { return false }
        return true
    }
}//end of class


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
       setCurrentLocationLabel()
    }
}

protocol MapViewDelegate: AnyObject {
    
    func savePinLocationTapped(with location: String, latitude: Double, longitude: Double)
}
