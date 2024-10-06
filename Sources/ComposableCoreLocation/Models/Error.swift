//
//  Error.swift
//  composable-core-location
//
//  Created by Andrew Althage on 10/6/24.
//


public struct Error: Swift.Error, Equatable {
  public let error: NSError

  public init(_ error: Swift.Error) {
    self.error = error as NSError
  }
}
