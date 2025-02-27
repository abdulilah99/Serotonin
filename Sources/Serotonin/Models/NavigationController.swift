//
//  NavigationController.swift
//  Serotonin
//
//  Created by Abdulilah on 26/02/2025.
//

import SwiftUI

public protocol NavigationController: AnyObject, Observable {
    associatedtype Page: Navigable
    associatedtype Card: Sheet
    associatedtype Content: View
    
    var selectedTab: Page { get set }
    func select(tab: Page)
    
    var stacks: [NavigableStack<Page>] { get set }
    func navigate(to page: Page, on tab: Page?)
    
    var sheets: [Card] { get set }
    func present(sheet: Card)
    
    @ViewBuilder func makeView() -> Content
}

public extension NavigationController {
    func select(tab: Page) {
        selectedTab = tab
    }
    
    func navigate(to page: Page, on tab: Page? = nil) {
        let targetTab = tab ?? selectedTab
        
        if let existingStack = stacks.first(where: { $0.page == targetTab }) {
            if let index = existingStack.path.firstIndex(of: page) {
                let removalIndex = index + 1
                existingStack.path.removeSubrange(removalIndex..<existingStack.path.count)
            } else {
                existingStack.path.append(page)
            }
        } else {
            stacks.append(NavigableStack(page: targetTab, path: [page]))
        }
        
        selectedTab = targetTab
    }
    
    func present(sheet: Card) {
        if let index = sheets.firstIndex(of: sheet) {
            let removalIndex = index + 1
            sheets.removeSubrange(removalIndex..<sheets.count)
        } else {
            sheets.append(sheet)
        }
    }
    
    func makeView() -> some View {
        BarNavigationView<Page>(stacks: stacks)
            .environment(\.navigationSelection, selectedTab)
            .environment(\.setNavigationSelection, SetNavigationSelectionAction(action: { selection in
                self.selectedTab = selection as! Page
            }))
    }
}
