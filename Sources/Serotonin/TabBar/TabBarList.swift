//
//  TabBarList.swift
//
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI

struct TabBarList<Page: Navigable>: View {
    var controllers: [NavigableStack<Page>]
    
    init(_ controllers: [NavigableStack<Page>]) {
        self.controllers = controllers
    }
    
    var body: some View {
        VStack(spacing: 7) {
            Divider()
            
            HStack(spacing: 50) {
                ForEach(controllers) { controller in
                    if controller.page.placement.isInTabBar {
                        TabBarButton(page: controller.page)
                            .environment(\.navigationStack, controller.path)
                            .environment(\.setNavigationStack, SetNavigationStackAction(action: { stack in
                                controller.path = stack as! [Page]
                            }))
                    }
                }
            }.padding(.horizontal, 25)
        }
        .frame(height: 50)
        .background {
            Rectangle()
                .fill(.thinMaterial)
                .ignoresSafeArea(edges: .all)
        }
    }
}
