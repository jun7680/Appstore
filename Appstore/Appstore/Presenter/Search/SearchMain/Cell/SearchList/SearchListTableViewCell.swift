//
//  SearchListTableViewCell.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/20.
//

import UIKit
import RxSwift
import RxCocoa

class SearchListTableViewCell: BaseTableViewCell {
    static let identifier = "SearchListTableViewCell"
    private var disposeBag = DisposeBag()
    // MARK: - property
    
    var searchSnippet: SearchResult? {
        didSet {
            update()
        }
    }
    // MARK: - UI
    
    private let topContainerView = UIView()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private let ratingView = UIView()
    
    private let installButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemGray3
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let screenShotStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let screenShot: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    private let screenShot2: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    private let screenShot3: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        screenShot.image = nil
        screenShot2.image = nil
        screenShot3.image = nil
    }
    override func setupViews() {
        super.setupViews()
        
        selectionStyle = .none
        
        let views = [
            topContainerView,
            screenShotStackView
        ]
        
        let topChildViews = [
            thumbnailImageView,
            appTitleLabel,
            categoryLabel,
            installButton,
            ratingView
        ]
        
        let screenShotViews = [
            screenShot,
            screenShot2,
            screenShot3
        ]
        
        screenShotStackView.addArrangedSubviews(screenShotViews)
        
        topContainerView.addSubviews(topChildViews)
        
        contentView.addSubviews(views)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        topContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.size.equalTo(56)
        }
        
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.top)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(8)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(appTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(appTitleLabel)
        }
        
        // FIXME: - 고쳐야함
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalTo(appTitleLabel)
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
        
        installButton.snp.makeConstraints { make in
            make.centerY.equalTo(thumbnailImageView)
            make.width.equalTo(56)
            make.leading.equalTo(appTitleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
        
        screenShotStackView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        screenShot.snp.makeConstraints { make in
            make.height.equalTo(230)
        }
    }

    private func update() {
        // TODO: - Update
        guard let searchSnippet else { return }
        loadScreenShots(urls: searchSnippet.screenshotUrls)
        appTitleLabel.text = searchSnippet.trackName
        categoryLabel.text = searchSnippet.primaryGenreName
        thumbnailImageView.setImage(from: searchSnippet.artworkUrl60)
        
    }
    private func loadScreenShots(urls: [String]) {
        screenShot.setImage(from: urls[0])
        if urls.count > 1 {
            screenShot2.setImage(from: urls[1])
        }
        
        if urls.count > 2 {
            screenShot3.setImage(from: urls[2])
        }
        
    }
}
