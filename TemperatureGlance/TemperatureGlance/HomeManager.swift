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
        test()
    }
    
    private func test() {
        print("test \(manager.homes)")
        manager.delegate = self
    }
    
    private func updateData() {
        let accessories = manager.homes.flatMap{ $0.accessories }
        accessories.forEach { $0.delegate = self }
        accessories.forEach {
            print($0.name)
            
            
        }
        let a: [SensorInfo] = accessories.compactMap {
            let name = $0.name
            if let characteristic = $0.find(serviceType: HMServiceTypeTemperatureSensor, characteristicType: HMCharacteristicMetadataFormatFloat),
               let value = characteristic.value as? NSNumber {
                return Sensor(name: $0.room?.name ?? name, temperature: value)
                
            }
            return nil
        }
        
        let characteristicSensors = accessories.compactMap{ $0.find(serviceType: HMServiceTypeTemperatureSensor, characteristicType: HMCharacteristicMetadataFormatFloat) }
        
        
        characteristicSensors.forEach { $0.enableNotification(true) { _ in
           // print("Notification error \(String(describing: error))")
        }}
        
        let numbers = characteristicSensors.compactMap{ $0.value as? NSNumber }
        delegate?.homeManager(homeManager: self, didReceive: a)
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
