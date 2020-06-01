//
//  ContentView.swift
//  bullseye swift UI
//
//  Created by Buck Rozelle on 5/29/20.
//  Copyright © 2020 Buck Rozelle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK:- Properties
    //==========
    
    //Game stats
    @State var score = 0
    @State var round = 1
    
    //Colors
    let midnightBlue = Color(red: 0,
                             green: 0.2,
                             blue: 0.4)
    
    //User interface views
    @State var alertIsVisible: Bool = false
    @State var  sliderValue = Double.random(in: 1...100)
    @State var target = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(sliderValue.rounded())
    }
    var sliderTargetDifference: Int {
        abs(sliderValueRounded - target)
    }
    
    //MARK:- User interface content and layout
    var body: some View {
    NavigationView {
            VStack {
                Spacer().navigationBarTitle("🎯 Bullseye 🎯")
                
            //MARK:- Target row
                HStack {
                    Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                }
                Spacer()
            
            //MARK:- Slider row
                HStack {
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100)
                        .accentColor(Color.green)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                
            //MARK:- Button Row
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
            Text("Hit me!")
         .font(Font.custom("Arial Rounded MT Bold", size: 18))
.foregroundColor(Color.black)
}
.background(Image("Button")
.modifier(Shadow())
)  .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Awesome!")) {
                        self.startNewRound()
                })
                }
                Spacer()
            //MARK:- Score Row
               HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    HStack {
                    Image("StartOverIcon")
                    Text("Start over").modifier(ButtonSmallTextStyle())
                }
                }
                .background(Image("Button")
                .modifier(Shadow())
                )
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                    Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle() )
                    }
                }
                .background(Image("Button")
.modifier(Shadow())
)
                }
               .padding(.bottom, 20)
               .padding(.leading, 20)
               .padding(.trailing, 40)
            .accentColor(midnightBlue)
            }
            .background(Image("Background"))
        }
         .navigationViewStyle(StackNavigationViewStyle())
    }
        //Methods
        //=======
    func alertTitle() -> String {
        let title: String
            if sliderTargetDifference == 0 {
                title = "Perfect!"
            } else if sliderTargetDifference < 5 {
                title = "You almost had it!"
            } else if sliderTargetDifference <= 10 {
                title = "Not bad."
            } else {
                title = "Are you even trying?"
            }
        return title
    }
    func scoringMessage() -> String {
        return "The slider's value is \(sliderValueRounded).\n" + "The target value is \(target).\n" + "You scored \(pointsForCurrentRound()) points this round."
    }
    
    
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
            resetSliderAndTarget()
        }
        
        func startNewGame() {
            score = 0
            round = 1
            resetSliderAndTarget()
        }
    
    func resetSliderAndTarget() {
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
    
    //MARK: - View modifiers
    //==============
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.white)
                .modifier(Shadow())
            
        }
    }
    
    struct ValueStyle: ViewModifier {
func body(content: Content) -> some View {
content
.font(Font.custom("Arial Rounded MT Bold", size: 24))
.foregroundColor(Color.yellow)
.modifier(Shadow())
}
}
    
    struct Shadow: ViewModifier {
func body(content: Content) -> some View {
content
.shadow(color: Color.black, radius: 5, x: 2, y: 2)
}
}
    
    struct ButtonLargeTextStyle: ViewModifier {
func body(content: Content) -> some View {
content
.font(Font.custom("Arial Rounded MT Bold", size: 18))
.foregroundColor(Color.black)
}
}
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(Font.custom ("Arial Rounded MT Bold", size: 12))
                .foregroundColor(Color.black)
        }
    }

    //MARK:- Preview
    //=======

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
        }
      }
}
