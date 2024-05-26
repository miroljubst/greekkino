//
//  Helper.swift
//  GreekKino
//
//  Created by Miroljub Stoilkovic on 26.5.24..
//

import SwiftUI

class Helpers {
    static func colorFor(number: Int) -> Color {
        switch number {
        case 1...10:
            return .yellow
        case 11...20:
            return .red
        case 21...30:
            return .orange
        case 31...40:
            return .blue
        case 41...50:
            return .teal
        case 51...60:
            return .green
        case 61...70:
            return .purple
        case 71...80:
            return .pink
        default:
            return Color.gray
        }
    }
}
