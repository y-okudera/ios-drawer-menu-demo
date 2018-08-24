//
//  JobListUseCase.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

// MARK: - Interface
protocol JobListUseCase {
    func fetchJobListSortedByTheEarliestPostingEndDate() -> [JobModel]
    func fetchJobListSortedByNewestToOldest() -> [JobModel]
}

// MARK: - Implementation
final class JobListUseCaseImpl: JobListUseCase {

    private let repository: JobListRepository

    init(repository: JobListRepository) {
        self.repository = repository
    }

    /// 掲載終了日が早い順で求人リスト取得する
    ///
    /// - Returns: [JobModel] 取得結果の配列
    func fetchJobListSortedByTheEarliestPostingEndDate() -> [JobModel] {
        guard let entities = repository.fetchJobListSortedByTheEarliestPostingEndDate() else {
            return []
        }
        let translator = JobTranslator()
        return entities.map { translator.translate($0) }
    }

    /// 新着順で求人リスト取得する
    ///
    /// - Returns: [JobModel] 取得結果の配列
    func fetchJobListSortedByNewestToOldest() -> [JobModel] {
        guard let entities = repository.fetchJobListSortedByNewestToOldest() else {
            return []
        }
        let translator = JobTranslator()
        return entities.map { translator.translate($0) }
    }
}
