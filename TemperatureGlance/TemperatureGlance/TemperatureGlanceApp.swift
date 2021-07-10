//
//  TemperatureGlanceApp.swift
//  TemperatureGlance
//
//  Created by Fernando Bunn on 10/07/2021.
//

import SwiftUI

@main
struct TemperatureGlanceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .hidden()
        }
    }
}
