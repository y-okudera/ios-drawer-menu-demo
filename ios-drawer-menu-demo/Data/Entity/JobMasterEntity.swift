//
//  JobMasterEntity.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import GRDB

struct JobMasterEntity: Codable, MutablePersistableRecord, FetchableRecord {

    static var databaseTableName: String {
        return "job_master"
    }
    
    var job_image_url = ""
    var job_location = ""
    var job_salary = ""
    var job_detail_info = ""
    var company_name = ""
}
