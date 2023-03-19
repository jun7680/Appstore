//
//  BaseTableViewCell.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    func initConstraint() {}
    func subscribeUI() {}
    func bind() {}
}
