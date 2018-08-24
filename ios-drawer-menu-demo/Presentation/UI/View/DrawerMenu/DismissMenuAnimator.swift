//
//  DismissMenuAnimator.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class DismissMenuAnimator: NSObject {}

extension DismissMenuAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = containerView.viewWithTag(MenuHelper.snapshotTag)
            else {
                return
        }

        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: animationDuration, animations: {

            snapshot.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)

        }, completion: { _ in

            let didTransitionComplete = !transitionContext.transitionWasCancelled
            if didTransitionComplete {
                containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                snapshot.removeFromSuperview()
            }

            transitionContext.completeTransition(didTransitionComplete)

        })
    }
}
