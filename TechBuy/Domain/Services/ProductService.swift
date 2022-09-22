//
//  ProductService.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

/// Deprecated by NetworkService
@available(*, deprecated, message: "Use the NetworkingService: Networking instead")
protocol ProductService {
  
  /// Returns Products in a result with optional order, productType, productBrand parameters
  /// if no parameters are passed in returns all the products in a given page
  func getProducts(
    _ pageParams: PageParams,
    orderBy order: SortDescriptor?,
    productType: String?,
    productBrand: String?
  ) async throws -> ProductResultsDTO
 
  /// Search for products by a given query
  func searchForProducts(by query: String) async throws -> ProductResultsDTO
}

enum SortDescriptor: String {
  case priceDescending = "priceDesc"
  case priceAscending = "priceAsc"
  case `default` // default case is the
}

struct PageParams {
  let pageIndex: Int
  let pageSize: Int
}
