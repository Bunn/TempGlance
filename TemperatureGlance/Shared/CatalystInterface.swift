//
//  CatalystInterface.swift
//  TemperatureGlance
//
//  Created by Fernando Bunn on 10/07/2021.
//
import Foundation

@objc(CatalystInterfaceDatasource)
protocol CatalystInterfaceDatasource: Any {
    func getTemperatures() -> [NSNumber]
}

@objc(CatalystInterface)
protocol CatalystInterface: NSObjectProtocol {
    init()
    var datasource: CatalystInterfaceDatasource? { get set }
    func displayTemperatures(temperatures: String)
    func setupMenuBar()
}
