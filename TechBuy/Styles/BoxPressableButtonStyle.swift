//
//  BoxPressableButtonStyle.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import SwiftUI

struct BoxPressableButtonStyle: ButtonStyle {
  
  let scaleAmount: CGFloat
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed ? 1.0 : 1.0)
      .brightness(configuration.isPressed ? 0.05 : 0)
      .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
  }
}

extension ButtonStyle where Self == BoxPressableButtonStyle {
  
  static var withBoxPressableButtonStyle: Self {
    return .init(scaleAmount: 0.95)
  }
  
  static func withBoxPressableButtonStyle(scaleAmount: CGFloat) -> Self {
    return .init(scaleAmount: scaleAmount)
  }
}
