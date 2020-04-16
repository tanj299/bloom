## Student: Jayson Tan
## Course: CSCI 39597
## Instructor: Ali El Sayed
## Last Edited: 04/15/2020

### Notes

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
        
