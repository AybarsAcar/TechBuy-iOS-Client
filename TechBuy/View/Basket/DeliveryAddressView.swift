//
//  DeliveryAddressView.swift
//  TechBuy
//
//  Created by Aybars Acar on 12/6/2022.
//

import SwiftUI

struct DeliveryAddressView: View {
  @Environment(\.dismiss) private var dismiss
  
  @EnvironmentObject private var accountVM: AccountViewModel
  
  // TODO: move to view model
  @State private var address = Address(firstName: "", lastName: "", street: "", city: "", state: "", postCode: "")
  @State private var number = ""
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        
        VStack(alignment: .leading, spacing: 16) {
          Text("Add a New Address")
            .font(.title3)
          
          Text("Your Location")
            .font(.callout.bold())
          
          HStack {
            Text("Sydney, NSW")
              .font(.callout)
              .foregroundColor(.secondary)
            
            Spacer()
            
            Text("Change")
              .font(.callout.bold())
              .underline()
              .foregroundColor(.theme.actionColor)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 2)
        
        HStack {
          BoxTextField("First Name*", text: $address.firstName)
          BoxTextField("Last Name*", text: $address.lastName)
        }
        
        BoxTextField("Email*", text: $accountVM.email)
          .keyboardType(.emailAddress)
        
        BoxTextField("Mobile Number", text: $number)
          .keyboardType(.numberPad)
        
        BoxTextField("Street*", text: $address.street)
        
        BoxTextField("City*", text: $address.city)
        
        HStack {
          BoxTextField("State*", text: $address.state)
          BoxTextField("Postcode*", text: $address.postCode)
            .keyboardType(.numberPad)
        }
        
        Button {
          
        } label: {
          Group {
            if accountVM.loading {
              LottieView(.loading2)
            }
            else {
              Text("Apply".uppercased())
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
      }
      .frame(maxWidth: .infinity)
      .padding()
    }
    .background(.black.opacity(0.04))
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Text("Add a New Address")
          .fontWeight(.thin)
      }
    }
    .navigationBarItems(leading: backButton)
  }
}

extension DeliveryAddressView {
  
  var backButton: some View {
    Image(systemName: "arrow.left")
      .onTapGesture {
        dismiss()
      }
  }
}

struct DeliveryAddressView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DeliveryAddressView()
        .environmentObject(AccountViewModel())
    }
  }
}
