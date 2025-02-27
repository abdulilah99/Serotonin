//
//  TabBarView.swift
//
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI

struct TabBarView<Content: View, Page: Navigable>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var controllers: [NavigableStack<Page>]
    var content: Content
    
    init(_ controllers: [NavigableStack<Page>], @ViewBuilder content: () -> Content) {
        self.controllers = controllers
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            
            TabBarList(controllers)
                .ignoresSafeArea(.keyboard)
                .opacity(horizontalSizeClass != .compact ? 0 : 1)
        }
    }
}
