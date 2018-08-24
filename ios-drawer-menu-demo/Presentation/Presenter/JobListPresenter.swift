//
//  JobListPresenter.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

/// ソートタイプ
///
/// - newestToOldest: 新着順
/// - theEarliestPostingEndDate: 掲載終了日が早い順
/// - 0:: .newestToOldest
/// - 1:: .theEarliestPostingEndDate
enum JobListSortType: Int {
    
    case newestToOldest
    case theEarliestPostingEndDate

    static func fromInt(intValue: Int) -> JobListSortType {
        switch intValue {
        case 0:
            return .newestToOldest
        case 1:
            return .theEarliestPostingEndDate
        default:
            return .newestToOldest
        }
    }
}

// MARK: - Interface
protocol JobListPresenter {
    func fetchJobList(sortType: JobListSortType)
}

// MARK: - Implementation
final class JobListPresenterImpl: JobListPresenter {

    weak var viewInput: JobListViewInput?
    let useCase: JobListUseCase

    init(useCase: JobListUseCase, viewInput: JobListViewInput) {
        self.useCase = useCase
        self.viewInput = viewInput
    }

    func fetchJobList(sortType: JobListSortType) {

        var jobList = [JobModel]()

        switch sortType {
        case .newestToOldest:
            jobList = useCase.fetchJobListSortedByNewestToOldest()
        case .theEarliestPostingEndDate:
            jobList = useCase.fetchJobListSortedByTheEarliestPostingEndDate()
        }
        
        viewInput?.setJobList(list: jobList)
    }
}
