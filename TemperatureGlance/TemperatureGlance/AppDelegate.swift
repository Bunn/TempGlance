//
//  AppDelegate.swift
//  TempGlance
//
//  Created by Fernando Bunn on 10/07/2021.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    let home = HomeManager()
    var sensors = [SensorInfo]()
 
    private lazy var catalystInterface: CatalystInterface? = {
        let bundleFile = "CatalystBridge.bundle"
        guard let bundleURL = Bundle.main.builtInPlugInsURL?.appendingPathComponent(bundleFile),
              let bundle = Bundle(url: bundleURL),
              let pluginClass = bundle.principalClass as? CatalystInterface.Type else { return nil }
        let plugin = pluginClass.init()
        plugin.datasource = self
        return plugin
    }()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        catalystInterface?.setupMenuBar()
        home.delegate = self
        return true
    }
}


extension AppDelegate: CatalystInterfaceDatasource {
    func getTemperatures() -> [SensorInfo] {
        return sensors
    }
}

extension AppDelegate: HomeManagerDelegate {
    func homeManager(homeManager: HomeManager, didReceive sensors: [SensorInfo]) {
        self.sensors = sensors
        catalystInterface?.setupMenuBar()
    }

}

