//
//  UIViewExtension.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
