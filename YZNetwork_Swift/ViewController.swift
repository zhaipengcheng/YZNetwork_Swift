//
//  ViewController.swift
//  YZNetwork_Swift
//
//  Created by 翟鹏程 on 2023/10/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func login(_ data: User) {
        data.phone = "123"
        
        YZNetworkRepository.shared
            .login(data)
            .subscribeSuccess { [weak self] data in
                print("login success")
            }.disposed(by: rx.disposeBag)
    }

}

