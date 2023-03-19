//
//  BaseViewController.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initConstraints()
        subscribeUI()
        bindUI()
    }
    
    func setupViews() {}
    func initConstraints() {}
    func subscribeUI() {}
    func bindUI() {}
}
