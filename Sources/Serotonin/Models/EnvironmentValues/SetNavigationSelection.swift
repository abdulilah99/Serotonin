//
//  SetNavigationSelection.swift
//
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

struct SetNavigationSelectionAction {
    typealias Action = (any Navigable) -> Void
    let action: Action
    
    func callAsFunction(selection: any Navigable) {
        action(selection)
    }
}

struct SetNavigationSelectionActionKey: EnvironmentKey {
    static var defaultValue: SetNavigationSelectionAction = .init(action: { _ in })
}

extension EnvironmentValues {
    var setNavigationSelection: SetNavigationSelectionAction {
        get { self[SetNavigationSelectionActionKey.self] }
        set { self[SetNavigationSelectionActionKey.self] = newValue }
    }
}
