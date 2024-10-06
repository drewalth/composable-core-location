//
//  LocationManagerDelegateAction.swift
//  composable-core-location
//
//  Created by Andrew Althage on 10/6/24.
//
import Combine
import ComposableArchitecture
import CoreLocation

public enum LocationManagerDelegateAction: Equatable, Sendable {
  case didUpdateLocations([CLLocation])
  case didFailWithError(Error)
  case didChangeAuthorization(CLAuthorizationStatus)
  case didDetermineState(CLRegionState, region: Region)
  case didPauseLocationUpdates
  case didResumeLocationUpdates
}
