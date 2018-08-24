//
//  MenuViewController.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/25.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var interactor: Interactor?

    private let sectionName = "並び替え"
    private let contents = ["新着順", "掲載終了日が早い順"]

    // MARK: - Factory

    static func make(interactor: Interactor,
                     transitioningDelegate: UIViewControllerTransitioningDelegate?) -> MenuViewController {

        let storyboard = UIStoryboard(name: "MenuViewController", bundle: nil)
        guard let menuViewController = storyboard.instantiateViewController(
            withIdentifier: "MenuViewController") as? MenuViewController else {
                fatalError("MenuViewController is nil.")
        }

        menuViewController.interactor = interactor
        menuViewController.transitioningDelegate = transitioningDelegate
        return menuViewController
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - IBActions
    
    @IBAction private func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func panGesture(_ sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: view)

        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left
        )

        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor
        ) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "MenuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = contents[indexPath.row]

        return cell
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let nc = self.presentingViewController as? UINavigationController {
            let vc = nc.topViewController as! JobListViewController
            vc.sortType = JobListSortType.fromInt(intValue: indexPath.row)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
