//
//  PagViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    static let reuseIdentifier = "PageViewController"
        
    static func make(type: [PageType]) -> PageViewController {
        let storyboard = UIStoryboard(name: reuseIdentifier, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: reuseIdentifier) as! PageViewController
        type.map { viewController.pageType.append($0) }
        return viewController
    }

    private var pageType: [PageType] = []
    private var currentPage = 0
    
    lazy var pageViewControllers: [ViewController] = {
        return ViewController.makeList()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configurePageViewController()
    }
    
    private func configurePageViewController() {
        dataSource = self
        configurePageFirstView()
    }
    
    private func configurePageFirstView() {
        guard let firstPage = pageViewControllers.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ViewController.self) {
            guard let viewController = viewController as? ViewController, var index = pageViewControllers.index(of: viewController) else { return nil }
            currentPage = index
            index -= 1
            if index < 0 { return nil }
            return pageViewControllers[index]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ViewController.self) {
            guard let viewController = viewController as? ViewController, var index = pageViewControllers.index(of: viewController) else { return nil }
            currentPage = index
            if index == pageType.count - 1 { return nil }
            index += 1
            return pageViewControllers[index]
        } else {
            return nil
        }
    }
}
