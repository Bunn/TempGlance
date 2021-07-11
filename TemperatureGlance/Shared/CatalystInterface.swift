//
//  CatalystInterface.swift
//  TemperatureGlance
//
//  Created by Fernando Bunn on 10/07/2021.
//

import Foundation

@objc(SensorInfo)
protocol SensorInfo: Any {
    var name: String { get set }
    var temperature: NSNumber { get set }
    var formattedTemperature: String { get }
}

@objc(CatalystInterfaceDatasource)
protocol CatalystInterfaceDatasource: Any {
    func getTemperatures() -> [SensorInfo]
}

@objc(CatalystInterface)
protocol CatalystInterface: NSObjectProtocol {
    init()
    var datasource: CatalystInterfaceDatasource? { get set }
    func setupMenuBar()
}
