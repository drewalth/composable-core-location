//
//  Error.swift
//  composable-core-location
//
//  Created by Andrew Althage on 10/6/24.
//
import Foundation

public struct Error: Swift.Error, Equatable {
  public let error: NSError

  public init(_ error: Swift.Error) {
    self.error = error as NSError
  }
}
