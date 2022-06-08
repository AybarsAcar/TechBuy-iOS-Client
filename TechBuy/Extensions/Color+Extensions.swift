//
//  Color+Extensions.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

extension Color {
  static let theme = AppColorTheme()
  static let googleTheme = GoogleTheme()
}

struct AppColorTheme {
  
  let main = Color("DarkBlue")
  let paleBlue = Color("PaleBlue")
  let paleGreen = Color("PaleGreen")
  let palePink = Color("PalePink")
  let paleYellow = Color("PaleYellow")
  let actionColor = Color("OrangeAction")
  let successColor = Color("SuccessColor")
  let alertColor = Color("AlertColor")
}

struct GoogleTheme {
  let red = Color("GoogleRed")
  let blue = Color("GoogleBlue")
}
