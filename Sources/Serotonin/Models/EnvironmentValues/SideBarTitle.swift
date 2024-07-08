//
//  SideBarTitle.swift
//  
//
//  Created by Abdulilah Imad on 7/3/24.
//

import SwiftUI

private struct SideBarTitleKey: EnvironmentKey {
    static let defaultValue: LocalizedStringKey = ""
}

public extension EnvironmentValues {
    var sideBarTitle: LocalizedStringKey {
        get { self[SideBarTitleKey.self] }
        set { self[SideBarTitleKey.self] = newValue }
    }
}
