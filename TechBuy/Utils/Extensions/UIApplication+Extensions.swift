//
//  UIApplication+Extensions.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import SwiftUI

extension UIApplication {
  
  /// extension function to dismiss the keyboard
  /// ```
  /// UIApplication.shared.endEditing()
  /// ```
  func endEditing() {
    
    // send an obj-c function to dissmiss the keyboard
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
}
