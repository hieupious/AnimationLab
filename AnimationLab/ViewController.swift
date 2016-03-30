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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //trayOriginalCenter = trayView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let point = panGestureRecognizer.locationInView(trayView)
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            print("Gesture changed at: \(point)")
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
//            trayView.center = trayOriginalCenter
        }
        
        
    }

}

