//
//  PagViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    
    static func make(type: [PageType]) -> PageViewController {
        let viewController = PageViewController()
        _ = type.map { viewController.pageType.append($0) }
        return viewController
    }
    
    lazy var pageViewControllers: [ViewController] = {
        return ViewController.makeList()
    }()
    
    private var pageType: [PageType] = []
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        configure()
        
    }
    
    private func configure() {
        guard let firstPage = pageViewControllers.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
    }
}

extension PageViewController: SegmentCellDelegateProtocol {
    func tappedSegmentCell(_ tappedPageType: PageType, selectedIndex index: Int) {
        if currentPage == index { return }
        if index >= currentPage {
            let currentViewController = pageViewControllers[index]
            setViewControllers([currentViewController], direction: .forward, animated: true, completion: nil)
        } else {
            let currentViewController = pageViewControllers[index]
            setViewControllers([currentViewController], direction: .reverse, animated: true, completion: nil)
        }
        currentPage = index
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
