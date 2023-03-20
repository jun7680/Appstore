//
//  RecentTermTableViewCell.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit

class RecentTermTableViewCell: BaseTableViewCell {
    static let identifier = "RecentTermTableViewCell"
    
    private let termLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        contentView.addSubview(termLabel)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        termLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func update(with term: String) {
        termLabel.text = term
    }
}
