//
//  BarNavigationView.swift
//
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

struct BarNavigationView<Page: Navigable>: View {
    @Environment(\.navigationSelection) var selection
    
    @Namespace var namespace
    
    var stacks: [NavigableStack<Page>]
    
    public init(stacks: [NavigableStack<Page>]) {
        self.stacks = stacks
    }
    
    public var body: some View {
        SideBarView(stacks) {
            TabBarView(stacks) {
                ForEach(stacks) { stack in
                    ControllerView<Page>()
                        .environment(stack)
                        .opacity(selection?.hashValue != stack.page.hashValue ? 0 : 1)
                }
            }
        }
        .environment(\.serotoninNamespace, namespace)
    }
}

struct ControllerView<Page: Navigable>: View {
    @Environment(NavigableStack<Page>.self) var stack
    
    var body: some View {
        @Bindable var stack = stack
        NavigationStack(path: $stack.path) {
            stack.page.destination
                .toolbar { SideBarToggleButton(isInSideBar: false) }
                .navigationDestination(for: Page.self) { navigable in
                    navigable.destination
                        .environment(stack)
                }
        }
    }
}

