//
//  SideBarList.swift
//  
//
//  Created by Abdulilah Imad on 7/3/24.
//

import SwiftUI

struct SideBarList<Page: Navigable>: View {
    @Environment(\.isSideBarPresented) private var isSideBarPresented
    @Environment(\.toggleSideBar) private var toggleSideBar
    @Environment(\.sideBarTitle) private var sideBarTitle
    
    var stacks: [NavigableStack<Page>]
    
    init(_ stacks: [NavigableStack<Page>]) {
        self.stacks = stacks
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(stacks) { stack in
                    if stack.page.placement.isInSideBar {
                        SideBarButton(page: stack.page)
                            .environment(\.navigationPath, stack.path)
                            .environment(\.setNavigationPath, SetNavigationPathAction(action: { path in
                                stack.path = path as! [Page]
                            }))
                    }
                }
            }
            .listStyle(.plain)
            .background(Color(.secondarySystemGroupedBackground))
            .navigationTitle(sideBarTitle)
            .toolbar { SideBarToggleButton(isInSideBar: true) }
        }
        .frame(maxHeight: .infinity)
        .frame(width: 320)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
