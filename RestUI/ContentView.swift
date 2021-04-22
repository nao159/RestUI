//
//  ContentView.swift
//  RestUI
//
//  Created by Максим Нуждин on 21.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please enter wake time")) {
                    DatePicker("please enter wake time", selection: $wakeUp, displayedComponents:.hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Amount of sleep for today")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                Section(header: Text("Choose amount of coffee for today")) {
                    Picker("", selection: $coffeeAmount) {
                        ForEach(0..<5) {
                            Text("\($0) coffee cups")
                        }
                    }
                }
                .navigationBarTitle("RestUI")
                .navigationBarItems(leading:
                                        Text(calculateBetTime)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .fontWeight(.black),
                                    
                                    trailing: Button("calculate") {
                                        calculateBetTime
                                    }
                )
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var calculateBetTime: String {
        let model = RestUI()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            return alertMessage
        }
        catch {
            alertMessage = "Sorry, we can calculate bedtime for you"
            return alertMessage
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
