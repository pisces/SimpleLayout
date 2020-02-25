//
//  UIView+SimpleLayout.swift
//  SimpleLayout
//
//  Created by pisces on 9/7/16.
//  Copyright © 2016 Steve Kim. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Public Constants
    
    private struct AssociatedKeys {
        static var LayoutName = "LayoutName"
    }
    
    // MARK: - Public Properties
    
    private(set) public var layout: SimpleLayoutObject {
        get {
            if let layout = objc_getAssociatedObject(self, &AssociatedKeys.LayoutName) as? SimpleLayoutObject {
                return layout
            }
            translatesAutoresizingMaskIntoConstraints = false
            
            let layout = SimpleLayoutObject(view: self)
            objc_setAssociatedObject(self, &AssociatedKeys.LayoutName, layout, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return layout
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.LayoutName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var right: CGFloat {
        return frame.maxX
    }
    public var bottom: CGFloat {
        return frame.maxY
    }
    public var x: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame = CGRect(x: newValue, y: frameOrigin.y, width: frameSize.width, height: frameSize.height)
        }
    }
    public var y: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame = CGRect(x: frameOrigin.x, y: newValue, width: frameSize.width, height: frameSize.height)
        }
    }
    public var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame = CGRect(x: frameOrigin.x, y: frameOrigin.y, width: frameSize.width, height: newValue)
        }
    }
    public var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame = CGRect(x: frameOrigin.x, y: frameOrigin.y, width: newValue, height: frameSize.height)
        }
    }
    public var frameOrigin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame = CGRect(x: newValue.x, y: newValue.y, width: frame.size.width, height: frame.size.height)
        }
    }
    public var frameSize: CGSize {
        get {
            return frame.size
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue.width, height: newValue.height)
        }
    }
    public var _safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        }
        return .zero
    }
    public var _safeAreaLayoutGuide: UILayoutGuide? {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide
        }
        return nil
    }
}
