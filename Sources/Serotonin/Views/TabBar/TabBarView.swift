//
//  TabBarView.swift
//
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI

struct TabBarView<Content: View, Page: Navigable>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var stacks: [NavigableStack<Page>]
    var content: Content
    
    init(_ stacks: [NavigableStack<Page>], @ViewBuilder content: () -> Content) {
        self.stacks = stacks
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            
            TabBarList(stacks)
                .ignoresSafeArea(.keyboard)
                .opacity(horizontalSizeClass != .compact ? 0 : 1)
        }
    }
}
