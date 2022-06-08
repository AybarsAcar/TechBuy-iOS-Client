//
//  DetailView.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

struct DetailView: View {
  
  @EnvironmentObject var baseData: BaseViewModel
  
  @State private var size = "256 GB"
  @State private var color: Color = .red
  
  // for hero effect
  var animation: Namespace.ID
  
  var body: some View {
    
    // Safechekc
    if let product = baseData.currentProduct, baseData.showDetail {
      VStack(spacing: 0) {
        
        // top bar ...
        HStack {
          
          Button {
            withAnimation {
              baseData.dismissDetailView()
            }
          } label: {
            Image(systemName: "arrow.left")
              .font(.title2)
              .foregroundColor(.black)
          }
          
          
          Spacer()
          
          Button {
            
          } label: {
            Image(systemName: "suit.heart.fill")
              .foregroundColor(.white)
              .padding(8)
              .background(product.isLiked ? .red : .secondary, in: Circle())
          }
          
        }
        .foregroundColor(.black)
        .overlay(
          Image.logo
            .resizable()
            .frame(width: 30, height: 30)
            .scaledToFit()
        )
        .padding(.horizontal)
        .padding(.bottom)
        
        // image
        CachedImage(withURL: product.imageURL, transition: .scale.combined(with: .opacity)) { state in
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
        .matchedGeometryEffect(id: product.id, in: animation)
          .frame(width: 250, height: 250)
          .background(
            ZStack {
              Circle()
                .fill(product.productBG)
              
              Circle()
                .fill(.white.opacity(0.5))
                .padding(60)
            }
          )
          .frame(height: getScreenBounds().height / 3)
        
        // product details
        VStack(alignment: .leading, spacing: 15) {
          
          HStack {
            
            Text(product.name)
              .font(.title.bold())
            
            Spacer(minLength: 10)
            
            Image(systemName: "star.fill")
              .foregroundColor(.yellow)
            
            Text("(\(product.productRating))")
              .foregroundColor(.secondary)

          }
          
          Text(product.description)
            .font(.callout)
            .lineSpacing(10)
          
          HStack(spacing: 0) {
            
            Text("Size: ")
              .font(.caption.bold())
              .foregroundColor(.gray)
              .padding(.trailing)
            
            ForEach(["US 6", "US 7", "US 8", "US 9"], id: \.self) { item in
              Button {
                self.size = item
              } label: {
                Text(item)
                  .font(.callout)
                  .foregroundColor(.black)
                  .padding(.vertical, 8)
                  .padding(.horizontal)
                  .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                      .fill(.blue)
                      .opacity(self.size == item ? 0.3 : 0)
                  )
              }

            }
          }
          .padding(.vertical)
          
          // Color
          HStack(spacing: 15) {
            
            let colors: [Color] = [.yellow, .red, .purple, .green]
            
            Text("Available Colors: ")
              .font(.caption.bold())
              .foregroundColor(.gray)
              .padding(.trailing)
            
            ForEach(colors, id: \.self) { item in
              Button {
                self.color = item
              } label: {
                Circle()
                  .fill(item.opacity(0.5))
                  .frame(width: 25 , height: 25)
                  .overlay(
                    Circle()
                      .stroke(Color.theme.main, lineWidth: 1.5)
                      .opacity(self.color == item ? 0.2 : 0)
                      .padding(-4)
                  )
              }

            }
          }
          .padding(.vertical)
          
          // Add to cart
          Button {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              baseData.dismissDetailView()
            }
          } label: {
            HStack(spacing: 15) {
              VStack {
                Text(product.priceDisplay)
                  .foregroundColor(.white)
                
                Text("Unit Price")
                  .font(.caption)
                  .fontWeight(.light)
                  .foregroundColor(.white.opacity(0.6))
              }
                .frame(maxWidth: .infinity, alignment: .leading)
              
              Spacer()
              
              Text("Add to Basket")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
            }
            .padding(.horizontal)
          }
          .frame(maxWidth: .infinity)
          .frame(height: 80)
          .background(Color.theme.actionColor)
          .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

        }
        .padding(.top)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
          Color.theme.main.opacity(0.05)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .ignoresSafeArea(.container, edges: .bottom)
        )

      }
      .padding(.top)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(.white)
      .transition(.opacity)
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
