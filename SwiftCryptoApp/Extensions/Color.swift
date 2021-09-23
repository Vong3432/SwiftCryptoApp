//
//  Color.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 17/09/2021.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
    let gray = Color("GrayColor")
}
