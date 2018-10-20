//
//  RootViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    private let pageType: [PageType] = [.first, .second, .third]
    @IBOutlet private weak var pageContainerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        embedPageViewController()
        configureCollectionView()
    }

    private func embedPageViewController() {
        let viewController = PageViewController.make(type: pageType)
        embed(viewController, to: pageContainerView)
    }

    private func configureCollectionView() {
        collectionView.register(UINib(nibName: SegmentCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SegmentCell.reuseIdentifier)
        collectionView.scrollsToTop = false
    }
}

extension RootViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCell.reuseIdentifier, for: indexPath) as! SegmentCell
        cell.configure(item: pageType[indexPath.row])
        return cell
    }
}

extension RootViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = pageType[indexPath.row].rawValue
        label.sizeToFit()
        return CGSize(width: label.frame.size.width + 24, height: label.frame.size.height + 24)
    }
}
