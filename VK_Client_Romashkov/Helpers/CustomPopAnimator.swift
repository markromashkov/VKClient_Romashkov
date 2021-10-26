//
//  CustomPopAnimator.swift
//  VK_Client_Romashkov
//
//  Created by Mark on 13.02.2021.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - Duration
    
    private let duration = 0.75
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // MARK: - Transition
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.frame = transitionContext.containerView.frame
        
        UIView.animate(
            withDuration: duration,
            animations: {
                source.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
                destination.view.transform = .identity
            }) { (isComplete) in
            if isComplete && !transitionContext.transitionWasCancelled {
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition( isComplete && !transitionContext.transitionWasCancelled)
        }
    }
}
