//
//  NSLayoutConstraint+.swift
//  VRx
//
//  Created by Joseph on 12/2/20.
//

import UIKit

extension NSLayoutConstraint {

    static func setMultiplier(_ multiplier: CGFloat, of constraint: inout NSLayoutConstraint) {
        NSLayoutConstraint.deactivate([constraint])
        let newConstraint = NSLayoutConstraint(item: constraint.firstItem!, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: multiplier, constant: constraint.constant)
        newConstraint.priority = constraint.priority
        newConstraint.shouldBeArchived = constraint.shouldBeArchived
        newConstraint.identifier = constraint.identifier
        NSLayoutConstraint.activate([newConstraint])
        constraint = newConstraint
    }

    static func setRelation(_ relation: NSLayoutConstraint.Relation, of constraint: inout NSLayoutConstraint) {
        NSLayoutConstraint.deactivate([constraint])
        let newConstraint = NSLayoutConstraint(item: constraint.firstItem!, attribute: constraint.firstAttribute, relatedBy: relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant)
        newConstraint.priority = constraint.priority
        newConstraint.shouldBeArchived = constraint.shouldBeArchived
        newConstraint.identifier = constraint.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        constraint = newConstraint
    }
}
