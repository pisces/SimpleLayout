//
//  UIView+SimpleLayout.swift
//  SimpleLayout
//
//  Created by pisces on 9/7/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//

import UIKit

public extension UIView {
    // MARK: - Struct
    
    private struct AssociatedKeys {
        static var LayoutName = "LayoutName"
    }
    
    // MARK: - Properties
    
    public private(set) var layout: SimpleLayoutObject! {
        get {
            if let layout: SimpleLayoutObject? = getAssociatedObject(self, associativeKey: &AssociatedKeys.LayoutName) {
                return layout
            }
            
            self.translatesAutoresizingMaskIntoConstraints = false
            
            let layout = SimpleLayoutObject(view: self)
            setAssociatedObject(self, value: layout, associativeKey: &AssociatedKeys.LayoutName, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return layout
        }
        set(value) {
            setAssociatedObject(self, value: value, associativeKey: &AssociatedKeys.LayoutName, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var right: CGFloat {
        return self.frame.maxX
    }
    
    var bottom: CGFloat {
        return self.frame.maxY
    }
    
    var x: CGFloat {
        get {
            return self.frame.minX
        }
        set(value) {
            self.frame = CGRect(x: value, y: frameOrigin.y, width: frameSize.width, height: frameSize.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.minY
        }
        set(value) {
            self.frame = CGRect(x: frameOrigin.x, y: value, width: frameSize.width, height: frameSize.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.height
        }
        set(value) {
            self.frame = CGRect(x: frameOrigin.x, y: frameOrigin.y, width: frameSize.width, height: value)
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.width
        }
        set(value) {
            self.frame = CGRect(x: frameOrigin.x, y: frameOrigin.y, width: value, height: frameSize.height)
        }
    }
    
    var frameOrigin: CGPoint {
        get {
            return self.frame.origin
        }
        set(value) {
            self.frame = CGRect(x: value.x, y: value.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    var frameSize: CGSize {
        get {
            return self.frame.size
        }
        set(value) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: value.width, height: value.height)
        }
    }
}
