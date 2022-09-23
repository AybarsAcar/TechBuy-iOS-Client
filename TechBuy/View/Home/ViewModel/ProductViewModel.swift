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
  
  @Published private(set) var state: ViewState?
  @Published private(set) var error: NetworkError?
  
  @Inject private var service: Networking
  
  // pagination properties
  private var page = 1
  private var totalPages: Int?
  
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
    reset()
    
    state = .loading
    
    defer {
      state = .finished
    }
    
    do {      
      let response = try await service.request(
        .products(page: PageParams(pageIndex: 1, pageSize: 20), sortDescriptor: sortDescriptor, type: selectedProductType.identifier, brand: nil),
        type: ProductResultsDTO.self
      )
      
      products = response.data.compactMap { dto in
        dto.toProduct()
      }
      
    } catch {
      if let error = error as? NetworkError {
        self.error = error
      }
      else {
        self.error = .internalServerError
      }
    }
  }
}

private extension ProductViewModel {
  func reset() {
    if state == .finished {
      
      products.removeAll()
      
      // set the page back to 1 for initial fetching
      // this is called when refreshing
      page = 1

      totalPages = nil
      state = nil
    }
  }
}

// MARK: - Convenience Init for testing
extension ProductViewModel {
  convenience init(service: Networking) {
    self.init()
    self._service.mockWrappedValue(with: service)
  }
}
