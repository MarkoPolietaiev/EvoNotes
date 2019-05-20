//
//  BaseViewController.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/20/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import SwifterSwift

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.interactivePopGestureRecognizer?.delegate = self
        initBackButton()
    }
    
    @objc func clickedBackButton() {
        navigationController?.popViewController()
    }
}

// MARK: Custom back button
private extension BaseViewController {
    func initBackButton() {
        if (navigationController != nil && (navigationController?.viewControllers.count)! > 1 && navigationItem.leftBarButtonItem == nil) {
            navigationItem.hidesBackButton = true
            
            let backButton = UIBarButtonItem.init(image: R.image.backButton(),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(clickedBackButton))
            backButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20)
            navigationItem.leftBarButtonItem = backButton
        }
    }
}

//// MARK: UIGestureRecognizerDelegate
//extension BaseViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
