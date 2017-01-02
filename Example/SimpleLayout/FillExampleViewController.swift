//
//  FillExampleViewController.swift
//  SimpleLayout
//
//  Created by pisces on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SimpleLayout

class FillExampleViewController: UIViewController {
    
    private lazy var subview: UIView = {
        let label = UILabel()
        label.text = "subview"
        label.textColor = .white
        
        let subview = UIView()
        subview.backgroundColor = .red
        
        subview.addSubview(label)
        label.layout
            .leading()
            .top()
            .width(fixed: 0, relation: .greaterThanOrEqual)
            .height(fixed: 0, relation: .greaterThanOrEqual)
        return subview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .bottom
        
        let label = UILabel()
        label.text = "view"
        
        self.view.addSubview(label)
        self.view.addSubview(subview)
        label.layout
            .leading()
            .top()
            .width(fixed: 0, relation: .greaterThanOrEqual)
            .height(fixed: 0, relation: .greaterThanOrEqual)
        subview.layout.fill(leading: 30, top: 30, trailing: -30, bottom: -30)
    }
}
