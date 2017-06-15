//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Derrick Ward on 12/20/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

import UIKit;
import MapKit;

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    var mapView: MKMapView!;
    var segControl : UISegmentedControl!
    var locationManager : CLLocationManager!
    var ApplicationStartingUp: Bool!;
    
    //Called when the view for this controller is nil, and the view for this controller is trying to be used
    override func loadView() {
        //Set the flag that represents application is starting up
        self.ApplicationStartingUp = Bool(true);
        
        //create the MapView View
        self.mapView = MKMapView();
        
        //If we are using delegate methods in this class/controller we need to tell mapview the delegates to call are in here
        self.mapView.delegate = self;
        
        //Set the View of this Controller
        self.view = self.mapView;
        
        //Set Location Manager
        self.locationManager = CLLocationManager();
        //If we are using delegate methods in this class/controller we need to tell CLLocationManager the delegates to call are in here
        self.locationManager.delegate = self;
        //Rquest User Permission to access thier Private Location Information
        self.locationManager.requestWhenInUseAuthorization();
        //Get the User Location Now
        self.locationManager.requestLocation();
    }
    
    //When ViewController is first loaded into Memory
    override func viewDidLoad() {
        print("MapView Controller Did Load!");
    }
    
    //Function to load in all UI Custom/Programmatic UI Elements
    func LoadUIElements(){
        if (self.ApplicationStartingUp == true){
            self.ApplicationStartingUp = false;
            //Adds a Segmented Control to the current view
            self.loadSegmentedControl(targetView: self.view, viewToPositionAgainst: self.view) //Needs to be done before we load UI Button
            
            //Adds a UI Button to the current view
            self.loadUserLocationButton(targetView: self.view, viewToPositionAgainst: self.segControl,
                                        xPositionPadding: 0, yPositionPadding: 10, width:nil, height: nil, text:"Derrick's Button");
        }
    }
    
    //Event Handler for touching down on a choice, on the segmented control
    func mapTypeSelected(segControl: UISegmentedControl){
        print("Selected Index: \(segControl.selectedSegmentIndex)");
        
        //Depending on which index is touched change the mapview appropriately
        switch (segControl.selectedSegmentIndex){
        case 0:
            (self.view as! MKMapView).mapType = MKMapType.standard;
        case 1:
            (self.view as! MKMapView).mapType = MKMapType.hybrid;
        case 2:
            (self.view as! MKMapView).mapType = MKMapType.satellite;
        default:
            print("No Action Set for index: \(segControl.selectedSegmentIndex)");
        }
    }
    
    //Add a SegmentedControl to a UIView
    func loadSegmentedControl (targetView: UIView, viewToPositionAgainst: UIView){
        /*Creating a Control Programmatically. UISegmentedControl*/
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"]);
        //Set the Control's Background Color
        segmentedControl.backgroundColor = (UIColor.white).withAlphaComponent(0.5); //Also set transparency
        //Set the Current Selected Index of the UISegmentedControl
        segmentedControl.selectedSegmentIndex = 0;
        //Turn off adding constraints, to this view, for the AutoResizing Mask of this control
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        //Set the Segmented Control Property, of the view controller
        self.segControl = segmentedControl;
        
        //Add Control to the view of this view controller
        targetView.addSubview(segmentedControl);
        
        //Add Contraints (NSLayoutConstraint) for positioning, for the segmented view
        //The following sets our control to the absolute edges and top of the view
        var topConstraint = segmentedControl.topAnchor.constraint(equalTo: viewToPositionAgainst.topAnchor);
        var leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: viewToPositionAgainst.leadingAnchor);
        var trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: viewToPositionAgainst.trailingAnchor);
        //The following sets our control to the controller's topLayout bottom edge and the view's layoutmarginguide's leading and trailing edge/anchor
        topConstraint = segmentedControl.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor);
        leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: viewToPositionAgainst.layoutMarginsGuide.leadingAnchor);
        trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: viewToPositionAgainst.layoutMarginsGuide.trailingAnchor);
        
        //Activate Constraints
        topConstraint.isActive = true;
        leadingConstraint.isActive = true;
        trailingConstraint.isActive = true;
        
        
        
        //Set Event Handler for our control: Segmented Control
        segmentedControl.addTarget(self, action:#selector(mapTypeSelected(segControl:)), for: .valueChanged)
    }
    
    //Add a UIButton to a UIView
    func loadUserLocationButton(targetView: UIView, viewToPositionAgainst: UIView,
                                xPositionPadding: Int, yPositionPadding: Int,
                                width: Int?, height: Int?,
                                text: String){
        
        //Creating the button control programmatically.
        let userLocButton = UIButton();
        userLocButton.backgroundColor = UIColor.blue;
        userLocButton.setTitle(text, for: UIControlState.normal);
        userLocButton.titleLabel!.minimumScaleFactor = 0.2;
        userLocButton.titleLabel!.adjustsFontSizeToFitWidth = true;
        userLocButton.translatesAutoresizingMaskIntoConstraints = false; //NEED THIS TO BE FALSE, when using NS Constraints
        userLocButton.layer.borderWidth = 1;
        userLocButton.layer.cornerRadius = 10;
        userLocButton.titleEdgeInsets.left = 10;
        userLocButton.titleEdgeInsets.right = 10;
        userLocButton.titleEdgeInsets.top = 10;
        userLocButton.titleEdgeInsets.bottom = 10;
        
        //Add this button to the target view
        targetView.addSubview(userLocButton);
        
        //Add Location Constraints to this button
        let topConstraint = NSLayoutConstraint(item: userLocButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: viewToPositionAgainst,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: CGFloat(yPositionPadding));
        let leadConstraint = NSLayoutConstraint(item: userLocButton,
                                                attribute: .leading,
                                                relatedBy: .equal,
                                                toItem: viewToPositionAgainst,
                                                attribute: .leading,
                                                multiplier: 1,
                                                constant: CGFloat(xPositionPadding));
        topConstraint.isActive = true;
        leadConstraint.isActive = true;
        
        //Add Size Constraints
        if let w = width {
            if let h = height{
                //Add Size Constraints to this buttion
                let widthConstraint = userLocButton.widthAnchor.constraint(equalToConstant: CGFloat(w));
                let heightConstraint = userLocButton.heightAnchor.constraint(equalToConstant: CGFloat(h));
                widthConstraint.isActive = true;
                heightConstraint.isActive = true;
            }
        }
        
        //Add Button Actions
        userLocButton.addTarget(self, action: #selector(zoomToUserLocation(buttonControl:)), for: UIControlEvents.touchDown)
    }
    
    //Zooms Map into user location
    func zoomToUserLocation(buttonControl: UIButton){
        //Show the users location on the map AND tells mapView to allow it self to get location updates
        self.mapView.showsUserLocation=true;
        
        //Store the user location
        let userLocation = self.mapView.userLocation
        
        print("user location: \(userLocation.coordinate)");
        
        //This is will display will user clicks on location/point
        userLocation.title="Your Location";
        
        //Make sure there is a valid location
        if let loc = userLocation.location {
            //Set the Region
            let region = MKCoordinateRegionMakeWithDistance(loc.coordinate, 1000, 1000);
            //Set the Maps Region to the User Location
            mapView.setRegion(region, animated: true);
        }
    }
    
    //MKMapView Delegate
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Finished Loading/Gathering Map Data");
    }
    
    //MKMapView Delegate
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Will Start Rendereing Map (Again)");
    }
    
    //MKMapView Delegate
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        self.LoadUIElements(); //Load my Custom/Programmatic UI Elements
        
        print("Finished Rendereing Map");
        
        
        if fullyRendered == true {
            print("Map Finished Rendering!");
        }
        else{
            print("Map Did Not Finish Rendering!")
        }
    }
    
    //Creates and Returns a UILabel, with a supplied text value
    func createUILabel (text: String) -> UILabel{
        //Create the UILabel
        let tempUILabel = UILabel();
        tempUILabel.text = text;
        return tempUILabel;
    }
    
    //CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("User Location Updated: \(locations)");
    }
    
    //CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Failed with the following error:\n\(error)");
    }
}
