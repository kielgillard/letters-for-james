//
//  LetterSelector.swift
//  Letters
//
//  Created by Kiel Gillard on 5/6/21.
//

import Foundation
import Combine

final class LetterSelector: ObservableObject {
    
    @Published private(set) var letter = "James"
    
    private let calculateNextSubject = PassthroughSubject<Void, Never>()
    
    init() {
        let lettersToChooseFrom = "abcdefghijklmnopqrstuvwxyz👻💩🤖🥸🔥".map { String($0) }
        
        // Throttle the selection of a letter in case he's rage clicking the screen.
        //
        // To make this testable, the scheduler should be passed in so a unit test can control
        // the passage of time. However, this would require me making `LetterSelector` generic
        // over a scheduler (intrusive, leaking implementation details) or using a type erased
        // scheduler (making one of my own or using one provided by a
        // third party like https://github.com/pointfreeco/combine-schedulers).
        // Thanks for thinking of testing, Apple!
        calculateNextSubject
            .throttle(for: 3.0, scheduler: DispatchQueue.main, latest: true)
            .combineLatest($letter)
            .map { (_, letter) -> String in
                let remaining = lettersToChooseFrom.filter { $0 != letter }
                let random = remaining.randomElement()!
                return Bool.random() ? random.uppercased() : random
            }
            .assign(to: &$letter)
    }
    
    func next() {
        calculateNextSubject.send(())
    }
}
