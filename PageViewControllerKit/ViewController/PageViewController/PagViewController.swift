//
//  PagViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    private let pageType: [PageType] = [.first, .second, .third]
    
    lazy var pageViewControllers: [ViewController] = {
        return ViewController.makeList()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
    }
    
    private func configurePageViewController() {
//        dataSource = self
//        delegate = self
        configurePageFirstView()
    }
    
    private func configurePageFirstView() {
        guard let firstPage = pageViewControllers.first else {
            assertionFailure()
            return
        }
        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }
    
}
//extension PageViewController: UIPageViewControllerDelegate {
//}
//
//extension PageViewController: UIPageViewControllerDataSource {
//}
//    //DataSourceのメソッド
//    //指定されたViewControllerの前にViewControllerを返す
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        var index = viewController.view.tag
//        pageControl.currentPage = index
//        index = index - 1
//        if index < 0{
//            return nil
//        }
//        return viewControllersArray[index]
//    }
//
//    //Viewが変更されると呼ばれる
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
//        print("moved")
//    }
//}
