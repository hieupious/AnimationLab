//
//  ViewController.swift
//  AnimationLab
//
//  Created by Hoang Trung Hieu on 3/30/16.
//  Copyright © 2016 Hoang Trung Hieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //trayOriginalCenter = trayView.center
        trayCenterWhenOpen = CGPoint(x: 0, y: 320)
        trayCenterWhenClosed = CGPoint(x: 0, y: 520)
        trayView.frame.origin = trayCenterWhenClosed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(trayView)
        let translation = panGestureRecognizer.translationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
//            trayView.center = trayOriginalCenter
            UIView.animateWithDuration(0.5, animations: {
                if velocity.y > 0 {
                    self.trayView.frame.origin = self.trayCenterWhenClosed
                } else {
                    self.trayView.frame.origin = self.trayCenterWhenOpen
                }
            })
            
            
        }
        
        
    }
    
    
    @IBAction func onTapTrayViewGesture(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, animations: {
            if self.trayView.frame.origin == self.trayCenterWhenOpen {
                self.trayView.frame.origin = self.trayCenterWhenClosed
            } else {
                self.trayView.frame.origin = self.trayCenterWhenOpen
            }
        })
    }

}

