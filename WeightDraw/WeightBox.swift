//
//  WeightBox.swift
//  WeightDraw
//
//  Created by THE MAYBERS on 3/22/15.
//  Copyright (c) 2015 Tiny Antelope Publishing, LLC. All rights reserved.
//

import UIKit

@IBDesignable
class WeightBox: UIImageView {

    var bar : CAShapeLayer!
    var plates : [[CAShapeLayer]] = []
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    let barWidth = UIScreen.mainScreen().bounds.width - 20
    let barHeight = (UIScreen.mainScreen().bounds.width - 20)/78
    let wtHoldHeight : CGFloat = ((UIScreen.mainScreen().bounds.width - 20)/78) * 1.7
    let wtHoldWidth : CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 5
    let wtStopHeight : CGFloat = ((UIScreen.mainScreen().bounds.width - 20)/78) * 3
    let wtStopWidth : CGFloat = 5
    let cornRad :CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if  bar == nil{buildBarbell()}
    }
    
    func buildBarbell(){
        /*||||||||||||||||||||||||||||||||
        
        Function to build our intial Barbell that we
        will add plates to explify what a user will 
        need to lift.
        _Scott MAR21_15
        
        ||||||||||||||||||||||||||||||||||*/

        bar = CAShapeLayer()
        var barPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: barWidth, height: barHeight), cornerRadius: 1)
        var barStop = UIBezierPath(rect: CGRect(x: wtHoldWidth, y: -barHeight, width: wtStopWidth , height: wtStopHeight))
        var barHold = UIBezierPath(roundedRect: CGRect(x: 0, y: -barHeight/3, width: wtHoldWidth+5, height: wtHoldHeight), cornerRadius: cornRad)
        barPath.appendPath(barHold)
        barPath.appendPath(barStop)
        barHold = UIBezierPath(roundedRect: CGRect(x: barWidth-wtHoldWidth-cornRad, y: -barHeight/3, width: wtHoldWidth+cornRad, height: wtHoldHeight), cornerRadius: cornRad)
        barStop = UIBezierPath(rect: CGRect(x: barWidth-wtHoldWidth-wtStopWidth, y: -barHeight, width: wtStopWidth , height: wtStopHeight))
        barPath.appendPath(barHold)
        barPath.appendPath(barStop)
        bar.path = barPath.CGPath
        bar.bounds = CGPathGetBoundingBox(bar.path)
        //Update Color here one day
        bar.fillColor = UIColor.whiteColor().CGColor
        bar.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        //bar.transform = CATransform3DMakeScale(0.2, 0.2, 0.2)
        self.layer.insertSublayer(bar, atIndex: 1)
        
    }
    func printInfo() {
        if bar != nil{println(bar.bounds.midX)
            var i : CGFloat = 0
            for plate in plates{
                plate[0].removeFromSuperlayer();plate[1].removeFromSuperlayer()
            }
        }

        plates = []
        
    }
    
    func addPlate() {
        var taco = makePlate(CGFloat(Float(arc4random()) / Float(UINT32_MAX))*10+2)
        plates.append(taco)
        
        if bar != nil{
            var i : CGFloat = 0
            for plate in plates{
                
                var widthIn = plate[0].bounds.width
                var destination = (wtHoldWidth+10)
                
                plate[0].position = CGPoint(x: self.bounds.width , y: self.bounds.height/2)
                plate[1].position = CGPoint(x: 0 , y: self.bounds.height/2)
                self.layer.insertSublayer(plate[0], atIndex: 1)
                self.layer.insertSublayer(plate[1], atIndex: 2)
                
                plate[0].path = UIBezierPath(rect: CGRect(x: 0 , y: 0, width: 0 , height: wtStopHeight*5)).CGPath
                plate[1].path = UIBezierPath(rect: CGRect(x: 0 , y: 0, width: 0 , height: wtStopHeight*5)).CGPath
                
                let plateMove = CABasicAnimation(keyPath: "path")
                plateMove.fromValue = plate[0].path
                plateMove.toValue = UIBezierPath(rect: CGRect(x: -destination + i + (widthIn/2), y: 0, width: widthIn , height: wtStopHeight*5)).CGPath
                plateMove.duration = 0.2 + NSTimeInterval(i / 150)
                
                let plateTwoMove = CABasicAnimation(keyPath: "path")
                plateTwoMove.fromValue = plate[0].path
                plateTwoMove.toValue = UIBezierPath(rect: CGRect(x: destination - i - (widthIn/2), y: 0, width: widthIn , height: wtStopHeight*5)).CGPath
                plateTwoMove.duration = 0.2 + NSTimeInterval(i / 150)
                
                plate[0].addAnimation(plateMove, forKey: nil)
                plate[1].addAnimation(plateTwoMove, forKey: nil)
                
                plate[0].path = UIBezierPath(rect: CGRect(x: -destination + i + (widthIn/2), y: 0, width: widthIn , height: wtStopHeight*5)).CGPath
                plate[1].path = UIBezierPath(rect: CGRect(x: destination - i - (widthIn/2), y: 0, width: widthIn , height: wtStopHeight*5)).CGPath


                i = i + (widthIn) + 0.5

                

                
            }
        
        } else{
            println("no bar cant load")

        }
    }
    
    func makePlate(width: CGFloat)->[CAShapeLayer]{
        
        //need to clean this up
        var foo = CAShapeLayer()
        var baar = CAShapeLayer()
        var fooPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width , height: wtStopHeight*5))
        foo.path = fooPath.CGPath
        foo.bounds = CGPathGetBoundingBox(foo.path)
        foo.fillColor = UIColor.redColor().CGColor
        var baarPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width , height: wtStopHeight*5))
        baar.path = baarPath.CGPath
        baar.bounds = CGPathGetBoundingBox(baar.path)
        baar.fillColor = UIColor.blueColor().CGColor
        
        return [foo, baar]
    }

}
