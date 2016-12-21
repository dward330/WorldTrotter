//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Derrick Ward on 12/20/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

import UIKit;
import MapKit;

class MapViewController: UIViewController{

    var mapView: MKMapView!;
    
    //Called when the view for this controller is nil, and the view for this controller is trying to be used
    override func loadView() {
        
        //create the MapView View
        self.mapView = MKMapView();
        
        //Set the View of this Controller
        self.view = self.mapView;
        
        /*Creating a Control Programmatically. UISegmentedControl*/
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"]);
        //Set the Control's Background Color
        segmentedControl.backgroundColor = (UIColor.white).withAlphaComponent(0.5); //Also set transparency
        //Set the Current Selected Index of the UISegmentedControl
        segmentedControl.selectedSegmentIndex = 0;
        //Turn off adding constraints, to this view, for the AutoResizing Mask of this control
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        
        //Add Control to the view of this view controller
        self.view.addSubview(segmentedControl);
        
        //Add Contraints (NSLayoutConstraint) for positioning, for the segmented view
        //The following sets our control to the absolute edges and top of the view
        var topConstraint = segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor);
        var leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor);
        var trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor);
        //The following sets our control to the controller's topLayout bottom edge and the view's layoutmarginguide's leading and trailing edge/anchor
        topConstraint = segmentedControl.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor);
        leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor);
        trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor);

        //Activate Constraints
        topConstraint.isActive = true;
        leadingConstraint.isActive = true;
        trailingConstraint.isActive = true;
        
        //Set Event Handler for our control: Segmented Control
        segmentedControl.addTarget(self, action:#selector(mapTypeSelected(segControl:)), for: .valueChanged)
    }
    
    //When ViewController is first loaded into Memory
    override func viewDidLoad() {
        print("MapView Controller Did Load!");
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
}
