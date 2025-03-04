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
                ControllerView<Page>()
                    .environment(tab)
                    .tag(tab.page)
                    .tabItem {
                        Label(tab.page.title, systemImage: tab.page.systemImage)
                    }
            }
        }
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
