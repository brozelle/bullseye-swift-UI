//
//  ContentView.swift
//  bullseye swift UI
//
//  Created by Buck Rozelle on 5/29/20.
//  Copyright © 2020 Buck Rozelle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //Properties
    //==========
    
    //Game stats
    @State var score = 0
    @State var round = 1
    
    //User interface views
    @State var alertIsVisible: Bool = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    //User interface content and layout
    var body: some View {
    NavigationView {
            VStack {
                Spacer()
                
            //Target row
                HStack {
                    Text("Put the Bull's Eye as close as you can to:")
                    Text("\(target)")
                }
                Spacer()
            
            //Slider row
                HStack {
                    Text("1")
                    Slider(value: $sliderValue, in: 1...100)
                    Text("100")
                }
                Spacer()
                
            //Button Row
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
            Text("Hit me!")
        }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there!"),
                      message: Text("The slider's value is \(sliderValueRounded).\n" + "You earned \(pointsForCurrentRound()) points."),
                      dismissButton: .default(Text("Awesome!")) {
                        self.startNewRound()
                })
                }
                Spacer()
            //Score Row
               HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                NavigationLink(destination: AboutView()) {
                    Text("Info")
                    }
                }
               .padding(.bottom, 20)
            }
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
        //Methods
        //=======
        
        func pointsForCurrentRound() -> Int {
            let points: Int
            if sliderTargetDifference == 0 {
                points = 200
            } else if sliderTargetDifference == 1 {
                points = 150
            } else {
                points = 100 - sliderTargetDifference
        }
        return points
    }
        
        func startNewRound() {
            score += pointsForCurrentRound()
            round += 1
            target = Int.random(in: 1...100)
        }
        
        func startNewGame() {
            score = 0
            round = 1
            target = Int.random(in: 1...100)
        }

    //Preview
    //=======

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
      }
}
