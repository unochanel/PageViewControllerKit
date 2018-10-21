//
//  SegmentCellDelegate.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/21.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

protocol SegmentCellDelegateProtocol {
    func tappedSegmentCell(_ tappedPageType: PageType, selectedIndex index: Int)
}
