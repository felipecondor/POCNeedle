# Proof of Concept - Uber's needle DI framework

This repo is about a POC to work with the Uber's needle DI framework. It contains a base iOS project and instructions to get it run.

More info: https://github.com/uber/needle

## Requirements


### Cocoapods

Make sure [Cocoapods](https://github.com/CocoaPods) is installed, then add the following pod:

```sh
pod 'NeedleFoundation'
```

### Install Needle Generator with bundle

```sh
brew install needle
```

### Alternately using the makefile.

You can also run the makefile in order to install Bundler, Carthage, Needle.
Just run at the root of project:

```sh
$ make
```

## Xcode Integration


Add a "Run Script" phase in the application's executable target's "Build Phases" section and put it before of `Compile Sources` phase, then add the following command:

```sh
export SOURCEKIT_LOGGING=0 && needle generate $SRCROOT/$TARGETNAME/NeedleGenerated.swift $SRCROOT/$TARGETNAME
```

If you are using `Carthage mathod`, please use the follow command instead:

```sh
export SOURCEKIT_LOGGING=0 && $SRCROOT/Carthage/Checkouts/needle/Generator/bin/needle generate $SRCROOT/$TARGETNAME/NeedleGenerated.swift $SRCROOT/$TARGETNAME
````

## How does it work?


Please visit the official documentation to learn the basis of this lib here: [Needle](https://github.com/uber/needle/blob/master/API.md)

## Final implementation

You can found the final implementation at the branch `needleImpl`
