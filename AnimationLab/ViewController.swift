//
//  ViewController.swift
//  AnimationLab
//
//  Created by Hoang Trung Hieu on 3/30/16.
//  Copyright © 2016 Hoang Trung Hieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyFaceCenter: CGPoint!
    var panFaceGestureRecognizer: UIPanGestureRecognizer!
    var pinchFaceGestureRecognizer: UIPinchGestureRecognizer!
    var rotateFaceGestureRecognizer: UIRotationGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var trayArrow: UIImageView!
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
                
                self.trayArrow.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                self.trayView.frame.origin = self.trayCenterWhenClosed
            } else {
                self.trayView.frame.origin = self.trayCenterWhenOpen
                self.trayArrow.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            }
        })
    }

    @IBAction func onPanSmileyGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            panFaceGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGestureFace(_:)))
            pinchFaceGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinchGestureFace(_:)))
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGesture.numberOfTapsRequired = 2
            pinchFaceGestureRecognizer.delegate = self
            rotateFaceGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(self.handleRotateGestureFace(_:)))
            
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panFaceGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(pinchFaceGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(rotateFaceGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(tapGesture)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyFaceCenter = newlyCreatedFace.center
            newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            newlyCreatedFace.center = CGPoint(x: newlyFaceCenter.x + translation.x, y: newlyFaceCenter.y + translation.y)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
            
            
        }
    }
    
    func handlePanGestureFace(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translationInView(view)
        
        if panGestureRecognizer.state == .Began {
//            newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
            newlyFaceCenter = newlyCreatedFace.center
        } else if panGestureRecognizer.state == .Changed {
            newlyCreatedFace.center = CGPoint(x: newlyFaceCenter.x + translation.x, y: newlyFaceCenter.y + translation.y)
        } else if panGestureRecognizer.state == .Ended {
           //newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
        }
    }
    
    func handlePinchGestureFace(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        
        let scale = pinchGestureRecognizer.scale
        let imageview = pinchGestureRecognizer.view as! UIImageView
        imageview.transform = CGAffineTransformScale(imageview.transform, scale, scale)
        pinchGestureRecognizer.scale = 1
        
        
    }
    
    func handleRotateGestureFace(sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        let imageView = sender.view as! UIImageView
        imageView.transform = CGAffineTransformRotate(imageView.transform, rotation)
        sender.rotation = 0
        print("rotate")
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 2 {
           sender.view?.removeFromSuperview()
        }
        
    }
}

