//
//  JobMasterDataStore.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import GRDB

// MARK: - Interface
protocol JobMasterDataStore {
    func selectAllSortedByPostingEndDateASC() -> [JobMasterEntity]?
    func selectAllSortedByPostingStartDateASC() -> [JobMasterEntity]?
}

// MARK: - Implementation
final class JobMasterDataStoreImpl: JobMasterDataStore {

    /// 掲載終了日が早い順で全件取得する
    ///
    /// - Returns: [JobMasterEntity]? 取得結果の配列
    func selectAllSortedByPostingEndDateASC() -> [JobMasterEntity]? {

        let query = """
            SELECT j.job_image_url, j.job_location, j.job_salary, j.job_detail_info, c.company_name
            FROM job_master j
            INNER JOIN company_master c
            ON j.company_no = c.company_no
            ORDER BY posting_end_date ASC;
            """
        return select(query: query)
    }

    /// 新着順で全件取得する
    ///
    /// - Returns: [JobMasterEntity]? 取得結果の配列
    func selectAllSortedByPostingStartDateASC() -> [JobMasterEntity]? {
        
        let query = """
            SELECT j.job_image_url, j.job_location, j.job_salary, j.job_detail_info, c.company_name
            FROM job_master j
            INNER JOIN company_master c
            ON j.company_no = c.company_no
            ORDER BY posting_start_date ASC;
            """
        return select(query: query)
    }

    // MARK: - Private methods

    private func select(query: String) -> [JobMasterEntity]? {
        let queue = GRDBHelper.shared.queue
        let jobMasterEntityList = queue.read { db -> [JobMasterEntity]? in
            return try? JobMasterEntity.fetchAll(db, query)
        }
        return jobMasterEntityList
    }
}
