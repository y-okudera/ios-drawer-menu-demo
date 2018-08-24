//
//  PresentMenuAnimator.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class PresentMenuAnimator: NSObject {}

extension PresentMenuAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        // 遷移元のviewをスナップショットに置き換える
        guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
            return
        }
        snapshot.tag = MenuHelper.snapshotTag
        snapshot.isUserInteractionEnabled = false
        snapshot.layer.shadowOpacity = 0.7

        let shadowView = UIView(frame: snapshot.frame)
        shadowView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.alpha = 0.3
        snapshot.addSubview(shadowView)

        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.isHidden = true

        // スナップショットの移動先を定義
        let screenBounds = UIScreen.main.bounds
        let finalFrameTopLeftCorner = CGPoint(x: screenBounds.width * MenuHelper.menuWidth, y: 0)
        let snapshotFinalFrame = CGRect(origin: finalFrameTopLeftCorner, size: screenBounds.size)

        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: animationDuration, animations: {

            snapshot.frame = snapshotFinalFrame

        }, completion: { _ in

            fromVC.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

        })
    }
}
