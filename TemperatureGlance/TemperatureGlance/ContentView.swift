 //
 //  ContentView.swift
 //  TemperatureGlance
 //
 //  Created by Fernando Bunn on 10/07/2021.
 //
 
 import SwiftUI
 
 struct ContentView: View {
    var body: some View {
        VStack {
            Text("Please close this window 🙂")
                .font(.title)
            Text("I don't know how to do it automatically yet...🥺")
                .font(.caption)
        }
        .padding()
    }
 }
 
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
