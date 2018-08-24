//
//  JobListViewController.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

protocol JobListViewInput: class {
    func setJobList(list: [JobModel])
}

final class JobListViewController: UIViewController {

    private let interactor = Interactor()
    private var jobList = [JobModel]()

    @IBOutlet weak var tableView: UITableView!
    var presenter: JobListPresenter?
    var sortType = JobListSortType.newestToOldest

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let jobCellNib = UINib(nibName: JobCell.identifier, bundle: nil)
        tableView.register(jobCellNib, forCellReuseIdentifier: JobCell.identifier)
        tableView.rowHeight = JobCell.rowHeight
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.fetchJobList(sortType: sortType)
    }

    // MARK: - IBActions

    @IBAction private func didTapMenuButton(_ sender: UIBarButtonItem) {
        transitionToMenu()
    }

    @IBAction private func screenEdgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {

        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .right
        )

        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor
        ) {
            self.transitionToMenu()
        }
    }

    // MARK: - Others

    private func transitionToMenu() {

        weak var weakSelf = self
        let menuViewController = MenuViewController.make(interactor: interactor, transitioningDelegate: weakSelf)
        present(menuViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension JobListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: JobCell.identifier, for: indexPath) as! JobCell
        cell.jobModel = jobList[indexPath.row]

        return cell
    }
}

// MARK: - UIViewControllerBuilder
extension JobListViewController: UIViewControllerBuilder {
    typealias Presenter = JobListPresenter
    func inject(presenter: JobListPresenter) {
        self.presenter = presenter
    }
}

// MARK: - JobListViewInput
extension JobListViewController: JobListViewInput {
    func setJobList(list: [JobModel]) {
        jobList = list
        tableView.reloadData()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension JobListViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactor.hasStarted ? interactor : nil
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return interactor.hasStarted ? interactor : nil
    }
}
