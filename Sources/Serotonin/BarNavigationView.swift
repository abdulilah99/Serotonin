//
//  BarNavigationView.swift
//
//
//  Created by Abdulilah Imad on 3/12/24.
//

import SwiftUI

public struct BarNavigationView<Page: Navigable>: View {
    @Namespace var namespace
    
    @Binding var controllers: [NavigableStack<Page>]
    @Binding var selection: Page
    
    public init(controllers: Binding<[NavigableStack<Page>]>, selection: Binding<Page>) {
        self._controllers = controllers
        self._selection = selection
    }
    
    public var body: some View {
        SideBarView(controllers) {
            TabBarView(controllers) {
                ForEach(controllers) { controller in
                    ControllerView<Page>()
                        .environment(controller)
                        .opacity(selection != controller.page ? 0 : 1)
                }
            }
        }
        .environment(\.setNavigationSelection, SetNavigationSelectionAction(action: { selection in
            self.selection = selection as! Page
        }))
        .environment(\.navigationSelection, selection)
        .environment(\.serotoninNamespace, namespace)
    }
}

struct ControllerView<Page: Navigable>: View {
    @Environment(NavigableStack<Page>.self) var controller
    
    var body: some View {
        @Bindable var controller = controller
        NavigationStack(path: $controller.path) {
            controller.page.destination
                .toolbar { SideBarToggleButton(isInSideBar: false) }
                .navigationDestination(for: Page.self) { navigable in
                    navigable.destination.environment(controller)
                }
        }
    }
}

