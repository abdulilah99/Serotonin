//
//  SideBarToggle.swift
//  
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

struct SideBarToggleAction {
    typealias Action = () -> Void
    let action: Action
    
    func callAsFunction() {
        action()
    }
}

struct SideBarToggleActionKey: EnvironmentKey {
    static var defaultValue: SideBarToggleAction = .init(action: {})
}

extension EnvironmentValues {
    var toggleSideBar: SideBarToggleAction {
        get { self[SideBarToggleActionKey.self] }
        set { self[SideBarToggleActionKey.self] = newValue }
    }
}
