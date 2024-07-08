//
//  NavigationSelection.swift
//  
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

private struct NavigationSelectionKey: EnvironmentKey {
    static let defaultValue: (any Navigable)? = nil
}

public extension EnvironmentValues {
    var navigationSelection: (any Navigable)? {
        get { self[NavigationSelectionKey.self] }
        set { self[NavigationSelectionKey.self] = newValue }
    }
}
