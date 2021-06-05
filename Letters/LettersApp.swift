//
//  LettersApp.swift
//  Letters
//
//  Created by Kiel Gillard on 5/6/21.
//

import SwiftUI

@main
struct LettersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(letterSelector: LetterSelector())
        }
    }
}
