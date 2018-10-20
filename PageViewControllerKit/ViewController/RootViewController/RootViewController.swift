//
//  RootViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    @IBOutlet private weak var pageContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    
    private func configure() {
        embedPageViewController()
    }

    private func embedPageViewController() {
        let viewController = PageViewController.make()
        embed(viewController, to: pageContainerView)
    }
}
