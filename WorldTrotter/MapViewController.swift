//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Derrick Ward on 12/18/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

//import Foundation Comment this out

import UIKit;

class MapViewController : UIViewController{

    //Called only once, when the view is first loaded into memory, not every time the view is shown on the screen
    override func viewDidLoad() {
        //Always call the super implementation of viewDidLoad
        super.viewDidLoad();
        
        print("MapViewController loaded its view");
        
    }
    
    //Called Everytime the view is about to appear on the screen
    override func viewWillAppear(_ animated: Bool) {
        //Always call the super implementation of viewDidLoad'
        super.viewWillAppear(animated);
        
    }
    
    //Called Everytime the view is about to && did appear on the screen
    override func viewDidAppear(_ animated: Bool) {
        //Always call the super
        super.viewDidAppear(animated);
        
        print("Map View is appearing!");
    }
    
    //Called everytime the view is moved off screen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
    }
    
    //Called everytime the view is moved off screen
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
    }
    
}


