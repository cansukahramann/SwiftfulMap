//
//  SwiftfulMapApp.swift
//  SwiftfulMap
//
//  Created by Cansu Kahraman on 9.11.2022.
//

import SwiftUI

@main
struct SwiftfulMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
