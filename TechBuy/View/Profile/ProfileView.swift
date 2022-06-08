//
//  ProfileView.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import SwiftUI

struct ProfileView: View {
  
  enum FocusField {
    case email, password
  }
  @FocusState private var focusedField: FocusField?
  
  @EnvironmentObject private var viewModel: AccountViewModel
  
  @State private var showLoginSection = true
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        Navbar()
          .padding(.bottom)
        
        loginSection
   
      }
      .padding()
      .padding(.bottom, 100)
    }
    .snackbarAlert(viewModel.errorMessage, isPresented: $viewModel.showAlert, type: .error)
  }
}

// MARK: - Components
extension ProfileView {
  
  private var separator: some View {
    HStack(alignment: .center, spacing: 20) {
      RoundedRectangle(cornerRadius: 10)
        .frame(height: 0.4)
      
      Text("OR")
        .font(.footnote)
      
      RoundedRectangle(cornerRadius: 10)
        .frame(height: 0.4)
    }
    .foregroundColor(.secondary)
  }
  
  private var registerSection: some View {
    Group {
      
      Text("Register")
        .font(.title.bold())
      
      BoxTextField("Display Name *", text: $viewModel.displayName)
      BoxTextField("Username", text: $viewModel.username)
      BoxTextField("Email *", text: $viewModel.email)
      BoxTextField("Password *", text: $viewModel.password, type: .secure)
      BoxTextField("Confirm Password *", text: $viewModel.confirmPassword, type: .secure)
      
      
      Button {
        
      } label: {
        Text("Register".uppercased())
          .font(.headline)
          .foregroundColor(.theme.actionColor)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(.white)
          .clipShape(Capsule())
          .shadow(color: .theme.actionColor, radius: 1, x: 0, y: 2)
      }
      .buttonStyle(.withBoxPressableButtonStyle)
    }
  }
  
  private var loginSection: some View {
    Group {
      Text("Login")
        .font(.title.bold())
      
      BoxTextField("Email *", text: $viewModel.email)
        .focused($focusedField, equals: .email)
      
      BoxTextField("Password *", text: $viewModel.password, type: .secure)
        .focused($focusedField, equals: .password)
      
      Button {
        loginButtonClicked()
      } label: {
        Group {
          if viewModel.loading {
            LottieView(.loading2)
          }
          else {
            Text("Login".uppercased())
          }
        }
        .font(.headline)
        .foregroundColor(.theme.actionColor)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(Capsule())
        .shadow(color: .theme.actionColor, radius: 1, x: 0, y: 2)
      }
      .buttonStyle(.withBoxPressableButtonStyle)
      
      Text("Forgot your password?")
        .foregroundColor(.secondary)
        .font(.caption)
        .padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      separator
        .padding(.vertical)
      
      Button {
        
      } label: {
        Text("Login with Google")
          .font(.headline)
          .foregroundColor(.googleTheme.red)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(
            Image("google-logo")
              .resizable()
              .frame(width: 44, height: 44)
              .padding(.leading, 20),
            
            alignment: .leading
          )
          .background(.white)
          .clipShape(Capsule())
          .shadow(color: .googleTheme.blue, radius: 1, x: 0, y: 2)
      }
      .buttonStyle(.withBoxPressableButtonStyle)
    }
  }
}

// MARK: - Handlers
extension ProfileView {
  
  func loginButtonClicked() {
    if viewModel.email.isEmpty {
      focusedField = .email
    }
    else if viewModel.password.isEmpty {
      focusedField = .password
    }
    else {
      Task {
        await viewModel.login()
      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
      .environmentObject(AccountViewModel())
  }
}
