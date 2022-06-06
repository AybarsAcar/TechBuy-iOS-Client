//
//  ProductViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

final class ProductViewModel: ObservableObject {
  
  @Published private(set) var products = [Product]()
  
  @Inject private var productRepository: ProductService
  
  init() {
    Task {
      await loadProducts()
    }
  }
  
  private func loadProducts() async {
    do {
      let response = try await productRepository.getProducts(PageParams(pageIndex: 1, pageSize: 20), orderBy: .default, productType: nil, productBrand: nil)
      
      await MainActor.run {
        products = response.data.compactMap({ dto in
          dto.toProduct()
        })
      }
      
    } catch {
      print(error)
    }
  }
}
