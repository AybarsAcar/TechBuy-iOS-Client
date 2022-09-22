//
//  Snackbar.swift
//  TechBuy
//
//  Created by Aybars Acar on 8/6/2022.
//

import SwiftUI

extension View {
  
  func snackbarAlert<T>(_ message: T, isPresented: Binding<Bool>, type: CustomAlertView.SnackbarType) -> some View where T : StringProtocol {
    self
      .overlay(
        CustomAlertView(isDisplayed: isPresented, message: String(message), type: type)
          .padding()
          .padding(.bottom, 100)
          ,
        alignment: .bottom
      )
  }
}
