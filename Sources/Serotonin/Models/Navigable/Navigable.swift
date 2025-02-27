//
//  Navigable.swift
//  Serotonin
//
//  Created by Abdulilah Imad on 2/24/24.
//

import SwiftUI

public protocol Navigable: Identifiable, Hashable, Equatable {
    associatedtype Destination: View
    
    var id: Self.ID { get }
    var title: LocalizedStringKey { get }
    var systemImage: String { get }
    @ViewBuilder var destination: Destination { get }
    
    var placement: BarPlacement { get }
}

public enum BarPlacement: Hashable, Codable {
    case all, side, tab, none
    
    var isInSideBar: Bool { [.all, .side].contains(self) }
    
    var isInTabBar: Bool { [.all, .tab].contains(self) }
}
