//
//  MacPlugin.swift
//  CatalystBridge
//
//  Created by Fernando Bunn on 10/07/2021.
//

import AppKit

class MacPlugin: NSObject, CatalystInterface {
    var datasource: CatalystInterfaceDatasource?
    
  
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    private var windowController: StatusBarMenuWindowController?

    required override init() {
    }

    func displayTemperatures(temperatures: String) {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "Catalyst Test"
        alert.informativeText = temperatures
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func setupMenuBar() {
        if let button = statusItem.button {
            button.title = "🔥"
            button.target = self
            button.action = #selector(MacPlugin.menuBarClicked)
        }
    }
    
    @objc func menuBarClicked() {
        toggleUIVisible(self)
        
    }
    
    @objc func toggleUIVisible(_ sender: Any?) {
        setupMenu()
        return
        if windowController == nil || windowController?.window?.isVisible == false {
            showUI(sender: sender)
        } else {
            hideUI()
        }
    }
    
    @objc func hideUI() {
        windowController?.close()
    }

    func showUI(sender: Any?) {
        
        if windowController == nil {
            windowController = StatusBarMenuWindowController(
                statusItem: statusItem,
                contentViewController: MenuContentViewController()
            )
        }
        
        windowController?.showWindow(sender)
    }
    
    public func setupMenu() {
        let menu = NSMenu()
        
        if let values = datasource?.getTemperatures() {
            var sensor = 1
            for number in values {
                let preferencesItem = NSMenuItem(title: "\(sensor) Sensor  \(number)ºC ", action: nil, keyEquivalent: "")
                sensor += 1
                preferencesItem.target = self
                menu.addItem(preferencesItem)

            }
        }
        
        
        statusItem.menu = menu
                
    }
    
}

