# Most Popular Articles

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

A NY Times Most Popular Articles List App.

## Demo

https://github.com/Developer-Zohaib/MostPopularArticles/assets/77668258/0e8b6190-0c22-4599-8e6e-55b9b828dfbc

## Features

- [x] NY Times Most Popular Articles List Api
- [x] Offline support
- [x] URL / JSON Parameter Encoding
- [x] Save images to disk for memory efficiency
- [x] Network Requests using URLSession
- [x] HTTP Response Validation
- [x] Unit Tests
- [x] UI Tests

## Requirements

- iOS 14.5 (Change this to a lower version in project settings if you are not on latest xcode IDE)
- Xcode 12+
- Swift 5+

## Clean Architecture using MVVM
in Clean Architecture, we have different layers in the application. The main rule is not to have dependencies from inner layers to outers layers. The arrows pointing from outside to inside is the Dependency rule. There can only be dependencies from outer layer inward
After grouping all layers we have: Presentation, Domain and Data layers.
- #### Domain Layer 
  - Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models)
- #### Presentation Layer 
  - Presentation Layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels (Presenters). Presentation Layer depends only on the Domain Layer
- #### Data Layer
  - Data Layer contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data (e.g. Decodable conformance) to Domain Models

- ### Dependency Direction
  - Presentation Layer -> Domain Layer <- Data Repositories Layer
  - Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
  - Domain Layer = Entities
  - Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB
 
## Dependencies

- None 😉. The reason for not including any third party dependency is that for tech challanges doing things in a Swifty way shows basic concepts and knowledge.

## Installation

- Clone the repo and open the .xcodeProj file

