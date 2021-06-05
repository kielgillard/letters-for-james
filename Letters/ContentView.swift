//
//  ContentView.swift
//  Letters
//
//  Created by Kiel Gillard on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var letterSelector: LetterSelector
    
    var body: some View {
        VStack {
            Text(letterSelector.letter)
                .font(.system(size: 96))
                .padding()
            
            Button("Next") {
                letterSelector.next()
            }
        }
        .onTapGesture {
            letterSelector.next()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(letterSelector: LetterSelector())
    }
}
