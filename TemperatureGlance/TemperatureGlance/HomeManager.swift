//
//  HomeManager.swift
//  TempGlance
//
//  Created by Fernando Bunn on 07/07/2021.
//

import Foundation
import HomeKit

protocol HomeManagerDelegate: AnyObject {
    func homeManager(homeManager: HomeManager, didReceive temperatures: [NSNumber])
}

class HomeManager: NSObject {
    weak var delegate: HomeManagerDelegate?
    let manager = HMHomeManager()
    
    override init() {
        super.init()
        test()
    }
    
    private func test() {
        print("test \(manager.homes)")
        manager.delegate = self
    }
    
}


extension HomeManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        var temperatures = [NSNumber]()
        
        if let bat = manager.homes.first {
            for accessory in bat.accessories {
                guard let characteristic = accessory.find(serviceType: HMServiceTypeTemperatureSensor, characteristicType: HMCharacteristicMetadataFormatFloat) else {
                    continue
                }
                
          
                if let value = characteristic.value as? NSNumber {
                    temperatures.append(value)
                }
                print("MY TEMPS \(characteristic.value)!! \(characteristic.properties)")
                
            }
        }
        delegate?.homeManager(homeManager: self, didReceive: temperatures)
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

