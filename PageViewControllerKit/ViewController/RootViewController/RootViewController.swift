//
//  RootViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

fileprivate let titleCollectionViewHeight: CGFloat = 50.0

final class RootViewController: UIViewController {
    
    private let pageType: [PageType] = PageType.allCases
    @IBOutlet private weak var pageContainerView: UIView!
    @IBOutlet private weak var pagingSegmentedControlView: UIView!
    private var pagingSegmentedControl: PagingSegmentedControl!
    private var pageViewController: PageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        embedPageViewController()
        configureSegmentedControl()
    }
    
    private func embedPageViewController() {
        let viewController = PageViewController.make(type: pageType)
        pageViewController = viewController
        embed(viewController, to: pageContainerView)
    }
    
    private func configureSegmentedControl() {
        pagingSegmentedControl = PagingSegmentedControl.make(items: pageType, delegate: pageViewController)
        pagingSegmentedControlView.addSubview(pagingSegmentedControl)
        adujustPaginsegmentedControlLayout()
    }
}

extension RootViewController {
    private func adujustPaginsegmentedControlLayout() {
        pagingSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        pagingSegmentedControl.bottomAnchor.constraint(equalTo: pagingSegmentedControlView.bottomAnchor, constant: 0.0).isActive = true
        pagingSegmentedControl.leadingAnchor.constraint(equalTo: pagingSegmentedControlView.leadingAnchor, constant: 0.0).isActive = true
        pagingSegmentedControl.trailingAnchor.constraint(equalTo: pagingSegmentedControlView.trailingAnchor, constant: 0.0).isActive = true
        pagingSegmentedControl.heightAnchor.constraint(equalToConstant: titleCollectionViewHeight).isActive = true
    }
}
