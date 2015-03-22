//
//  ViewController.swift
//  WeightDraw
//
//  Created by THE MAYBERS on 3/22/15.
//  Copyright (c) 2015 Tiny Antelope Publishing, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var barbellView: WeightBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // barbellView.addPlate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(sender: AnyObject) {
        barbellView.addPlate()
    }
    @IBAction func test(sender: AnyObject) {
        barbellView.printInfo()
    }

}

