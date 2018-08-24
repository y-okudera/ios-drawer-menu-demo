//
//  JobListRepository.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

// MARK: - Interface
protocol JobListRepository {
    func fetchJobListSortedByTheEarliestPostingEndDate() -> [JobMasterEntity]?
    func fetchJobListSortedByNewestToOldest() -> [JobMasterEntity]?
}

// MARK: - Implementation
final class JobListRepositoryImpl: JobListRepository {

    private let dataStore: JobMasterDataStore

    init(dataStore: JobMasterDataStore) {
        self.dataStore = dataStore
    }

    /// 掲載終了日が早い順で求人リストを取得する
    ///
    /// - Returns: [JobMasterEntity]? 取得結果の配列
    func fetchJobListSortedByTheEarliestPostingEndDate() -> [JobMasterEntity]? {
        return dataStore.selectAllSortedByPostingEndDateASC()
    }

    /// 新着順で求人リストを取得する
    ///
    /// - Returns: [JobMasterEntity]? 取得結果の配列
    func fetchJobListSortedByNewestToOldest() -> [JobMasterEntity]? {
        return dataStore.selectAllSortedByPostingStartDateASC()
    }
}
