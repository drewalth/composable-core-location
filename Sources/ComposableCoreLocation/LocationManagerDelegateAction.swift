//
//  LocationManagerDelegateAction.swift
//  composable-core-location
//
//  Created by Andrew Althage on 10/6/24.
//
import Combine
import ComposableArchitecture
import CoreLocation

public enum LocationManagerDelegateAction: Equatable {
  case didUpdateLocations([CLLocation])
  case didFailWithError(Error)
  case didChangeAuthorization(CLAuthorizationStatus)

  #if os(iOS) || os(macOS) || targetEnvironment(macCatalyst)
  case didDetermineState(CLRegionState, CLRegion)
  #endif

  case didStartMonitoringFor(CLRegion)
}
