//
//  JobCell.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class JobCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var jobDetailInfoLabel: UILabel!

    var jobModel: JobModel? {
        didSet {
            setJobModel(jobModel: jobModel)
        }
    }

    static var rowHeight: CGFloat {
        return CGFloat(190.0)
    }

    static var identifier: String {
        return String(describing: self)
    }

    private func setJobModel(jobModel: JobModel?) {

        guard let jobModel = jobModel else {
            return
        }

        self.companyNameLabel.text = jobModel.companyName
        self.locationLabel.text = jobModel.location
        self.salaryLabel.text = jobModel.salary
        self.jobDetailInfoLabel.text = jobModel.jobDetailInfo
        self.jobImageView.setImageByNuke(with: URL(string: jobModel.jobImageUrl))
    }
}
