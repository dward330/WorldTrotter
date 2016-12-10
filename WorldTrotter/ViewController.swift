//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Derrick Kyle Ward on 12/4/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        //Perform the Actions of the super class first, if there were any
        super.viewDidLoad();
        
        
        
        //demoViews();
    }
    
    
    //Demos Creating a View and a subview of that view
    func demoViews(){
        //Create a CGRect/Frame, containing its position and size information
        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150);
        
        //Create a UIView, defined by our custom Frame above
        let firstView = UIView(frame: firstFrame);
        
        //Set the Background Color of our view to blue
        firstView.backgroundColor = UIColor.blue;
        
        //Add our view to this Controller's view
        view.addSubview(firstView);
        
        
        
        /*
         * Let's create a Second Frame and View and make a subview of the first we created
         */
        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 75);
        let secondView = UIView(frame: secondFrame);
        secondView.backgroundColor = UIColor.yellow;
        firstView.addSubview(secondView);

    }
}

