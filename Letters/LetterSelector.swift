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
