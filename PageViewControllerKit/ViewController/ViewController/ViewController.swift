//
//  ViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    static let reuseIdentifier = "ViewController"
    
    static func make(type: PageType) -> ViewController {
        let storyboard = UIStoryboard(name: reuseIdentifier, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: reuseIdentifier) as! ViewController
        viewController.pageType = type
        return viewController
    }
    
    static func makeList() -> [ViewController] {
        return [
            ViewController.make(type: .first),
            ViewController.make(type: .second),
            ViewController.make(type: .third),
            ViewController.make(type: .forth),
            ViewController.make(type: .fifth),
            ViewController.make(type: .sixth)
        ]
    }

    private var pageType: PageType!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.view.backgroundColor = pageType.viewControllerColor()
    }
}

