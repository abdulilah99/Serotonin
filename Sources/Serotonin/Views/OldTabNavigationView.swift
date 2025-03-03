//
//  OldTabNavigationView.swift
//  Serotonin
//
//  Created by Abdulilah on 03/03/2025.
//

import SwiftUI

struct OldTabNavigationView<Page: Navigable>: View {
    @Environment(\.navigationSelection) var navigationSelection
    @Environment(\.setNavigationSelection) var setNavigationSelection
    
    @Namespace var namespace
    
    var stacks: [NavigableStack<Page>]
    
    public init(stacks: [NavigableStack<Page>]) {
        self.stacks = stacks
    }
    
    var selection: Binding<Page?> {
        Binding(get: { navigationSelection as? Page }) { newValue in
            if let newValue {
                setNavigationSelection.callAsFunction(selection: newValue)
            }
        }
    }
    
    public var body: some View {
        TabView(selection: selection) {
            ForEach(stacks) { stack in
                ControllerView<Page>()
                    .environment(stack)
                    .tag(stack.page)
                    .tabItem {
                        Label(stack.page.title, systemImage: stack.page.systemImage)
                    }
            }
        }
        .environment(\.serotoninNamespace, namespace)
    }
}

fileprivate struct ControllerView<Page: Navigable>: View {
    @Environment(NavigableStack<Page>.self) var stack
    
    var body: some View {
        @Bindable var stack = stack
        NavigationStack(path: $stack.path) {
            stack.page.destination
                .navigationDestination(for: Page.self) { navigable in
                    navigable.destination
                        .environment(stack)
                }
        }
    }
}
