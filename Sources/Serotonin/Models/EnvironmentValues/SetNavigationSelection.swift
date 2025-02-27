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

extension EnvironmentValues {
    @Entry var setNavigationSelection: SetNavigationSelectionAction = .init(action: { _ in })
}
