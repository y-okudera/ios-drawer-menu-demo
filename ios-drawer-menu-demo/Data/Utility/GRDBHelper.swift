//
//  GRDBHelper.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import GRDB

final class GRDBHelper {

    private struct Const {
        static let dbFileName = "job"
        static let dbFileExtension = "sqlite3"
        static let dbPath = String.documentsDirectory.appendingPathComponent("\(dbFileName).\(dbFileExtension)")
    }

    static let shared = GRDBHelper()

    var queue: DatabaseQueue
    private init() {

        let dbPath = Const.dbPath
        if !FileManager.default.fileExists(atPath: dbPath) {
            let resourcePath = Bundle.main.path(forResource: Const.dbFileName, ofType: Const.dbFileExtension)!
            do {
                try FileManager.default.copyItem(atPath: resourcePath, toPath: dbPath)
            } catch {
                fatalError("db copy failed.")
            }
        }

        do {
            queue = try DatabaseQueue(path: dbPath)
        } catch {
            fatalError("DatabaseQueue initialize error:\(error)")
        }
    }
    
}
