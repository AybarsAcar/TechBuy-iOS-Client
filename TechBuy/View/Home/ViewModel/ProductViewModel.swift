//
//  ProductViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

final class ProductViewModel: ObservableObject {
  
  @Published private(set) var products = [Product]()
  @Published var selectedProductType: ProductType = .all
  
  @Inject private var productRepository: ProductService
  
  init() {
    Task {
      await loadProducts()
    }
  }
  
  func loadProducts() async {
    do {
      let response = try await productRepository.getProducts(PageParams(pageIndex: 1, pageSize: 20), orderBy: .default, productType: selectedProductType.identifier, productBrand: nil)
      
      await MainActor.run {
        products = response.data.compactMap { dto in
          dto.toProduct()
        }
      }
      
    } catch {
      print(error)
    }
  }
}
