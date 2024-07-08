//
//  BarNavigationView.swift
//
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

public struct BarNavigationView<Page: Navigable>: View {
    @Binding var controllers: [NavigableController<Page>]
    @Binding var selection: Page
    
    public var body: some View {
        SideBarView(controllers) {
            TabBarView(controllers) {
                ForEach(controllers) { controller in
                    ControllerView<Page>()
                        .environmentObject(controller)
                        .opacity(selection != controller.page ? 0 : 1)
                }
            }
            .environment(\.setNavigationSelection, SetNavigationSelectionAction(action: { selection in
                self.selection = selection as! Page
            }))
            .environment(\.navigationSelection, selection)
            
        }
    }
}

struct ControllerView<Page: Navigable>: View {
    @EnvironmentObject var controller: NavigableController<Page>
    
    var body: some View {
        NavigationStack(path: $controller.stack) {
            controller.page.destination
                .navigationDestination(for: Page.self) { navigable in
                    navigable.destination.environmentObject(controller)
                }
        }
    }
}

