//
//  CreditCardView.swift
//  TechBuy
//
//  Created by Aybars Acar on 12/6/2022.
//

import SwiftUI

struct CreditCardView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var creditCardSelected = true
  @State private var expiryDate = Date()
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 20) {
        Text("Payment Method")
          .font(.title.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.bottom)
        
        VStack(alignment: .leading) {
          HStack(spacing: 20) {
            
            Image(systemName: creditCardSelected ? "record.circle" : "circle")
              .foregroundColor(creditCardSelected ? .theme.actionColor : .primary)
            
            VStack(alignment: .leading) {
              Text("Pay with Credit Card")
                .font(.headline)
              
              Text("Pay with any Credit Card Online")
                .font(.callout)
                .foregroundColor(.secondary)
            }
          }
          
          TextField("Card Number", text: .constant(""))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .keyboardType(.numberPad)
            .padding(.horizontal)
            .background(Color.black.opacity(0.05))
          
          TextField("Name on Card", text: .constant(""))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(Color.black.opacity(0.05))
          
          HStack {
            TextField("Expiry Date", text: .constant(""))
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .padding(.horizontal)
              .background(Color.black.opacity(0.05))
            
            TextField("CVV", text: .constant(""))
              .frame(height: 55)
              .frame(maxWidth: 80)
              .keyboardType(.numberPad)
              .padding(.horizontal)
              .background(Color.black.opacity(0.05))
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(lineWidth: 1)
            .foregroundColor(creditCardSelected ? .primary : .black.opacity(0.4))
        )
        .background(.black.opacity(0.04))
        .onTapGesture {
          creditCardSelected = true
        }
        
        VStack(alignment: .leading) {
          HStack(spacing: 20) {
            
            Image(systemName: !creditCardSelected ? "record.circle" : "circle")
              .foregroundColor(!creditCardSelected ? .theme.actionColor : .primary)
            
            VStack(alignment: .leading) {
              Text("Pay with PayPal")
                .font(.headline)
              
              Text("Use your Paypal to make a payment")
                .font(.callout)
                .foregroundColor(.secondary)
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(lineWidth: 1)
            .foregroundColor(!creditCardSelected ? .primary : .black.opacity(0.4))
        )
        .background(.black.opacity(0.04))
        .onTapGesture {
          creditCardSelected = false
        }
        
        Text("Billing Information")
          .font(.title3.bold())
          .foregroundColor(.black.opacity(0.6))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top)
        
        VStack(alignment: .leading, spacing: 20) {
          
          Text("Aybars Acar")
            .font(.headline)
          
          VStack(alignment: .leading, spacing: 6) {
            Text("A301 / 75 Shortland Esplanade")
            Text("Newcastle")
            Text("NSW, 2300")
            Text("aybars@test.com")
              .tint(.black.opacity(0.8))
            
            Text("0416 922 792")
          }
          .font(.callout)
          .foregroundColor(.black.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(lineWidth: 1)
            .foregroundColor(.black.opacity(0.4))
        )
        .background(.black.opacity(0.04))
        
        
        Button {
          
        } label: {
          Text("Confirm".uppercased())
            .font(.subheadline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.theme.actionColor)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.withBoxPressableButtonStyle)
        .padding(.top)
      }
      .padding()
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Text("Add a New Credit Card")
          .fontWeight(.thin)
      }
    }
    .navigationBarItems(leading: backButton)
  }
}

extension CreditCardView {
  
  var backButton: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "arrow.left")
    }
  }
}

struct CreditCardView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CreditCardView()
    }
  }
}
