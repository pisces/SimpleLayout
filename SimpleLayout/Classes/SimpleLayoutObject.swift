//
//  SimpleLayoutObject.swift
//  SimpleLayout
//
//  Created by pisces on 02/01/2017.
//  Modified by pisces on 12/14/2017.
//      - Support iOS 11 and higher
//  Modified by pisces on 4/12/2018.
//      - Add priority to NSLayoutConstraint
//  Modified by pisces on 4/6/2019.
//      - Remove constraint if it is equal to origin when set the new constraint.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import UIKit

public class SimpleLayoutObject: NSObject {
    
    // MARK: - Properties
    
    private weak var view: UIView!
    
    public private(set) var constraints = NSLayoutConstraints()
    
    // MARK: - Con(De)structor
    
    convenience public init(view: UIView) {
        self.init()
        
        self.view = view
    }
    
    // MARK: - Public methods
    
    public func apply() {
        view.layoutIfNeeded()
        view.superview?.layoutIfNeeded()
    }
    
    @discardableResult
    public func bottom(by target: Any? = nil, priority: UILayoutPriority = .required, attribute: NSLayoutConstraint.Attribute = .bottom, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: multiplier, constant: constant)
        
        removeBottom(with: new)
        
        constraints.bottom = new
        constraints.bottom?.priority = priority
        constraints.bottom?.isActive = true
        return self
    }
    @discardableResult
    public func center(by target: Any? = nil, centerX: Bool = true, centerY: Bool = true, x: CGFloat = 0, y: CGFloat = 0) -> SimpleLayoutObject {
        if centerX {
            self.centerX(by: target, x)
        }
        if centerY {
            self.centerY(by: target, y)
        }
        return self
    }
    @discardableResult
    public func centerX(by target: Any? = nil, priority: UILayoutPriority = .required, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: item, attribute: .centerX, multiplier: multiplier, constant: constant)
        
        removeHorizontalConstraints(with: new)
        
        constraints.centerX = new
        constraints.centerX?.priority = priority
        constraints.centerX?.isActive = true
        return self
    }
    @discardableResult
    public func centerY(by target: Any? = nil, priority: UILayoutPriority = .required, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: multiplier, constant: constant)
        
        removeVerticalConstraints(with: new)
        
        constraints.centerY = new
        constraints.centerY?.priority = priority
        constraints.centerY?.isActive = true
        return self
    }
    @discardableResult
    public func trailing(by target: Any? = nil, priority: UILayoutPriority = .required, attribute: NSLayoutConstraint.Attribute = .trailing, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: relation, toItem: item, attribute: attribute, multiplier: multiplier, constant: constant)
        
        removeTrailing(with: new)
        
        constraints.trailing = new
        constraints.trailing?.priority = priority
        constraints.trailing?.isActive = true
        return self
    }
    @discardableResult
    public func fill(matchParent: Bool = false, multiplier: CGFloat = 1.0, leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) -> SimpleLayoutObject {
        removeHorizontalConstraints()
        removeVerticalConstraints()
        
        if matchParent {
            self.leading(multiplier: multiplier, leading)
            self.top(multiplier: multiplier, top)
            self.width(multiplier: multiplier, -(leading + trailing))
            self.height(multiplier: multiplier, -(top + bottom))
        } else {
            self.leading(multiplier: multiplier, leading)
            self.top(multiplier: multiplier, top)
            self.trailing(multiplier: multiplier, trailing)
            self.bottom(multiplier: multiplier, bottom)
        }
        return self
    }
    @discardableResult
    public func height(by target: Any? = nil, priority: UILayoutPriority = .required, fixed: CGFloat = -1, relation: NSLayoutConstraint.Relation = .equal, attribute: NSLayoutConstraint.Attribute = .height, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        if let height = constraints.height {
            view.removeConstraint(height)
            view.superview?.removeConstraint(height)
        }
        
        if fixed > -1 {
            constraints.height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: fixed)
        } else {
            constraints.height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: relation, toItem: toItem(with: target), attribute: attribute, multiplier: multiplier, constant: constant)
        }
        constraints.height?.priority = priority
        constraints.height?.isActive = true
        return self
    }
    @discardableResult
    public func leading(by target: Any? = nil, priority: UILayoutPriority = .required, attribute: NSLayoutConstraint.Attribute = .leading, relation: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: relation, toItem: item, attribute: attribute, multiplier: multiplier, constant: constant)
        
        removeLeading(with: new)
        
        constraints.leading = new
        constraints.leading?.priority = priority
        constraints.leading?.isActive = true
        return self
    }
    @discardableResult
    public func top(by target: Any? = nil, priority: UILayoutPriority = .required, attribute: NSLayoutConstraint.Attribute = .top, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        let item = toItem(with: target)
        let new = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: multiplier, constant: constant)
        
        removeTop(with: new)
        
        constraints.top = new
        constraints.top?.priority = priority
        constraints.top?.isActive = true
        return self
    }
    @discardableResult
    public func width(by target: Any? = nil, priority: UILayoutPriority = .required, fixed: CGFloat = -1, relation: NSLayoutConstraint.Relation = .equal, attribute: NSLayoutConstraint.Attribute = .width, multiplier: CGFloat = 1.0, _ constant: CGFloat = 0) -> SimpleLayoutObject {
        if let width = constraints.width {
            view.removeConstraint(width)
            view.superview?.removeConstraint(width)
        }
        
        if fixed > -1 {
            constraints.width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: fixed)
        } else {
            constraints.width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: relation, toItem: toItem(with: target), attribute: attribute, multiplier: multiplier, constant: constant)
        }
        constraints.width?.priority = priority
        constraints.width?.isActive = true
        return self
    }
    
    // MARK: - Remove constraint
    
    @discardableResult
    public func removeBottom(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.bottom, new: new) {
            constraints.bottom = nil
        }
        return self
    }
    @discardableResult
    public func removeCenterX(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.centerX, new: new) {
            constraints.centerX = nil
        }
        return self
    }
    @discardableResult
    public func removeCenterY(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.centerY, new: new) {
            constraints.centerY = nil
        }
        return self
    }
    @discardableResult
    public func removeLeading(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.leading, new: new) {
            constraints.leading = nil
        }
        return self
    }
    @discardableResult
    public func removeTop(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.top, new: new) {
            constraints.top = nil
        }
        return self
    }
    @discardableResult
    public func removeTrailing(with new: NSLayoutConstraint? = nil) -> SimpleLayoutObject {
        if removeConstraint(constraints.trailing, new: new) {
            constraints.trailing = nil
        }
        return self
    }
    
    // MARK: - Private methods
    
    private func isRemovableConstraint(_ constraint: NSLayoutConstraint, new: NSLayoutConstraint?) -> Bool {
        guard let new = new, constraint.firstAttribute != new.firstAttribute else {
            return true
        }
        let originItem = (constraint.secondItem as? UIView) ?? (constraint.secondItem as? NSLayoutConstraint)
        let newItem = (new.secondItem as? UIView) ?? (new.secondItem as? NSLayoutConstraint)
        return originItem == newItem
    }
    private func removeConstraint(_ constraint: NSLayoutConstraint?, new: NSLayoutConstraint?) -> Bool {
        guard let constraint = constraint, isRemovableConstraint(constraint, new: new) else {
            return false
        }
        view.superview?.removeConstraint(constraint)
        return true
    }
    private func removeHorizontalConstraints(with new: NSLayoutConstraint? = nil) {
        removeLeading(with: new)
        removeTrailing(with: new)
        removeCenterX(with: new)
    }
    private func removeVerticalConstraints(with new: NSLayoutConstraint? = nil) {
        removeTop(with: new)
        removeCenterY(with: new)
        removeBottom(with: new)
    }
    private func toItem(with target: Any?) -> Any? {
        return target != nil ? target! : view.superview as Any
    }
}

public struct NSLayoutConstraints {
    public var array: [NSLayoutConstraint] {
        let _array: NSMutableArray = []
        appendConstraint(leading, toArray: _array)
        appendConstraint(top, toArray: _array)
        appendConstraint(trailing, toArray: _array)
        appendConstraint(bottom, toArray: _array)
        appendConstraint(height, toArray: _array)
        appendConstraint(width, toArray: _array)
        appendConstraint(centerX, toArray: _array)
        appendConstraint(centerY, toArray: _array)
        return _array as NSArray as! [NSLayoutConstraint]
    }
    public var leading: NSLayoutConstraint?
    public var top: NSLayoutConstraint?
    public var trailing: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    
    public init(leading: NSLayoutConstraint? = nil,
                top: NSLayoutConstraint? = nil,
                trailing: NSLayoutConstraint? = nil,
                bottom: NSLayoutConstraint? = nil,
                height: NSLayoutConstraint? = nil,
                width: NSLayoutConstraint? = nil,
                centerX: NSLayoutConstraint? = nil,
                centerY: NSLayoutConstraint? = nil) {
        self.leading = leading
        self.top = top
        self.trailing = trailing
        self.bottom = bottom
        self.height = height
        self.width = width
        self.centerX = centerX
        self.centerY = centerY
    }
    
    private func appendConstraint(_ constraint: NSLayoutConstraint?, toArray: NSMutableArray) {
        if let constraint = constraint {
            toArray.add(constraint)
        }
    }
}
