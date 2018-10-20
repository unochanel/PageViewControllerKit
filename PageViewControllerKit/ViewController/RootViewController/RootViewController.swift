//
//  RootViewController.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

fileprivate let titleWidth: CGFloat = 110.0
fileprivate let indicatorViewHeight: CGFloat = 4.0

final class RootViewController: UIViewController {
    
    private let pageType: [PageType] = [.first, .second, .third, .forth, .fifth]
    @IBOutlet private weak var pageContainerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!

    private let selectionIndicatorView: UIView = {
        let view: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: titleWidth, height: indicatorViewHeight))
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        embedPageViewController()
        configureCollectionView()
        configureIndicatorView()
    }
    
    private func embedPageViewController() {
        let viewController = PageViewController.make(type: pageType)
        embed(viewController, to: pageContainerView)
    }
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: SegmentCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SegmentCell.reuseIdentifier)
        collectionView.scrollsToTop = false
    }
    
    private func configureIndicatorView() {
        selectionIndicatorView.frame.origin.y = collectionView.frame.height - indicatorViewHeight
        collectionView.addSubview(selectionIndicatorView)
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

extension RootViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = pageType[indexPath.row].rawValue
        label.sizeToFit()
        return CGSize(width: 100, height: label.frame.size.height + 24)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionIndicatorView.frame.origin.x = CGFloat(indexPath.row * Int(titleWidth))
    }
}
