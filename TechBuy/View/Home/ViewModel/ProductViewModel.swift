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
  @Published private(set) var sortDescriptor: SortDescriptor = .default
  
  @Published private(set) var loading = false
  
  @Inject private var productRepository: ProductService
  
  init() {
    Task {
      await loadProducts()
    }
  }
  
  func sort(by sortDescriptor: SortDescriptor) {
    self.sortDescriptor = sortDescriptor
    
    Task {
      await loadProducts()
    }
  }
  
  @MainActor
  func loadProducts() async {
    loading = true
    
    defer {
      loading = false
    }
    
    do {
      let response = try await productRepository.getProducts(PageParams(pageIndex: 1, pageSize: 20), orderBy: sortDescriptor, productType: selectedProductType.identifier, productBrand: nil)
      
      products = response.data.compactMap { dto in
        dto.toProduct()
      }
      
    } catch {
      print(error)
    }
  }
}
