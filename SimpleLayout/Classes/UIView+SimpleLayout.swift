//
//  MIT License
//
//  Copyright (c) 2019 Steve Kim
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  UIView+SimpleLayout.swift
//  SimpleLayout
//
//  Created by Steve Kim on 9/7/16.
//  Copyright © 2019 Steve Kim. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Private Constants
    
    private struct AssociatedKeys {
        static var LayoutName = "LayoutName"
    }
    
    // MARK: - Pubilc Properties
    
    public var layout: SimpleLayoutObject {
        if let layout = objc_getAssociatedObject(self, &AssociatedKeys.LayoutName) as? SimpleLayoutObject {
            return layout
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let layout = SimpleLayoutObject(view: self)
        objc_setAssociatedObject(self, &AssociatedKeys.LayoutName, layout, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return layout
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
