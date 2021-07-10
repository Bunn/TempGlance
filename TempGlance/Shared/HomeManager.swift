//
//  HomeManager.swift
//  TempGlance
//
//  Created by Fernando Bunn on 07/07/2021.
//

import Foundation
import HomeKit

class HomeManager: NSObject {
    let manager = HMHomeManager()
    let accessoryBrowser = HMAccessoryBrowser()
    
    override init() {
        super.init()
        test()
    }
    
    private func test() {
        print("test \(manager.homes)")
        manager.delegate = self
    }
    
    private func searchAccessories() {
        var discoveredAccessories: [HMAccessory] = []
        accessoryBrowser.delegate = self
        accessoryBrowser.startSearchingForNewAccessories()
        
    }
}

extension HomeManager: HMAccessoryBrowserDelegate {
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        print("ACESSOR \(accessory)")
        
        guard let characteristic = accessory.find(serviceType: HMServiceTypeLightbulb, characteristicType: HMCharacteristicMetadataFormatBool) else {
            return
        }
        
        print("A \(characteristic)")
    }
}

extension HomeManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        if let bat = manager.homes.first {
            for accessory in bat.accessories {
                guard let characteristic = accessory.find(serviceType: HMServiceTypeTemperatureSensor, characteristicType: HMCharacteristicMetadataFormatFloat) else {
                    continue
                }
                print("MY TEMPS \(characteristic.value)!! \(characteristic.properties)")
                
            }
        }
        searchAccessories()
    }
}
extension HMAccessory {
    func find(serviceType: String, characteristicType: String) -> HMCharacteristic? {
        return services.lazy
            .filter { $0.serviceType == serviceType }
            .flatMap { $0.characteristics }
            .first { $0.metadata?.format == characteristicType }
    }
}

