//
//  SidebarView.swift
//  TechBuy
//
//  Created by Aybars Acar on 6/6/2022.
//

import SwiftUI

struct SidebarView<Content: View>: View {
  
  @Binding var show: Bool
  let content: Content
  
  init(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
    self._show = show
    self.content = content()
  }
  
  private let screenWidth = UIScreen.main.bounds.width
  
  @State private var contentXOffsett: CGFloat = .zero
  
  var body: some View {
    ZStack(alignment: .leading) {
      tintedBackground
      
      content
        .frame(width: 2 * (screenWidth / 3))
        .offset(x: show ? 0 + contentXOffsett : -screenWidth)
        .gesture(
          DragGesture()
            .onChanged { value in
              if value.translation.width < 0 {
                contentXOffsett = value.translation.width
              }
            }
            .onEnded { value in
              withAnimation(.easeInOut) {
                if value.translation.width < -60 {
                    show = false
                }
  
                contentXOffsett = .zero
              }
            }
        )
    }
    .frame(maxWidth: .infinity ,maxHeight: .infinity)
  }
}

extension SidebarView {
  
  private var tintedBackground: some View {
    Color.black.opacity(show ? 0.4 : 0)
      .ignoresSafeArea()
      .onTapGesture {
        withAnimation(.easeInOut) {
          show = false
        }
      }
  }
}

struct SidebarView_Previews: PreviewProvider {
  static var previews: some View {
    SidebarView(show: .constant(true)) {
      
    }
  }
}
