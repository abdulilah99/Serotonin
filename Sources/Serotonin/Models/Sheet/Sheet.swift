//
//  Sheet.swift
//  Serotonin
//
//  Created by Abdulilah on 27/02/2025.
//

import Foundation

public protocol Sheet: Navigable {
    var isFullscreen: Bool { get }
    func onDismiss()
}

public extension Sheet {
    var isFullscreen: Bool { false }
    func onDismiss() { }
}
