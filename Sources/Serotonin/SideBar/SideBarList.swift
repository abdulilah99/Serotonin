//
//  SideBarList.swift
//  
//
//  Created by Abdulilah Imad on 7/3/24.
//

import SwiftUI

struct SideBarList<Page: Navigable, ToolBar: ToolbarContent>: View {
    @Environment(\.toggleSideBar) private var toggleSideBar
    @Environment(\.sideBarTitle) private var sideBarTitle
    
    var controllers: [NavigableController<Page>]
    var toolBar: ToolBar
    
    init(_ controllers: [NavigableController<Page>], toolBar: @escaping () -> ToolBar) {
        self.controllers = controllers
        self.toolBar = toolBar()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(controllers) { controller in
                    if controller.page.placement.isInSideBar {
                        TabBarButton(page: controller.page)
                            .environment(\.navigationStack, controller.stack)
                            .environment(\.setNavigationStack, SetNavigationStackAction(action: { stack in
                                controller.stack = stack as! [Page]
                            }))
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle(sideBarTitle)
            .toolbar { toolBar }
        }
        .frame(maxHeight: .infinity)
        .frame(width: 320)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
