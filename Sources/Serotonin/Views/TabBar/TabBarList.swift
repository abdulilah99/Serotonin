//
//  TabBarList.swift
//  Serotonin
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI

struct TabBarList<Page: Navigable>: View {
    var stacks: [NavigableStack<Page>]
    
    init(_ stacks: [NavigableStack<Page>]) {
        self.stacks = stacks
    }
    
    var body: some View {
        VStack(spacing: 7) {
            Divider()
            
            HStack(spacing: 50) {
                ForEach(stacks) { stack in
                    if stack.page.placement.isInTabBar {
                        TabBarButton(page: stack.page)
                            .environment(\.navigationPath, stack.path)
                            .environment(\.setNavigationPath, SetNavigationPathAction(action: { path in
                                stack.path = path as! [Page]
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
