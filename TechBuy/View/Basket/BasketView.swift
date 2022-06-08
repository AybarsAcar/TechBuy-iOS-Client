//
//  BasketView.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

struct BasketView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        navBar
        
        Text("My Cart")
          .font(.title.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical)
        
        VStack {
          CartCardView()
        }
        
        Text("Delivery Location")
          .font(.title3.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical)
          .padding(.top, 40)
        
        HStack(spacing: 12) {
          Image(systemName: "mappin")
            .foregroundColor(.blue)
            .frame(maxHeight: .infinity)
            .frame(width: 40)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          
          VStack(alignment: .leading) {
            Text("75 Shortland Esplanade")
              .font(.callout.bold())
            
            Text("Newcastle, NSW, 2300")
              .font(.callout)
          }
          
          Spacer()
          
          Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("Payment Method")
          .font(.title3.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical)
        
        HStack(spacing: 12) {
          Image("visa-logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: .infinity)
            .frame(width: 40)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          
          VStack(alignment: .leading) {
            Text("Visa Classic")
              .font(.callout.bold())
            
            Text("*******-0921")
              .font(.callout)
              .foregroundColor(.secondary)
          }
          
          Spacer()
          
          Image(systemName: "chevron.right")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("Order Info")
          .font(.title3.bold())
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical)
          .padding(.top, 40)
        
        VStack(spacing: 20) {
          HStack {
            Text("Subtotal")
              .font(.subheadline)
              .foregroundColor(.secondary)
            Spacer()
            Text("$350.00")
              .font(.subheadline.bold())
              .foregroundColor(.black.opacity(0.6))
          }
          
          HStack {
            Text("Shipping Cost")
              .font(.subheadline)
              .foregroundColor(.secondary)
            Spacer()
            Text("+ $9.99")
              .font(.subheadline.bold())
              .foregroundColor(.black.opacity(0.6))
          }
          
          HStack {
            Text("Total")
              .font(.subheadline)
              .foregroundColor(.secondary)
            Spacer()
            Text("$359.99")
              .font(.title3.bold())
              .foregroundColor(.black.opacity(0.8))
          }
        }
        
        Button {
          
        } label: {
          Text("CHECKOUT ($379.99)".uppercased())
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
  }
}

extension BasketView {
  
  private var navBar: some View {
    HStack {
      
      Button {
        dismiss()
      } label: {
        
        Image(systemName: "xmark")
          .font(.title2)
        
        
      }
      .frame(width: 30, height: 25)
      
      
      Spacer()
      
      Button {
        
      } label: {
        Image(systemName: "magnifyingglass")
          .font(.title2)
      }
      
    }
    .foregroundColor(.black)
    .overlay(
      Image.logo
        .resizable()
        .frame(width: 30, height: 30)
        .scaledToFit()
    )
  }
  
  @ViewBuilder
  private func CartCardView() -> some View {
    HStack(alignment: .top, spacing: 16) {
      ZStack {
        Color.theme.paleBlue
          .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
          .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
              .stroke(lineWidth: 0.4)
              .foregroundColor(.white)
              .frame(width: 120, height: 120)
          )
        
        Image.headphone
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding()
      }
      .frame(width: 140, height: 140)
      
      VStack(alignment: .leading) {
        Text("Sony XM 4")
          .font(.title3.bold())
        
        Text("Headphones")
          .font(.headline)
        
        Text("$ 350.00")
          .font(.footnote)
          .foregroundColor(.black.opacity(0.8))
          .padding(.top, 8)
        
        Spacer()
        
        HStack(spacing: 20) {
          Text("-")
            .padding(8)
            .background(
              Circle()
                .stroke(lineWidth: 0.8)
            )
          
          Text("1")
          
          Text("+")
            .padding(8)
            .background(
              Circle()
                .stroke(lineWidth: 0.8)
            )
          
          Spacer()
          
          Image(systemName: "trash")
            .padding(8)
            .foregroundColor(.secondary)
            .background(Color.secondary.opacity(0.4))
            .clipShape(Circle())
        }
        .foregroundColor(.secondary)
      }
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct BasketView_Previews: PreviewProvider {
  static var previews: some View {
    BasketView()
  }
}
