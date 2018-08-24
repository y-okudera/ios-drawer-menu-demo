//
//  JobTranslator.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct JobTranslator: Translator {

    typealias Input = JobMasterEntity
    typealias Output = JobModel
    
    func translate(_ entity: JobMasterEntity) -> JobModel {
        return JobModel(
            companyName: entity.company_name,
            jobImageUrl: entity.job_image_url,
            location: entity.job_location,
            salary: entity.job_salary,
            jobDetailInfo: entity.job_detail_info
        )
    }
}
