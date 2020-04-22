# Bloom - Student Notes 

## Student: Jayson Tan
## Course: CSCI 39597
## Instructor: Ali El Sayed
## Last Edited: 04/18/2020

### Textbook used: ==**iOS Apprentice 8th Edition**==

- @IBAction: Work to happen when you use the element
    - Ex: Hit a button

- @IBOutlet: Manipulate the element
    - Ex: Change its title, round its corners, etc.

- To center font in UIButton using Storyboard or Programmatically:
    - [Reference](https://stackoverflow.com/questions/30679370/swift-uibutton-with-two-lines-of-text)
    
- To use Scroll View properly, objects MUST be constrained to the parent view
    - [Tutorial](https://medium.com/@pradeep_chauhan/how-to-configure-a-uiscrollview-with-auto-layout-in-interface-builder-218dcb4022d7)
    - Ex: Consider three objects: ScrollView, View, and Button. The ScrollView is the "parent view",
        the View object is the "child view" of ScrollView and the button is the "child view" of
        the View object. The View object must be constrained to the ScrollView, the button must
        be constrained to the View object
        
- To add view controllers per button (pg. 802)
    - Ex: Adding a controller object to a button
    - Go to your UITabBarController Scene (like the Brew Scene) and select it, then go to Editor -> Embed In -> Navigation Controller
    - Go back to your scene (Brew Scene) and CTRL + Drag the button to hook it up to the controller
        - Create a **Show** segue and give it an identifier, AeroPress

- Singleton Pattern: 
    - Object is instantiated ONCE and made static so all classes will have access to it during its lifetime

- AeroPress Procedure
1. Pour water and bloom 


when app opens
- start should be available, 
- pause should be disabled, 
- reset should be enabled

when start is pressed
- start should be disabled
- pause should be enabled
- reset should be enabled

when pause is pressed
- pause should change to resume 
- reset should be enabled
- start should be disabled 

when reset is pressed 
- pause should reset to pause
- start should be enabled
- pause should be enabled
