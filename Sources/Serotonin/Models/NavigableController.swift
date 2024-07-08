//
//  NavigableController.swift
//  
//
//  Created by Abdulilah Imad on 3/12/24.
//

import Foundation

public class NavigableController<Page>: ObservableObject, Identifiable where Page: Navigable {
    let page: Page
    @Published var stack: [Page]
    
    init(page: Page, stack: [Page] = []) {
        self.page = page
        self.stack = stack
    }
}

//@available(iOS 17.0, *) @Observable
//public class NavigableController: Identifiable {
//    let page: any Navigable
//    var stack: [any Navigable]
//
//    init(page: any Navigable, stack: [any Navigable] = []) {
//        self.page = page
//        self.stack = stack
//    }
//}
