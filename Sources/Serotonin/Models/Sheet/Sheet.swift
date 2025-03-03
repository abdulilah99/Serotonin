//
//  Sheet.swift
//  Serotonin
//
//  Created by Abdulilah on 27/02/2025.
//

import SwiftUI

public protocol Sheet: Navigable {
    var isFullscreen: Bool { get }
    func onDismiss()
}

public extension Sheet {
    var title: LocalizedStringKey { "Sheet" }
    var systemImage: String { "" }
    var placement: BarPlacement { .none }
    var isFullscreen: Bool { false }
    func onDismiss() { }
}
