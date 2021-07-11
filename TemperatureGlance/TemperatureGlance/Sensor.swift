//
//  Sensor.swift
//  TemperatureGlance
//
//  Created by Fernando Bunn on 10/07/2021.
//

import Foundation

class Sensor: SensorInfo {
    var name: String
    var temperature: NSNumber
    var formattedTemperature: String {
        let formatter = MeasurementFormatter()
        let temp = Measurement(value: Double(truncating: temperature), unit: UnitTemperature.celsius)
        return formatter.string(from: temp)
    }

    internal init(name: String, temperature: NSNumber) {
        self.name = name
        self.temperature = temperature
    }
    
    var debugDescription: String {
        return "\(name) \(temperature)"
    }
}
