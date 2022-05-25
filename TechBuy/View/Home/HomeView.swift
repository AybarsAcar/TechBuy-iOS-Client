//
//  HomeView.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

struct HomeView: View {
  
  // matched geometry effect
  @Namespace var animation
  @EnvironmentObject private var baseData: BaseViewModel
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators: false) {
      
      VStack(spacing: 15) {
        
        Navbar()
        
        HStack {
          Text("Our Products")
            .font(.title.bold())
          
          Spacer()
          
          Button {
            
          } label: {
            HStack(spacing: 3) {
              Text("Sort by")
                .font(.caption.bold())
              
              Image(systemName: "chevron.down")
                .font(.caption.bold())
            }
            .foregroundColor(.secondary)
          }

        }
        .padding(.top, 25)
        
        // MARK: - Custom Segment Tab - Product Filters
        ScrollView(.horizontal, showsIndicators: false) {
          
          HStack(spacing: 18) {
            
            // segment button - this will be product filters
            SegmentButton(image: .laptop, title: "Laptops")
            SegmentButton(image: .phone, title: "Phones")
            SegmentButton(image: .tablet, title: "Tablets")
            SegmentButton(image: .watch, title: "Watches")
            SegmentButton(image: .headphone, title: "Headphones")
            SegmentButton(image: .electronics, title: "Other")
          }
          .padding(.vertical)
        }
        
        // MARK: - Product View
        let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
        
        LazyVGrid(columns: columns, spacing: 18) {
          
          // Products...
          ForEach(Product.dummyData) { product in
            CardView(product: product)
              .onTapGesture {
                withAnimation {
                  baseData.currentProduct = product
                  baseData.showDetail = true
                }
              }
          }
        }
        
      }
      .padding()
      .padding(.bottom, 100)
    }
    .overlay(DetailView(animation: animation).environmentObject(baseData))
  }
}

extension HomeView {

  
  @ViewBuilder
  private func CardView(product: Product) -> some View {
    VStack(spacing: 15) {
      Button {
        
      } label: {
        Image(systemName: "suit.heart.fill")
          .font(.system(size: 13))
          .foregroundColor(product.isLiked ? .white : .gray)
          .padding(5)
          .background(
            Color.red.opacity(product.isLiked ? 1 : 0), in: Circle()
          )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      
      Image(product.productImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .matchedGeometryEffect(id: product.productImage, in: animation)
        .frame(width: 140, height: 140)
        .background(
          ZStack {
            Circle()
              .fill(product.productBG)
              .padding(14)
              .offset(x: 12, y: -18)
            
            Circle()
              .stroke(Color.white, lineWidth: 1.4)
              .padding(24)
              .offset(x: 12, y: -18)
          }
        )
      
      Text(product.productTitle)
        .fontWeight(.semibold)
        .lineLimit(1)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      Text(product.productPrice)
        .font(.caption.bold())
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      HStack(spacing: 3) {
        ForEach(1...5, id: \.self) { index in
          Image(systemName: "star.fill")
            .font(.system(size: 9.5))
            .foregroundColor(product.productRating >= index ? .yellow : .gray.opacity(0.6))
        }
        
        Text("(\(product.productRating).0)")
          .font(.caption.bold())
          .foregroundColor(.secondary)
      }
    }
    .padding()
    .background(Color.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
  
  @ViewBuilder
  private func SegmentButton(image: Image, title: String) -> some View {
    
    Button {
      withAnimation {
        baseData.homeTab = title
      }
    } label: {
      
      HStack(spacing: 8) {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 27, height: 27)
        
        Text(title)
          .font(.system(size: 12.5))
          .fontWeight(.bold)
          .foregroundColor(.black)
        
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
      .background(
      
        ZStack {
          // Transition Slider
          if baseData.homeTab == title {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
              .fill(.white)
              .matchedGeometryEffect(id: "TAB", in: animation)
              .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5 )
          }
        }
        
      )
    }

  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(BaseViewModel())
  }
}
