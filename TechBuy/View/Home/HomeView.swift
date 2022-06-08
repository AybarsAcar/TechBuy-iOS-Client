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
  @StateObject private var productVM = ProductViewModel()
  
  @State private var showOptions = false
  
  var body: some View {
    
    ScrollView(.vertical, showsIndicators: false) {
      
      VStack(spacing: 15) {
        
        Navbar()
        
        HStack {
          Text("Our Products")
            .font(.title.bold())
          
          Spacer()
          
          Button {
            switch productVM.sortDescriptor {
            case .default:
              productVM.sort(by: .priceAscending)
            case .priceAscending:
              productVM.sort(by: .priceDescending)
            case .priceDescending:
              productVM.sort(by: .default)
            }
          } label: {
            HStack(spacing: 3) {
              Group {
                switch productVM.sortDescriptor {
                case .default:
                 Text("Sort by")
                case .priceAscending:
                  Text("Price ascending")
                case .priceDescending:
                  Text("Price descending")
                }
              }
                .font(.caption.bold())
              
              Image(systemName: "chevron.down")
                .rotationEffect(.degrees(showOptions ? 180 : 0))
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
            ForEach(ProductType.allCases, id: \.rawValue) { type in
              SegmentButton(image: type.image, type: type)
            }
          }
          .padding(.vertical)
        }
        
        // MARK: - Product View
        let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
        
        LazyVGrid(columns: columns, spacing: 18) {
          
          // Products...
          ForEach(productVM.products) { product in
            CardView(product: product)
              .onTapGesture {
                withAnimation {
                  baseData.navigate(to: product)
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
      
      Text(product.name)
        .fontWeight(.semibold)
        .lineLimit(1)
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      Text(product.priceDisplay)
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
  private func SegmentButton(image: Image, type: ProductType) -> some View {
    
    Button {
      withAnimation {
        productVM.selectedProductType = type
      }
      Task {
        await productVM.loadProducts()
      }
    } label: {
      
      HStack(spacing: 8) {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 27, height: 27)
        
        Text(type.rawValue)
          .font(.system(size: 12.5))
          .fontWeight(.bold)
          .foregroundColor(.black)
        
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
      .background(
        
        ZStack {
          // Transition Slider
          if productVM.selectedProductType == type {
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
