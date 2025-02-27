//
//  SideBarView.swift
//  
//
//  Created by Abdulilah Imad on 7/3/24.
//

import SwiftUI

struct SideBarView<Content: View, Page: Navigable>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var controllers: [NavigableStack<Page>]
    var content: Content
    
    init(_ controllers: [NavigableStack<Page>], @ViewBuilder content: () -> Content) {
        self.controllers = controllers
        self.content = content()
    }
    
    @State var isSideBarPresented: Bool = true
    
    @Namespace var sideBarNamespace
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if isSideBarPresented && horizontalSizeClass != .compact {
                    HStack(spacing: 0) {
                        SideBarList(controllers)
                        
                        Divider()
                            .ignoresSafeArea(.all)
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.smooth, value: isSideBarPresented)
            .zIndex(4)
            
            content
        }
        .environment(\.isSideBarPresented, isSideBarPresented)
        .environment(\.toggleSideBar, SideBarToggleAction {
            isSideBarPresented.toggle()
        })
    }
}
