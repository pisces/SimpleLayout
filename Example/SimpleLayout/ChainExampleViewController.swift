//
//  ChainExampleViewController.swift
//  SimpleLayout
//
//  Created by pisces on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SimpleLayout_Swift

class ChainExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .bottom
        
        let subview1 = label(backgroundColor: .red, text: "subview1")
        let subview2 = label(backgroundColor: .purple, text: "subview2")
        let subview3 = label(backgroundColor: .blue, text: "subview3")
        
        view.addSubview(subview1)
        view.addSubview(subview2)
        view.addSubview(subview3)
        
        subview1.layout
            .leading()
            .top()
            .trailing()
            .height(fixed: 150)
        subview2.layout
            .leading(by: subview1)
            .top(by: subview1, attribute: .bottom)
            .width(fixed: view.width/2)
            .bottom(by: view._safeAreaLayoutGuide)
        subview3.layout
            .leading(by: subview2, attribute: .trailing)
            .top(by: subview2)
            .trailing(by: subview1)
            .bottom(by: subview2)
    }
    
    private func label(backgroundColor: UIColor, text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = backgroundColor
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        return label
    }
}

