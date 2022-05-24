//
//  CustomCurveShape.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

/// Tab Curve Shape
struct CustomCurveShape: Shape {
  
  func path(in rect: CGRect) -> Path {
    return Path { path in
      
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: rect.width, y: 0))
      path.addLine(to: CGPoint(x: rect.width, y: rect.height))
      path.addLine(to: CGPoint(x: 0, y: rect.height))
      
      
      // center curve
      let mid = rect.width / 2
      
      path.move(to: CGPoint(x: mid - 70, y: 0))
      
      let to1 = CGPoint(x: mid, y: 45)
      let control1 = CGPoint(x: mid - 40, y: 0)
      let control2 = CGPoint(x: mid - 40, y: 45)
      
      path.addCurve(to: to1, control1: control1, control2: control2)
      
      let to2 = CGPoint(x: mid + 70, y: 0)
      let control3 = CGPoint(x: mid + 40, y: 45)
      let control4 = CGPoint(x: mid + 40, y: 0)
      
      path.addCurve(to: to2, control1: control3, control2: control4)
    }
  }
}

extension View {
  func withCurvedBackground(color: Color = .white) -> some View {
    self
      .background(
        color
          .clipShape(CustomCurveShape())
          .shadow(color: .black.opacity(0.04), radius: 5, x: -5, y: -5)
          .ignoresSafeArea(.container, edges: .bottom)
      )
  }
}
