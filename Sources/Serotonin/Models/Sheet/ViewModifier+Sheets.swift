//
//  File.swift
//  Serotonin
//
//  Created by Abdulilah on 27/02/2025.
//

import SwiftUI

private struct SheetsPresenter<S: Sheet>: ViewModifier {
    @Binding var items: [S]
    
    var item: Binding<S?> {
        Binding(get: {
            return items.last
        }) { newValue in
            if newValue == nil {
                items.removeLast()
            }
        }
    }
    
    func body(content: Content) -> some View {
        if item.wrappedValue?.isFullscreen ?? false {
            content
                .fullScreenCover(item: item, onDismiss: item.wrappedValue?.onDismiss) { item in
                    item.destination
                }
        } else {
            content
                .sheet(item: item, onDismiss: item.wrappedValue?.onDismiss) { item in
                    item.destination
                }
        }
    }
}

public extension View {
    func sheets<S: Sheet>(items: Binding<[S]>) -> some View {
        modifier(SheetsPresenter(items: items))
    }
}

//private struct SheetsPresenter<S: Sheet>: ViewModifier {
//    @Binding var items: [S]
//    var currentIndex: Int = 0
//    
//    var item: Binding<S?> {
//        Binding(get: {
//            if currentIndex < items.count {
//                return items[currentIndex]
//            }
//            
//            return nil
//        }) { newValue in
//            if newValue == nil {
//                items.remove(at: currentIndex)
//            }
//        }
//    }
//    
//    func body(content: Content) -> some View {
//        content
//            .sheet(item: item, onDismiss: item.wrappedValue?.onDismiss) { item in
//                item.destination
//                    .sheetsPresenter(items: $items, currentIndex: currentIndex + 1)
//            }
//    }
//}
//
//extension View {
//    func sheetsPresenter<S: Sheet>(items: Binding<[S]>, currentIndex: Int) -> some View {
//        modifier(SheetsPresenter(items: items, currentIndex: currentIndex))
//    }
//}
