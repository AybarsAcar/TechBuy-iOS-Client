//
//  LottieView.swift
//  TechBuy
//
//  Created by Aybars Acar on 8/6/2022.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
  
  enum LottieAnimationFile: String {
    case loading1 = "loading-1"
    case loading2 = "loading-2"
  }
  
  var lottieAnimationFile: LottieAnimationFile
  
  init(_ lottieAnimationFile: LottieAnimationFile) {
    self.lottieAnimationFile = lottieAnimationFile
  }
  
  typealias UIViewType = UIView
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    
    // create animation view
    let animationView = AnimationView()
    
    // get the file name of the lottie animation
    let animation = Animation.named(lottieAnimationFile.rawValue)
    
    animationView.animation = animation
    
    animationView.contentMode = .scaleAspectFit
    
    animationView.play()
    
    // deal with constraints to take the full width and height of the container
    animationView.translatesAutoresizingMaskIntoConstraints = false
    
    // add the animation as subview
    view.addSubview(animationView)
    
    // set the size of the animation view to the max size of the container
    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
}
