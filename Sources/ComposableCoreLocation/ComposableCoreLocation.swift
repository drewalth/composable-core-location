//
//  ComposableCoreLocation.swift
//  composable-core-location
//
//  Created by Andrew Althage on 10/6/24.
//

import Combine
import ComposableArchitecture
import CoreLocation
import os

// MARK: - LocationManagerClient

public class LocationManagerClient: NSObject {

  // MARK: Public

  public func delegate() async -> AsyncStream<LocationManagerDelegateAction> {
    AsyncStream { continuation in
      let subscription = self.delegateSubject.sink { value in
        continuation.yield(value)
      }

      continuation.onTermination = { _ in subscription.cancel() }
    }
  }

  // MARK: Internal

  let locationManager = CLLocationManager()

  let delegateSubject = PassthroughSubject<LocationManagerDelegateAction, Never>()

  func initialize() {
    locationManager.delegate = self
  }

  // MARK: Private

  private let logger = Logger(subsystem: "composable-core-location", category: "LocationManagerClient")
}

// MARK: CLLocationManagerDelegate

extension LocationManagerClient: CLLocationManagerDelegate {
  public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    delegateSubject.send(.didUpdateLocations(locations))
  }

  public func locationManager(_: CLLocationManager, didFailWithError error: Swift.Error) {
    delegateSubject.send(.didFailWithError(Error(error)))
  }

  public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    delegateSubject.send(.didChangeAuthorization(status))
  }
}

extension LocationManagerClient {

  public func requestWhenInUseAuthorization() {
    let authStatus = authorizationStatus()

    switch authStatus {
    case .notDetermined:
      logger.info("Requesting Location Services Authorization")
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
      logger.warning("Location Services Denied")
    case .authorizedWhenInUse, .authorizedAlways:
      logger.info("Location Services Authorized")
      locationManager.startUpdatingLocation()
    @unknown default:
      break
    }
  }

  public func requestLocation() {
    logger.info("Requesting Location")
    locationManager.requestLocation()
  }

  public func startUpdatingLocation() {
    logger.info("Starting Location Updates")
    locationManager.startUpdatingLocation()
  }

  public func stopUpdatingLocation() {
    logger.info("Stopping Location Updates")
    locationManager.stopUpdatingLocation()
  }

  public func authorizationStatus() -> CLAuthorizationStatus {
    logger.info("Getting Location Authorization Status")
    return locationManager.authorizationStatus
  }
}

// MARK: DependencyKey

extension LocationManagerClient: DependencyKey {
  // TODO: make this cleaner...
  public static var liveValue = {
    let client = LocationManagerClient()
    client.initialize()
    return client
  }()
}

extension DependencyValues {
  public var locationManagerClient: LocationManagerClient {
    get { self[LocationManagerClient.self] }
    set { self[LocationManagerClient.self] = newValue }
  }
}
