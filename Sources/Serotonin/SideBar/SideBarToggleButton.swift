//
//  SideBarToggleButton.swift
//  
//
//  Created by Abdulilah Imad on 7/9/24.
//

import SwiftUI

struct SideBarToggleButton: ToolbarContent {
    @Environment(\.serotoninNamespace) private var serotoninNamespace
    @Environment(\.isSideBarPresented) private var isSideBarPresented
    @Environment(\.toggleSideBar) private var toggleSideBar
    
    @Namespace var defaultNamespace
    
    let isInSideBar: Bool
    
    var isShown: Bool {
        if isInSideBar {
            return isSideBarPresented
        }
        return !isSideBarPresented
    }
    
    var body: some ToolbarContent {
#if os(macOS)
        ToolbarItem(placement: .automatic) {
            if isShown {
                content()
            } else {
                content().hidden()
            }
        }
#else
        ToolbarItem(placement: .topBarLeading) {
            if isShown {
                content()
            } else {
                content().hidden()
            }
        }
#endif
    }
    
    func content() -> some View {
        Button(action: {
            toggleSideBar.callAsFunction()
        }) {
            Image(systemName: "sidebar.left")
        }
        .zIndex(1000)
        .matchedGeometryEffect(id: "sideBar.toggle", in: serotoninNamespace ?? defaultNamespace, isSource: isInSideBar)
    }
    
    func opacity() -> CGFloat {
        if isInSideBar {
            return isSideBarPresented ? 1 : 0
        }
        return isSideBarPresented ? 0 : 1
    }
}
