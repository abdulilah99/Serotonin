//
//  NC+Views.swift
//  Serotonin
//
//  Created by Abdulilah on 03/03/2025.
//

import SwiftUI

extension NavigationController {
    private var sheetsBinding: Binding<[Card]> {
        Binding(get: {
            self.sheets
        }) { newValue in
            self.sheets = newValue
        }
    }
    
    var useCustomNavigationBar: Bool { false }
    
    @ViewBuilder
    var iOS17Compatible: some View {
        if useCustomNavigationBar {
            CustomNavigationView(tabs: tabs)
        } else {
            OldTabNavigationView(tabs: tabs)
        }
    }
    
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    var iOS18Compatible: some View {
        TabNavigationView(tabs: tabs)
    }
    
    @ViewBuilder
    var view: some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, *) {
            iOS18Compatible
        } else {
            iOS17Compatible
        }
    }
    
    func makeView() -> some View {
        view
            .sheets(items: sheetsBinding)
            .environment(\.navigationSelection, selectedTab)
            .environment(\.setNavigationSelection, SetNavigationSelectionAction(action: { selection in
                self.selectedTab = selection as! Tab
            }))
    }
    
    func makeView(for tab: AppTab<Tab>) -> some View {
        ControllerView<Tab>().environment(tab)
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
