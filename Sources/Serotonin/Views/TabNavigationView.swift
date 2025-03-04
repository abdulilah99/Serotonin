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
    
    var tabs: [AppTab<Page>]
    
    public init(tabs: [AppTab<Page>]) {
        self.tabs = tabs
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
            ForEach(tabs) { tab in
                SwiftUI.Tab(tab.page.title, systemImage: tab.page.systemImage, value: tab.page, role: tab.page.role) {
                    ControllerView<Page>()
                        .environment(tab)
                }
                .tabPlacement(.automatic)
                .defaultVisibility(tab.page.placement.sideBarVisibility, for: .sidebar)
                .defaultVisibility(tab.page.placement.tabBarVisibility, for: .tabBar)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .defaultAdaptableTabBarPlacement(.sidebar)
        .environment(\.serotoninNamespace, namespace)
    }
}

fileprivate struct ControllerView<Page: Navigable>: View {
    @Environment(AppTab<Page>.self) var tab
    
    var body: some View {
        @Bindable var tab = tab
        NavigationStack(path: $tab.path) {
            tab.page.destination
                .navigationDestination(for: Page.self) { navigable in
                    navigable.destination
                        .environment(tab)
                }
        }
    }
}
