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

extension EnvironmentValues {
    @Entry var setNavigationStack: SetNavigationStackAction = .init(action: { _ in })
}
