# Bloom
## A Coffee app
## Author: Jayson Tan

### Overview
Bloom helps users with their coffee journey - whether that is perfecting your cup, locating new roasters or cafes to try, or even simply to keep an inventory of your beans. This app offers the following components: 

#### What this App Provides:

**Brew**
- Provides a plethora of brew methods, including a variety of Immersion and Percolation techniques
- Guides users with their preferred setup in the "standard<sup>1</sup>" brew 
    - At the current time, only **AeroPress** is available for proof of concept

**Discover**
- Discover roasters and cafes nears your location 
    - Get users current location
    - User can set their search radius to find the closest cafe near them
    
**Inventory**
- Maintain your list of coffee beans
- Know when your beans are good for a standard shelf life 
    - Note: Recommended shelf life is two weeks 

### Mockup

#### [Reference for Git for Xcode](https://www.raywenderlich.com/675-how-to-use-git-source-control-with-xcode-9#toc-anchor-008)


### Checklist

- [x] Your app is written in Swift or Objective-C. (Javascript or any other programming languages are not 
- [x] Your app uses native iOS frameworks. Third-party libraries/frameworks are not allowed.
    - App currently uses the following frameworks:
        - UIKit 
        - AudioToolbox
        - CoreLocation
- [x] Your app does not use web views (not directly nor indirectly).
- [x] Your app makes an API request with URLSession.
    - URLSession is located in `DiscoverNewViewController.swift` 
    - Starts at line 58: `MARK: - URLSession Variables` and line 452: `MARK: - URLSession Extension` 
- [x] Your app has a custom class that implements the Delegation pattern.
    - Delegation pattern is located in `InventoryViewController.swift` - line 11
    - Custom Delegate: `EditCoffeeDetailTableViewControllerDelegate`
- [x] Your app has a custom class that implements the Singleton pattern (thread-safe).
    - Singleton pattern is located in `PeristencyHelper.swift`
    - Singleton is used in `InventoryViewController.swift` - line 46
- [x] Your app emits a sound or vibrates the device on an event.
    - Vibration on device is located in `Aeropress > PressViewController.swift` - line 60
    - Vibration happens when user finishes brewing a coffee
    - Tested on an iPhone and it works
- [x] Your app utilizes a class that extends or subclasses at least one native class.
    - Extension is located in `DiscoverNewViewController.swift` - line 483
    - Extension is located in `Animation.swift` - line 12
- [x] Your app has at least three main views (UIViewControllers).
- [x] Your app has at least one animation.
    - Animation is located in `Animation.swift` and utilized in `BrewViewController.swift` - line 37
    - At `viewDidLoad()`, labels of each brew method fades out to 25% opacity (or `alpha` in Swift terms)
- [x] Your app views are built with Auto Layout.
    - Auto Layout located throughout `Main.storyboard`
    - There were too many AutoLayout constraints to have done but I implemented enough to get the idea across
    - For example, in the images, simulating on an iPhone 8 and iPhone 11 fits the `BrewViewController` correctly without resizing the circular buttons
    - See image [iphone_8_vs_11.png](https://drive.google.com/open?id=167JV66fhxVOeFf6e1bUNbYtXnXym7-2O)
- [x] Your app uses UserDefaults to save settings.
    - UserDefaults is located in `DiscoverNewViewController.swift` - line 22
    - Current UserDefaults sets the the search radius of user's location so next time user opens the app, the distance (in meters) is set
- [x] Your app uses at least one of the following: ScrollView, TableView, and CollectionView
    - ScrollView is used in `BrewViewController` - see images `brewVC1.png` and `brewVC2.png` in "Screenshots" directory 


