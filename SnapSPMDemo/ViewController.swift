//
//  ViewController.swift
//  SnapSPMDemo
//
//  Created by Dhaval on 06/10/24.
//

import UIKit
import MyLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.gotoSnapViewController()
        }
    }
    
    func gotoSnapViewController() {
        let snpVC = SnapViewController()
        navigationController?.pushViewController(snpVC, animated: true)
    }


}

