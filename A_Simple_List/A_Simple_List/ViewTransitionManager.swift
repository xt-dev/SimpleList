//
//  ViewTransitionManager.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import Foundation
import UIKit

class ViewTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration = 0.5
    var isPresenting = false
    
    var snapshot:UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 50)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        // Add both views to the container view
        if isPresenting {
            print("taking snapshot")
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
//            let snapshot_size: CGRect = CGRect(x: 0, y: 20, width: (snapshot?.frame.width)!, height: ((snapshot?.frame.height)! - 20))
//            let snapshot_ei = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            fromView.resizableSnapshotView(from: snapshot_size, afterScreenUpdates: true, withCapInsets: snapshot_ei)
            container.addSubview(toView)
            container.addSubview(snapshot!)
            }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: [], animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
            
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
        
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
}
