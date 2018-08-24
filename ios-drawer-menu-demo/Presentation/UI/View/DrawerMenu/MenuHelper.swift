//
//  MenuHelper.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case right
    case left
}

struct MenuHelper {

    static let menuWidth = CGFloat(0.7)
    static let percentThreshold = CGFloat(0.4)
    static let snapshotTag = 99999

    /// パンジェスチャーの移動量を計算する
    ///
    /// - Parameters:
    ///   - translationInView: x座標
    ///   - viewBounds: viewのbounds
    ///   - direction: 移動方向(right or left)
    /// - Returns: 移動量(0.0 ~ 1.0)
    static func calculateProgress(translationInView: CGPoint, viewBounds: CGRect, direction: Direction) -> CGFloat {

        let movementOnAxis = translationInView.x / viewBounds.width

        switch direction {
        case .right:
            let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)

        case .left:
            let positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            let positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }

    static func mapGestureStateToInteractor(gestureState: UIGestureRecognizerState,
                                            progress: CGFloat,
                                            interactor: Interactor?,
                                            triggerTransition: () -> ()) {

        guard let interactor = interactor else {
            return
        }

        switch gestureState {
        case .began:
            interactor.hasStarted = true
            triggerTransition()

        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)

        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()

        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()

        default:
            break
        }
    }
}
