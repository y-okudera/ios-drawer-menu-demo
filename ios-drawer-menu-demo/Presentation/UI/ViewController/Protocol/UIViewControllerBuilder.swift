//
//  UIViewControllerBuilder.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

protocol UIViewControllerBuilder {
    associatedtype Presenter
    func inject(presenter: Presenter)
}
