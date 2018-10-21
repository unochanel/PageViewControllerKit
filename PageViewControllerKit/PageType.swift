//
//  PageType.swift
//  PageViewControllerKit
//
//  Created by 宇野凌平 on 2018/10/21.
//  Copyright © 2018年 ryouheiuno. All rights reserved.
//

import UIKit

enum PageType: String {
    case first
    case second
    case third
    case forth
    case fifth
    case sixth
    
    func viewControllerColor() -> UIColor {
        switch self {
        case .first:
            return UIColor.white
        case .second:
            return UIColor.yellow
        case .third:
            return UIColor.green
        case .forth:
            return UIColor.blue
        case .fifth:
            return UIColor.purple
        case .sixth:
            return UIColor.red
        }
    }
}
