//
//  ViewController.swift
//  MapKitNYCSchoolLab
//
//  Created by David Lin on 2/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit
import MapKit

class MainVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationSession = CoreLocationSession()
    
    private var allSchools = [AllSchools]() {
        didSet {
            dump(allSchools)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadMapView()
        loadAllSchools()
        
    }
    
    
    private func loadAllSchools() {
        NYCSchoolsAPIClient.findHighSchool { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let allSchools):
                self?.allSchools = allSchools
                DispatchQueue.main.async {
                    self?.loadMapView()
                }
            }
        }
    }
    
    

    
        private func makeAnnotations() -> [MKPointAnnotation] {
            var annotations = [MKPointAnnotation]()
            for school in allSchools {
                guard let latitude = Double(school.latitude), let longitude = Double(school.longitude) else {
                    break
                }
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = school.schoolName
                annotations.append(annotation)
            }
            dump(annotations)
            return annotations
        }
        
    
    
    
        func loadMapView() {
            let annotaitons = makeAnnotations()
            mapView.addAnnotations(annotaitons)
            mapView.showAnnotations(annotaitons, animated: true)
        }
        


    }


    extension MainVC: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("didSelect")
        }
        
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is MKPointAnnotation else {
                return nil
            }
            let identifier = "locationAnmptatopm"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            //try to dequeue and resue annotation view
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.glyphImage = UIImage(named: "school")
                annotationView?.glyphTintColor = #colorLiteral(red: 1, green: 0.4049545527, blue: 0.4572703838, alpha: 1)
                annotationView?.markerTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
            
        }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            print("calloutAccessoryControlTapped")
        }
    

}

