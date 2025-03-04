//
//  AppTab.swift
//  Serotonin
//
//  Created by Abdulilah Imad on 3/12/24.
//

import Foundation
import Observation

@Observable
public class AppTab<Page: Navigable>: Identifiable {
    let page: Page
    var path: [Page]
    
    public init(page: Page, path: [Page]) {
        self.page = page
        self.path = path
    }
    
//    public init(page: Page, path: [Page] = []) where Page == Path {
//        self.page = page
//        self.path = path
//    }
}
