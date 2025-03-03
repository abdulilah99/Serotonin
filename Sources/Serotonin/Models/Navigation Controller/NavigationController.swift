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
    
    var useCustomNavigationView: Bool { get }
    
    @ViewBuilder func makeView() -> Content
}
