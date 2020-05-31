//
//  AboutView.swift
//  bullseye swift UI
//
//  Created by Buck Rozelle on 5/31/20.
//  Copyright © 2020 Buck Rozelle. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
Text("🎯 Bullseye 🎯")
Text("This is Bullseye, the game where you can win point and earn fame by dragging a slider.")
Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
Text("Enjoy!")
}
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

}
