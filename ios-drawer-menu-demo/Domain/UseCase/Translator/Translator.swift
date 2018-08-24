//
//  Translator.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    func translate(_: Input) -> Output
}
