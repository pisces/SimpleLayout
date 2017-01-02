//
//  ChainExampleViewController.swift
//  SimpleLayout
//
//  Created by pisces on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SimpleLayout

class ChainExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .bottom
        
        let subview1 = label(backgroundColor: .red, text: "subview1")
        let subview2 = label(backgroundColor: .purple, text: "subview2")
        let subview3 = label(backgroundColor: .blue, text: "subview3")
        
        self.view.addSubview(subview1)
        self.view.addSubview(subview2)
        self.view.addSubview(subview3)
        
        subview1.layout
            .leading()
            .top()
            .width()
            .height(fixed: 150)
        subview2.layout
            .leading(by: subview1)
            .top(by: subview1, attribute: .bottom)
            .width(fixed: self.view.width/2)
            .bottom()
        subview3.layout
            .leading(by: subview2, attribute: .trailing)
            .top(by: subview2)
            .trailing()
            .bottom()
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
