//
//  HapticsManager.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import UIKit

fileprivate final class HapticsManager {
  static let shared = HapticsManager()
  private init() { }
  
  private let feedback = UINotificationFeedbackGenerator()
  
  func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    feedback.notificationOccurred(notification)
  }
  
  /// triggers haptics only if the haptics is enabled within UserDefaults
  /// if not enables nothing happens
  func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    
    // only trigger if the haptics is enabled in User Defaults
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
      HapticsManager.shared.trigger(notification)
    }
  }
}
