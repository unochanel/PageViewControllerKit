//
//  PagingSegmentViewControl.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

fileprivate let titleWidth: CGFloat = 110.0
fileprivate let indicatorViewHeight: CGFloat = 4.0

class PagingSegmentedControl: UIControl {
    static func make(items: [PageType], delegate: SegmentCellDelegateProtocol) -> PagingSegmentedControl {
        let segmentedControl = PagingSegmentedControl(items: items, delegate: delegate)
        return segmentedControl
    }
    
    private let items: [PageType]
    private let segmentDelegate: SegmentCellDelegateProtocol?
    
    private let titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.register(UINib(nibName: SegmentCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: SegmentCell.reuseIdentifier)
        return collectionView
    }()
    private let selectionIndicatorView: UIView = {
//        let view: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: titleWidth, height: indicatorViewHeight))
        let view: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0, height: 0))
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        return view
    }()
    
    init(items: [PageType], delegate: SegmentCellDelegateProtocol?) {
        self.items = items
        self.segmentDelegate = delegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleCollectionView.dataSource = self
        titleCollectionView.delegate = self
        addSubview(titleCollectionView)
        adjuustSegmentedControl()
        
        selectionIndicatorView.frame.origin.y = frame.height - indicatorViewHeight
        selectionIndicatorView.autoresizingMask = [.flexibleTopMargin]
        titleCollectionView.addSubview(selectionIndicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateSelectionIndicatorViewAnimated(animated: Bool) {
        guard !items.isEmpty else { return  }
        guard
            let indexPath = titleCollectionView.indexPathsForSelectedItems?.first,
            let attributes = titleCollectionView.layoutAttributesForItem(at: indexPath) else {
                selectionIndicatorView.frame.size.width = 0.0
                return
        }
        
        UIView.animate(withDuration: animated ? 0.1 : 0.0) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.selectionIndicatorView.frame.origin.x = attributes.frame.minX
            weakSelf.selectionIndicatorView.frame.size.width = attributes.frame.width
        }
    }
}

extension PagingSegmentedControl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCell.reuseIdentifier, for: indexPath) as! SegmentCell
        cell.configure(item: items[indexPath.row])
        return cell
    }
}

extension PagingSegmentedControl: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        segmentDelegate?.tappedSegmentCell(items[indexPath.row], selectedIndex: indexPath.item)
        selectionIndicatorView.isHidden = items.count == 1
        guard !items.isEmpty else { return }

        let indexPath = IndexPath(item: indexPath.row, section: 0)
        titleCollectionView.selectItem(at: indexPath,
                                       animated: true,
                                       scrollPosition: .centeredHorizontally)
        sendActions(for: .valueChanged)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = items[indexPath.row].rawValue
        label.sizeToFit()
        return CGSize(width: titleWidth, height: label.frame.size.height + 24)
        
    }
}

extension PagingSegmentedControl {
    private func adjuustSegmentedControl() {
        titleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        titleCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        titleCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        titleCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        titleCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        
    }
}
