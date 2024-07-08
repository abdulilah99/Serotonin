//
//  NavigationStack.swift
//
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

private struct NavigationStackKey: EnvironmentKey {
    static let defaultValue: [any Navigable] = []
}

public extension EnvironmentValues {
    var navigationStack: [any Navigable] {
        get { self[NavigationStackKey.self] }
        set { self[NavigationStackKey.self] = newValue }
    }
}
