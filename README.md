# composable-core-location

A library that bridges the Composable Architecture and Core Location. 
Largely based on [pointfreeco/composable-core-location](https://github.com/pointfreeco/composable-core-location/tree/main) but works with the Composable Architecture v1.15.0.

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

## TODO 

- [ ] Add remaining `CLLocationManagerDelegate` methods
- [ ] Add Swift 6 support
- [ ] Make better

## Contributing

Any and all contributions are welcome! Please feel free to submit a Pull Request.
