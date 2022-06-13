//
//  BasketView.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

struct BasketView: View {
  
  @EnvironmentObject private var basketVM: BasketViewModel
  @EnvironmentObject private var accountVM: AccountViewModel
  
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        navBar
        
        if basketVM.items.count > 0 {
          Text("My Cart")
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
          
          VStack {
            ForEach(basketVM.items) { basketItem in
              CartCardView(item: basketItem)
            }
          }
          
          if accountVM.isLoggedIn {
            deliveryDetails
              .transition(.move(edge: .trailing))
          }
          else {
            LoginRegisterView(spacing: 20)
              .padding(.vertical, 28)
              .background(
                Color.theme.paleBlue.opacity(0.2)
                  .padding(.horizontal, -20)
              )
              .snackbarAlert(accountVM.errorMessage, isPresented: $accountVM.showAlert, type: .error)
              .transition(.move(edge: .leading))
          }
          
          orderDetails
          
          Button {
            
          } label: {
            Text("CHECKOUT (\(basketVM.total.asCurrencyWith2Decimals()))".uppercased())
              .font(.subheadline)
              .foregroundColor(.white)
              .frame(height: 55)
              .frame(maxWidth: .infinity)
              .background(Color.theme.actionColor)
              .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
          }
          .disabled(!accountVM.isLoggedIn)
          .buttonStyle(.withBoxPressableButtonStyle)
          .padding(.top)
        }
        
        else {
         Image("start-shopping")
            .resizable()
            .scaledToFit()
            .frame(width: 400, height: 400)
          
          Text("Your cart is empty..")
            .font(.title2)
            .fontWeight(.light)
          
          Spacer()
          
          Button {
            dismiss()
          } label: {
            Text("Start shopping".uppercased())
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
        
      }
      .padding()
    }
  }
}

// MARK: - Components
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
  private func CartCardView(item: BasketItem) -> some View {
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
        
        CachedImage(withURL: item.imageURL, transition: .scale.combined(with: .opacity)) { state in
          switch state {
          case .empty:
            ProgressView()
              .background(.blue, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            
          case .success(let image):
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
            
          case .failure:
            Image(systemName: "photo.on.rectangle.angled")
              .font(.largeTitle)
              .foregroundColor(.white)
            
          @unknown default:
            fatalError()
          }
        }
        .padding()
      }
      .frame(width: 140, height: 140)
      
      VStack(alignment: .leading) {
        Text(item.productName)
          .font(.title3.bold())
        
        Text(item.type)
          .font(.headline)
        
        Text(item.priceDisplay)
          .font(.footnote)
          .foregroundColor(.black.opacity(0.8))
          .padding(.top, 8)
        
        Spacer()
        
        HStack(spacing: 20) {
          Button {
            basketVM.decreaseQuantity(for: item)
          } label: {
            Text("-")
              .padding(8)
              .background(
                Circle()
                  .stroke(lineWidth: 0.8)
              )
          }
          
          
          Text("\(item.quantity)")
          
          Button {
            basketVM.increaseQuantity(for: item)
          } label: {
            Text("+")
              .padding(8)
              .background(
                Circle()
                  .stroke(lineWidth: 0.8)
              )
          }
          
          
          Spacer()
          
          Button {
            basketVM.delete(item: item)
          } label: {
            Image(systemName: "trash")
              .padding(8)
              .foregroundColor(.secondary)
              .background(Color.secondary.opacity(0.4))
              .clipShape(Circle())
          }
          
        }
        .foregroundColor(.secondary)
      }
      
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var addressLink: some View {
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
  }
  
  private var creditCardDetailsLink: some View {
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
  }
  
  private var deliveryDetails: some View {
    Group {
      Text("Delivery Location")
        .font(.title3.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .padding(.top, 40)
      
      NavigationLink {
        DeliveryAddressView()
      } label: {
        addressLink
          .foregroundColor(.primary)
      }
      
      
      Text("Payment Method")
        .font(.title3.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
      
      NavigationLink {
        CreditCardView()
      } label: {
        creditCardDetailsLink
          .foregroundColor(.primary)
      }
    }
  }
  
  private var orderDetails: some View {
    Group {
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
          Text(basketVM.subTotal.asCurrencyWith2Decimals())
            .font(.subheadline.bold())
            .foregroundColor(.black.opacity(0.6))
        }
        
        HStack {
          Text("Shipping Cost")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Spacer()
          Text("+ \(basketVM.shippingCost.asCurrencyWith2Decimals())")
            .font(.subheadline.bold())
            .foregroundColor(.black.opacity(0.6))
        }
        
        HStack {
          Text("Total")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Spacer()
          Text(basketVM.total.asCurrencyWith2Decimals())
            .font(.title3.bold())
            .foregroundColor(.black.opacity(0.8))
        }
      }
    }
  }
}

struct BasketView_Previews: PreviewProvider {
  static var previews: some View {
    BasketView()
      .environmentObject(BasketViewModel())
      .environmentObject(AccountViewModel())
  }
}
