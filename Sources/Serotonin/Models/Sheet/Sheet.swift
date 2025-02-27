//
//  File.swift
//  Serotonin
//
//  Created by Abdulilah on 27/02/2025.
//

import Foundation

public protocol Sheet: Navigable {
    var isFullscreen: Bool { get }
    var onDismiss: (() -> Void)? { get set }
}

public extension Sheet {
    var onDismiss: (() -> Void)? { nil }
}
