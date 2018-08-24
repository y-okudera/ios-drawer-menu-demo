//
//  JobListBuilder.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

struct JobListBuilder {

    func build() -> JobListViewController {
        let storyboard = UIStoryboard(name: "JobListViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JobListViewController") as! JobListViewController

        let dataStore = JobMasterDataStoreImpl()
        let repository = JobListRepositoryImpl(dataStore: dataStore)
        let useCase = JobListUseCaseImpl(repository: repository)
        let presenter = JobListPresenterImpl(useCase: useCase, viewInput: vc)
        vc.inject(presenter: presenter)
        
        return vc
    }
}
