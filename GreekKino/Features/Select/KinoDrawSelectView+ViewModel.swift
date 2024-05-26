//
//  KinoDrawSelectView+ViewModel.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

extension KinoDrawSelectView {
    
    class ViewModel: SelectedNumbers {
        
        @Published var selectedNumbers: Set<Int> = []
        @Published var limitReached: Bool = false
        var draw: KinoDraw
        
        init(draw: KinoDraw) {
            self.draw = draw
        }
        
        func update(number: Int) -> Bool {
            var update = false
            if selectedNumbers.contains(number) {
                selectedNumbers.remove(number)
            } else if selectedNumbers.count < 5  {
                selectedNumbers.insert(number)
                update = true
            } else {
                limitReached = true
            }
            return update
        }
    }
}

protocol SelectedNumbers: ObservableObject {
    var selectedNumbers: Set<Int> {get}
    func update(number: Int) -> Bool
}
