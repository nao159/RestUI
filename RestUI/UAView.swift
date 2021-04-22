//
//  ContentView.swift
//  RestUI
//
//  Created by Максим Нуждин on 21.04.2021.
//

import SwiftUI

struct UAView: View {
    
    @State private var showingYellowText = true
    @State private var showingBlueText = true
    @State private var coloredLabel = "Укра"
    @State private var alternativeColoredLabel = "ина"
    
    var body: some View {
        Button(action: {
            showingYellowText.toggle()
            showingBlueText.toggle()
        }, label: {
            HStack(spacing: 0) {
                ZStack {
                    if showingYellowText{
                        Color.yellow
                    } else {
                        Color.blue
                    }
                    Text(coloredLabel)
                        .foregroundColor(showingBlueText ? Color.blue : Color.yellow)
                }
                ZStack{
                    if showingBlueText {
                    Color.blue
                    } else {
                        Color.yellow
                    }
                    Text(alternativeColoredLabel)
                        .foregroundColor(showingYellowText ? Color.yellow : Color.blue)
                }
            }.font(.largeTitle)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        })
    }
}

struct UAView_Previews: PreviewProvider {
    static var previews: some View {
        UAView()
    }
}
