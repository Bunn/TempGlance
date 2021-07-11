//
//  MacPlugin.swift
//  CatalystBridge
//
//  Created by Fernando Bunn on 10/07/2021.
//

import AppKit

class MacPlugin: NSObject, CatalystInterface {
    var datasource: CatalystInterfaceDatasource?
    private let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    required override init() { }
    
    func setupMenuBar() {
        if let button = statusItem.button {
            
            let image = NSImage(named: .init("thermometer"))
            image?.isTemplate = true
            let size = 17
            image?.size = NSSize(width: size, height: size)
            button.image = image
            button.target = self
        }
        setupMenu()
    }
    
    
    func setupMenu() {
        let menu = NSMenu()
        
        if let values = datasource?.getTemperatures() {
            for sensor in values {
                let preferencesItem = NSMenuItem(title: "\(sensor.name) \(sensor.formattedTemperature)", action: nil, keyEquivalent: "")
                menu.addItem(preferencesItem)
            }
        }
        
        menu.addItem(NSMenuItem.separator())
        
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(MacPlugin.quit), keyEquivalent: "")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        statusItem.menu = menu
    }
    
    @objc private func quit() {
        exit(0)

        /*
         NSApplication.shared.terminate(self)
         Causes this issue.
         
         [Lifecycle] Watchdog: App took too long to enter the background-only state. Exiting immediately! (5.0s)
         [Lifecycle] Watchdog timeout. Exiting immediately. (App took too long to enter the background-only state.)
         [Assert] App took too long to enter the background-only state.
         */
    }
}

