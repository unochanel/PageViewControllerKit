//
//  PagViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

class PagViewController: UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configurePageView()
    }

    private func cofigurePageView() {
        self.setValuesForKeys()
    }
}
