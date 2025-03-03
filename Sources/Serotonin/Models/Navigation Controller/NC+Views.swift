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
            CustomNavigationView(stacks: stacks)
        } else {
            OldTabNavigationView(stacks: stacks)
        }
    }
    
    @available(iOS 18.0, macOS 15.0, tvOS 18.0, *)
    var iOS18Compatible: some View {
        TabNavigationView(stacks: stacks)
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
                self.selectedTab = selection as! Page
            }))
    }
    
//    func makeView(for navigable: Page) -> some View {
//        
//    }
}
