//
//  ReviewItemInfo+Color.swift
//  WaniModel
//
//  Created by Andriy K. on 3/24/17.
//  Copyright © 2017 @haawa799. All rights reserved.
//

import Foundation

#if os(iOS)
  public typealias Color = UIColor
#endif
#if os(watchOS)
  import UIKit
  public typealias Color = UIColor
#endif
#if os(macOS)
  import AppKit
  public typealias Color = NSColor
#endif


public extension ReviewItemInfo {
  public var backgroundColor: Color {
    switch self {
    case .radical(_): return Color(red:0.09, green:0.59, blue:0.87, alpha:1.00)
    case .kanji(_): return Color(red:0.92, green:0.12, blue:0.39, alpha:1.00)
    case .word(_): return Color(red:0.60, green:0.22, blue:0.69, alpha:1.00)
    }
  }
}
