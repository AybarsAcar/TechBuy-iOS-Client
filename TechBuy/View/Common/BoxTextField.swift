//
//  BoxTextField.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import SwiftUI

struct BoxTextField: View {
  
  enum FieldType {
    case plain, secure
  }
  
  @Binding var text: String
  @FocusState var isFocused: Bool
  
  let placeholder: String
  let color: Color
  let type: FieldType
  
  init(_ placeholder: String, text: Binding<String>, color: Color = .white, type: FieldType = .plain) {
    self._text = text
    self.placeholder = placeholder
    self.color = color
    self.type = type
  }
  
  @State private var secure: Bool = true
  
  
  var body: some View {
    switch type {
    case .plain:
      plainTextField
    case .secure:
      secureTextField
    }
  }
}

// MARK: - Components
extension BoxTextField {
  private var plainTextField: some View {
    HStack {
      TextField(placeholder, text: $text)
        .textInputAutocapitalization(.never)
        .focused($isFocused)
        .padding()
    }
    .frame(height: 55)
    .frame(maxWidth: .infinity)
    .background(color)
    .cornerRadius(8)
    .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 2)
  }
  
  private var secureTextField: some View {
    HStack {
      if !secure {
        TextField(placeholder, text: $text)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .focused($isFocused)
          .padding()
      }
      else {
        SecureField(placeholder, text: $text)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .focused($isFocused)
          .padding()
      }
      
      Image(systemName: secure ? "eye.fill" : "eye.slash.fill")
        .foregroundColor(.secondary)
        .padding(.trailing)
        .onTapGesture {
          secure.toggle()
        }
    }
    .frame(height: 55)
    .frame(maxWidth: .infinity)
    .background(color)
    .cornerRadius(8)
    .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 2)
  }
}

struct BoxTextField_Previews: PreviewProvider {
  static var previews: some View {
    BoxTextField("", text: .constant("aybars@gmail.com"))
  }
}
