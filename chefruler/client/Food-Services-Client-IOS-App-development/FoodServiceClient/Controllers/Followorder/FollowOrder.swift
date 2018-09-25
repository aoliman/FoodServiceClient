//
//  FollowOrder.swift
//  FoodService
//
//  Created by index-ios on 3/21/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class FollowOrder: UIViewController ,UIGestureRecognizerDelegate {
     @IBOutlet weak var Name: UILabel!
     @IBOutlet weak var Location: UILabel!
     @IBOutlet weak var Time: UILabel!
    
    
    var routeLineView: MKPolylineView?
    var routeLine: MKPolyline?
    var locationManager=CLLocationManager()
    let authorizationstatus = CLLocationManager.authorizationStatus()
    var myRoute : MKRoute!
    @IBOutlet weak var mymap: MKMapView!
    var directions : MKDirections?
    
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        mymap.delegate=self
        locationManager.delegate=self
        centermapoflocation()
         mapconficuration()
      updatelocation(lat: 30.616222 , long:32.278912 , state: "")
        self.navigationController?.navigationBar.tintColor = .white
    }


}

extension FollowOrder : CLLocationManagerDelegate {
    //to get my location
    func mapconficuration(){
        if authorizationstatus == .notDetermined{
            locationManager.requestAlwaysAuthorization()
            print(locationManager.location?.coordinate)
        }else{return }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.msg)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            centermapoflocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            print("location:: \(locations)")
  }
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = #colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        myLineRenderer.lineWidth = 2
        return myLineRenderer
    }
}


extension FollowOrder :  MKMapViewDelegate{
    
    
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }

         let customPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "soliman")
                customPinView.image=#imageLiteral(resourceName: "emotion").crop(toWidth: 15, toHeight: 15)
                customPinView.isEnabled=true
                //customPinView.isHighlighted=true
                customPinView.isSelected=true
        return customPinView
    }
    
    
    
    
    
    
    
    func centermapoflocation(){
        guard let coordinate = locationManager.location?.coordinate else{return}
        let coordinateregion=MKCoordinateRegionMakeWithDistance(coordinate, 2000.0, 2000.0)
        mymap.setRegion(coordinateregion, animated: false)
        
    }
    
    //update my view line and annotation 
    func updatelocation(lat : Double ,long :Double, state : String){
        removeallanotation()
        if directions != nil {
            directions?.cancel()
        }
        self.mymap.removeOverlays(self.mymap.overlays)

        let anotation = addanotation(coordinate: CLLocationCoordinate2D.init(latitude:lat , longitude: long ) , identifier: "soliman",title :"DeliveryGuy")
        
        
        mymap.addAnnotation(anotation)
       print(userDistance(from: anotation ))
        let coordinateregion=MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D.init(latitude:max(lat, mymap.userLocation.coordinate.latitude) , longitude: max(long, mymap.userLocation.coordinate.longitude) ),2000.0, 2000.0)
        mymap.setRegion(coordinateregion, animated: false)
        route(coordinate1: anotation.coordinate, coordinate2:(locationManager.location?.coordinate)! )
     }
    
  
    
//zoom to two points
    
    func fitMapViewToAnnotaionList(annotations: [MKPointAnnotation]) -> Void {
        let mapEdgePadding = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        var zoomRect:MKMapRect = MKMapRectNull
        
        for index in 0..<annotations.count {
            let annotation = annotations[index]
            var aPoint:MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
            var rect:MKMapRect = MKMapRectMake(aPoint.x, aPoint.y, 0.1, 0.1)
            
            if MKMapRectIsNull(zoomRect) {
                zoomRect = rect
            } else {
                zoomRect = MKMapRectUnion(zoomRect, rect)
            }
        }
        
        mymap.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
    }
   //remove anotation
    func removeallanotation(){
        for anotaion in mymap.annotations{
            mymap.removeAnnotation(anotaion)
        }
        
    }
    
    
    
    //distane between two points
    func userDistance(from point: MKAnnotation) -> Double? {
        guard let userLocation = mymap.userLocation.location else {
            return nil // User location unknown!
        }
        let pointLocation = CLLocation(
            latitude:  point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
        return userLocation.distance(from: pointLocation)
    }
    
    
    
    
    
    
    //draw line between two points
    func route(coordinate1 : CLLocationCoordinate2D , coordinate2 : CLLocationCoordinate2D){
        let point1 = MKPointAnnotation()
        let point2 = MKPointAnnotation()
        
        point1.coordinate = CLLocationCoordinate2DMake(coordinate1.latitude, coordinate1.longitude)
        
        
        
        point2.coordinate = CLLocationCoordinate2DMake(coordinate2.latitude, coordinate2.longitude)
        
        
        
        let directionsRequest = MKDirectionsRequest()
        let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
        let markChungli = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
        
        
        directionsRequest.source = MKMapItem(placemark: markChungli)
        directionsRequest.destination = MKMapItem(placemark: markTaipei)
        
        directionsRequest.transportType = MKDirectionsTransportType.automobile
        directions = MKDirections(request: directionsRequest)
        
        directions?.calculate(completionHandler: {
            response, error in
            
            if error == nil {
                self.myRoute = response!.routes[0] as MKRoute
                self.mymap.add(self.myRoute.polyline)
            }
            
        })
        fitMapViewToAnnotaionList(annotations: [point1,point2])
    }
    
}

