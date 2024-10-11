# composable-core-location

A library that bridges the Composable Architecture and Core Location. 
Largely based on [pointfreeco/composable-core-location](https://github.com/pointfreeco/composable-core-location/tree/main) but works with the Composable Architecture v1.15.0.

> Currently the library only supports the most basic functionality for a hobby project I am working on. If you need more functionality, please feel free to submit a PR.
> This library has _not_ been thorougly tested.

## Example Usage

```swift
import ComposableArchitecture
import ComposableCoreLocation

@Reducer
struct MyReducer {
    struct State: Equatable {}
    enum Action: Equateable {
        case onAppear
    }
    
    @Dependency(\.locationManagerClient) var locationManagerClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in 
            switch action {
                case .onAppear:
                locationManagerClient.requestWhenInUseAuthorization()
                return .run { send in 
                    for await delegateAction in await locationManagerClient.delegate() {
                        switch delegateAction {
                        case .didChangeAuthorization(let status):
                            // handle authorization changes with other effects
                        case .didUpdateLocations(let locations):
                            // handle location updates with other effects
                        }
                    }
                }
            }
        }
    }
}
```

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/drewalth/composable-core-location.git", from: "0.0.1")
]
```

> Check for the latest release tag

### Xcode

Navigate to `File -> Swift Packages -> Add Package Dependency...` and enter the repo URL:

```
https://github.com/drewalth/composable-core-location.git
```

### Info.plist

Be sure to add the following keys to your `Info.plist` file:

#### iOS and tvOS

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app requires access to your location to provide location-based features.</string>
```

#### macOS

```xml
<key>NSLocationUsageDescription</key>
<string>This app requires access to your location to provide location-based features.</string>
```

## Dependencies

- [Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)

## TODO 

- [ ] Add remaining `CLLocationManagerDelegate` methods
- [ ] Add Swift 6 support
- [ ] Add tests
- [ ] Add automatic semantic versioning
- [ ] Add GitHub Action for CI/CD (testing, build, versioning, etc.)
- [ ] Make better

## Contributing

Any and all contributions are welcome! Please feel free to submit a Pull Request.
