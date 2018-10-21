//
//  SegmentCell.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/20.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

final class SegmentCell: UICollectionViewCell {
    static let reuseIdentifier = "SegmentCell"
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(item: PageType) {
        titleLabel.text = item.title()
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.backgroundColor = item.viewControllerColor().cgColor
    }
}
