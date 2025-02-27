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
    
    var controllers: [NavigableStack<Page>]
    
    init(_ controllers: [NavigableStack<Page>]) {
        self.controllers = controllers
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(controllers) { controller in
                    if controller.page.placement.isInSideBar {
                        SideBarButton(page: controller.page)
                            .environment(\.navigationStack, controller.path)
                            .environment(\.setNavigationStack, SetNavigationStackAction(action: { stack in
                                controller.path = stack as! [Page]
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
