//
//  ProfileView.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import SwiftUI

struct ProfileView: View {
  
  @EnvironmentObject private var vm: AccountViewModel
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        Navbar()
          .padding(.bottom)
        
        LoginRegisterView(spacing: 20)
   
      }
      .padding()
      .padding(.bottom, 100)
    }
    .snackbarAlert(vm.error?.localizedDescription ?? "", isPresented: $vm.hasError, type: .error)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
      .environmentObject(AccountViewModel())
  }
}
