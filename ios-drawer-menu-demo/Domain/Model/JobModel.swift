//
//  JobModel.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct JobModel {

    var companyName: String
    var jobImageUrl: String
    var location: String
    var salary: String
    var jobDetailInfo: String

    init(companyName: String, jobImageUrl: String, location: String, salary: String, jobDetailInfo: String) {
        self.companyName = companyName
        self.jobImageUrl = jobImageUrl
        self.location = location
        self.salary = salary
        self.jobDetailInfo = jobDetailInfo
    }
}
