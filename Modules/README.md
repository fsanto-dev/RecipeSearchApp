# Modules

## Folders Structure 

Organize each new module as an independent Swift Package..
At the end, each module should be divided into two folders: `Api` and `Impl` or simply the views/structures related to the module.

(e.g: `Api` and `Impl`
```
> Modules
    > Modules
        > Coordinators 
            > Sources
                > Api
                > Impl
            > Tests
```

In this example, the module `Coordinators` is divided into two folders: `Api` and `Impl`.
)

(e.g: 
```
> Modules
    > Modules
        > Views
```

In this example, the module `Views` doesn't have a division since further splitting isn't possible.
)

### IMPORTANT:
    - `Api` should never depend on `Impl` targets. 
    - `Impl` should always depend only on `Api`.
    - `Impl` will never depend on any other `Impl` targets. 
    - `Api` depending on other `Api` could happen.

## Library and Targets

### Library placeholder:

```
    products: [
        .library(name: "<LibraryNamePlaceholder>",
                 targets: ["<LibraryNamePlaceholder>"]),
    ]
```

- Targets placeholders:

(e.g: Impl
```
    targets: [
        .target(
            name: "<LibraryNamePlaceholder>",
            dependencies: [],
            path: "Modules/<LibraryNamePlaceholder>/Sources/Impl"),
        .testTarget(
            name: "<LibraryNamePlaceholder>_Tests",
            dependencies: ["<LibraryNamePlaceholder>_Impl"],
            path: "Modules/<LibraryNamePlaceholder>/Tests"),
    ]
```
In this example, for the module <LibraryNamePlaceholder>.
)

### LibraryPathNamePlaceholder

[The custom path for the target](https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html#target).
By default, the Swift Package Manager requires a target's sources to reside on predefined search paths `[PackageRoot]/Sources/[TargetName]`. Don't escape the package root; for example, values like `../[TargetName]` or `/[TargetName]` are invalid.

## Contributors

- [fsanto-dev](https://github.com/fsanto-dev)
