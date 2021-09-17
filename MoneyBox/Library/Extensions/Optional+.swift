//
//  Optional+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import Foundation

extension Optional {
    
    var isPresent: Bool {
        switch self {
        case .some:
            return true
        case .none:
            return false
        }
    }
    
    @discardableResult
    func ifPresent(
        _ action: (_ wrappedValue: Wrapped) -> Void,
        orElse elseAction: (VoidClosure) = {}
    ) -> Self {
        
        switch self {
        case .some(let value):
            action(value)
        case .none:
            elseAction()
        }
        
        return self
    }
}
