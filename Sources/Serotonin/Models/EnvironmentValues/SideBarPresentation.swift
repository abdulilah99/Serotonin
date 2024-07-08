//
//  SideBarPresentation.swift
//  
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

private struct SideBarPresentationKey: EnvironmentKey {
    static let defaultValue: Bool = true
}

public extension EnvironmentValues {
    var isSideBarPresented: Bool {
        get { self[SideBarPresentationKey.self] }
        set { self[SideBarPresentationKey.self] = newValue }
    }
}
