//
//  SetNavigationStack.swift
//  
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

struct SetNavigationStackAction {
    typealias Action = ([any Navigable]) -> Void
    let action: Action
    
    func callAsFunction(stack: [any Navigable]) {
        action(stack)
    }
}

struct SetNavigationStackActionKey: EnvironmentKey {
    static var defaultValue: SetNavigationStackAction = .init(action: { _ in })
}

extension EnvironmentValues {
    var setNavigationStack: SetNavigationStackAction {
        get { self[SetNavigationStackActionKey.self] }
        set { self[SetNavigationStackActionKey.self] = newValue }
    }
}
