//
//  String+Path.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension String {

    // MARK: - Directory path

    static var documentsDirectory: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }

    // MARK: - NSString helper

    private var nsString: NSString {
        return self as NSString
    }

    func appendingPathComponent(_ str: String) -> String {
        return nsString.appendingPathComponent(str)
    }
}
