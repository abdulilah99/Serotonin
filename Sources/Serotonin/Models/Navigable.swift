//
//  Navigable.swift
//
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI
import Observation

public protocol Navigable: Identifiable, Hashable {
    associatedtype Destination: View
    
    var id: Self.ID { get }
    var title: LocalizedStringKey { get }
    var systemImage: String { get }
    @ViewBuilder var destination: Self.Destination { get }
    
    var placement: BarPlacement { get }
}


public enum BarPlacement: Hashable, Codable {
    case all, side, tab, none
    
    var isInSideBar: Bool {
        switch self {
        case .all:  true
        case .side: true
        case .tab:  false
        case .none: false
        }
    }
    
    var isInTabBar: Bool {
        switch self {
        case .all:  true
        case .side: false
        case .tab:  true
        case .none: false
        }
    }
}
