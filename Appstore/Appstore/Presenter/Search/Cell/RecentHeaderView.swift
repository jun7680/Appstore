//
//  RecentHeaderView.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit

class RecentHeaderView: UIView {
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        initConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(headerTitle)
    }
    
    private func initConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
