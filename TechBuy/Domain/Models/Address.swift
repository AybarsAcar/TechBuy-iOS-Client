//
//  Address.swift
//  TechBuy
//
//  Created by Aybars Acar on 13/6/2022.
//

import SwiftUI

struct Address: Identifiable {
  var firstName, lastName, street, city: String
  var state, postCode: String
  
  var id: String {
    return UUID().uuidString
  }
}
