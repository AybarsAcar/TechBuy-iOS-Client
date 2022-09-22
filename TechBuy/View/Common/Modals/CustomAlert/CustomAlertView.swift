//
//  CustomAlertView.swift
//  TechBuy
//
//  Created by Aybars Acar on 8/6/2022.
//

import SwiftUI

struct CustomAlertView: View {
  
  @Binding var isDisplayed: Bool
  let message: String?
  let type: SnackbarType
  
  @State private var animate: Bool = false
  
  var body: some View {
    
    if isDisplayed {
      HStack {
        Image(systemName: getSystemImageName())
          .font(.title2)
        
        Spacer(minLength: 4)
        
        if let message = message {
          Text(message)
            .multilineTextAlignment(.leading)
            .font(.headline)
        }
        
        Spacer(minLength: 4)
        
        Image(systemName: "xmark")
      }
      .padding()
      .foregroundColor(.white)
      .frame(maxWidth: .infinity)
      .background(getBackgroundColor())
      .cornerRadius(10)
      .onTapGesture {
        withAnimation(.linear(duration: 0.2)) {
          isDisplayed = false
        }
      }
      .transition(.move(edge: .bottom))
    }
  }
}

extension CustomAlertView {
  
  enum SnackbarType {
    case success, warning, error
  }
  
  private func getBackgroundColor() -> Color {
    switch type {
    case .error:
      return .theme.alertColor
    case .success:
      return .theme.successColor
    case .warning:
      return .yellow
    }
  }
  
  private func getSystemImageName() -> String {
    switch type {
    case .error:
      return "exclamationmark.triangle.fill"
    case .success:
      return "checkmark.seal"
    case .warning:
      return "exclamationmark.triangle"
    }
  }
}



struct CustomAlertView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CustomAlertView(isDisplayed: .constant(true), message: "Invalid Credentials", type: .error)
      CustomAlertView(isDisplayed: .constant(true), message: "Please update your credentials", type: .warning)
      CustomAlertView(isDisplayed: .constant(true), message: "Successfully Logged In", type: .success)
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
