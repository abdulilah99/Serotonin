//
//  TabNavigationView.swift
//  Serotonin
//
//  Created by Abdulilah on 28/02/2025.
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
struct TabNavigationView<Page: Navigable>: View {
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
                Tab(stack.page.title, systemImage: stack.page.systemImage, value: stack.page, role: stack.page.role) {
                    ControllerView<Page>()
                        .environment(stack)
                }
                .tabPlacement(.automatic)
                .defaultVisibility(stack.page.placement.sideBarVisibility, for: .sidebar)
                .defaultVisibility(stack.page.placement.tabBarVisibility, for: .tabBar)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .defaultAdaptableTabBarPlacement(.sidebar)
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
