//
//  SimpleLayoutGlobal.swift
//  SimpleLayout
//
//  Created by pisces on 02/01/2017.
//  Copyright © 2016 Steve Kim. All rights reserved.
//
//

import Foundation

public func getAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
    if let v = objc_getAssociatedObject(object, associativeKey) as? T {return v}
    if let v = objc_getAssociatedObject(object, associativeKey) as? Lifted<T> {return v.value}
    return nil
}
public func setAssociatedObject<T>(_ object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
    if let v: AnyObject = value as AnyObject {
        objc_setAssociatedObject(object, associativeKey, v,  policy)
    }
    else {
        objc_setAssociatedObject(object, associativeKey, lift(value),  policy)
    }
}

public final class Lifted<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}

private func lift<T>(_ x: T) -> Lifted<T>  {
    return Lifted(x)
}
