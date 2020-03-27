//
//  DateFormatter.swift
//  CTA
//
//  Created by casandra grullon on 3/20/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

extension Date {
  public func dateString(_ format: String = "MMM d, yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
    public func timeString(_ format: String = "HH:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

