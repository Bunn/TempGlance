//
//  MenuContentViewController.swift
//  PiStats
//
//  Created by Fernando Bunn on 05/07/2021.
//

import Cocoa
import Combine
import SwiftUI

final class MenuContentViewController: NSViewController {
    
    override var preferredContentSize: NSSize {
        get {
            NSSize(width: 320, height: 200)

        } set { }
    }
    
    override func loadView() {
        view = StatusBarFlowBackgroundView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        
        let contentView = MenuBarTemperatureView()

//        let hostingController = NSHostingController(rootView: contentView)
//        addChild(hostingController)
//        hostingController.view.autoresizingMask = [.width, .height]
//        hostingController.view.frame = view.bounds
//        view.addSubview(hostingController.view)

  }

   override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidDisappear() {
        super.viewDidLoad()
    }
}
