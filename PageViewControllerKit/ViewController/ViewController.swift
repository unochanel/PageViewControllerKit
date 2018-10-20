//
//  ViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let reuseIdentifier = "ViewController"

    let item = ["first", "second", "third"]
    static func make() -> ViewController {
        let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
        
    }

    static func makeList() -> [ViewController] {
        return [
            QuestionListViewController.make(userCategory: .cognition),
            QuestionListViewController.make(userCategory: .report),
            QuestionListViewController.make(userCategory: .money),
            QuestionListViewController.make(userCategory: .service),
            QuestionListViewController.make(userCategory: .family),
            QuestionListViewController.make(userCategory: .etc)
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

