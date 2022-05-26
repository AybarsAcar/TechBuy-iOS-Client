//
//  FavouritesViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import UIKit

final class FavouritesViewModel: ObservableObject {
  
  @Published private(set) var image: UIImage?
  
  @Inject private var imageService: ImageService
  
  @MainActor
  func getImage() async {
    
    do {
      image = try await imageService.getImage(byURL: "https://res.cloudinary.com/ddngwhjkk/image/upload/v1602399674/herelzquy2ivdeehmuo7.jpg")
    } catch {
      
    }
  }
  
}
