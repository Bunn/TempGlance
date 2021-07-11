//
//  HomeManager.swift
//  TempGlance
//
//  Created by Fernando Bunn on 07/07/2021.
//

import Foundation
import HomeKit

protocol HomeManagerDelegate: AnyObject {
    func homeManager(homeManager: HomeManager, didReceive sensors: [SensorInfo])
}

class HomeManager: NSObject {
    weak var delegate: HomeManagerDelegate?
    let manager = HMHomeManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    private func updateData() {
        let accessories = manager.homes.flatMap{ $0.accessories }
        accessories.forEach { $0.delegate = self }
        
        let sensors: [SensorInfo] = accessories.compactMap { accessory in
            if let characteristic = accessory.find(serviceType: HMServiceTypeTemperatureSensor,
                                            characteristicType: HMCharacteristicMetadataFormatFloat),
               let value = characteristic.value as? NSNumber {
                characteristic.enableNotification(true) { _ in }
                return Sensor(name: accessory.room?.name ?? accessory.name, temperature: value)
            }
            return nil
        }

        delegate?.homeManager(homeManager: self, didReceive: sensors)
    }
}


extension HomeManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        updateData()
    }
}

extension HomeManager: HMAccessoryDelegate {
    func accessory(_ accessory: HMAccessory, service: HMService, didUpdateValueFor characteristic: HMCharacteristic) {
        updateData()
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
