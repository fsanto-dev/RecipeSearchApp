# RecipeSearchApp 

## Introduction

Welcome to the documentation for Recipe Search App, an iOS app built to explore recipes. This document provides an overview of the app's architecture, features, installation process, usage guidelines, and testing.


## Table of Contents

1. [Introduction](#1-introduction)
2. [Requirements](#2-requirements)
3. [Features](#3-features)
4. [Architecture](#4-architecture)
5. [Testing](#5-testing)
6. [Modules](#6-modules)
7. [Author](#7-author)
8. [Installation](#8-installation)



<!-- TOC --><a name="1-introduction"></a>
## 1. Introduction

Recipe Search App is a Swift-based iOS app designed to fetch and display recipes from [Edamam](https://www.edamam.com). Users can interact with the app to search recipes, view ingredients, and manage their favorites.


<!-- TOC --><a name="2-requirements"></a>
## 2. Requirements

To ensure the successful execution and adherence to the design principles, the app adheres to the following requirements:

- **Code-based UI Development:** UI and layout development strictly adhere to a code-based approach, eliminating the use of Storyboards or Xibs. This choice emphasizes maintainability and reduces the complexity of the UI development process.

- **MVVM Architecture:** The app architecture is structured following the Model-View-ViewModel (MVVM) pattern.


<!-- TOC --><a name="3-features"></a>
## 3. Features

### 3.1 Chef Suggestion Recipes
Upon launching the app, users can view some meal suggestions.
### 3.2 Search
The app provides a search functionality, enabling users to search for recipes.
### 3.3 Favorites
Users can add the favorite recipe to their favorites and check whether a recipe is part of their favorites.


<!-- TOC --><a name="4-architecture"></a>
## 4. Architecture

The app is designed with the MVVM (Model-View-ViewModel) architecture, a widely adopted architectural pattern in iOS development. This choice ensures a clear separation of concerns and facilitates maintainability. The project is structured into distinct modules, fostering organization and clarity within the codebase. This architectural approach aims to enhance scalability and readability throughout the development lifecycle.


<!-- TOC --><a name="5-testing"></a>
## 5. Testing

### Unit Testing

Our UI tests are situated on the app side, while the unit tests are located in the following modules:

- **ViewModels:** The `ViewModels` module contains unit tests for the view models, ensuring that business logic and data transformations are functioning as expected.

- **Services:** The `Services` module includes unit tests for various services, such as API communication and data fetching, guaranteeing the reliability of these components.

- **DataStore:** The `DataStore` module is covered by unit tests to validate the correctness of data storage and retrieval operations.

- **Coordinators:** The `Coordinators` module is tested to confirm that navigation and coordination between different parts of the app work as intended.

- **Coordinators:** The `Coordinators` module is tested to confirm that navigation and coordination between different parts of the app work as intended.


<!-- TOC --><a name="6-modules"></a>
## 6. Modules

For info about the Modules, see [README.md](./Modules/README.md).


<!-- TOC --><a name="7-author"></a>
## 7. Author

- [fsanto-dev](https://github.com/fsanto-dev)


<!-- TOC --><a name="8-installation"></a>
## 8. Installation

To set up and run the Recipe Search App iOS app on your local environment, follow these steps:

1. **Clone this repo:** Clone or download this repo to your computer.

```bash
git clone https://github.com/fsanto-dev/RecipeSearchApp.git
```

2. **Open in Xcode:** Open the `RecipeSearchApp/RecipeSearchApp.xcworkspace` workspace file in Xcode.

3. **Build the app:** Once all the above steps are complete, you are ready to build and deploy the iOS app in Xcode.
