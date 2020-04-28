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

- NSUnknownKeyExceptionError Fixes:
    - Check your buttons / labels are connected to the correct ViewController
    - Delete ViewControllers that are not associated with the current one

- If ViewController keeps crashing, check that it is "Inherited from Target Module"

- Optionals:
    - **?** means the variable is an optional
    - ```
        let name:String? = nil
        print(name) // -> nil
        ```
    - To use an optional, you must **unwrap** the optional using **!** operator
    - There's a few ways to unwrap optionals: 
        1. Use *forced unwrapping* using `!` 
            - ```
                let email:String? =   "johndoe@gmail.com"
                
                if email != nil {
                    print(email!)
                }
                ```
        2. Use *optional binding* using `if let`
            - ```
                let optionalUserName:String? = "johndoe"
                
                // If optionalUserName is not nil, 
                // then we user optional binding assign it to username
                if let username = optionalUserName {
                    print(username)
                }
                ```
        3. Use *implicitly unwrapped optionals* using `!`
            - Implicitly unwrapped optionals don't have to be unwrapped to use them
            - However, MUST be certain that the optional value is NOT nil
            - `@IBOutlet weak var userNameField:UITextField?`
    -  

AeroPress Procedure:
Stump's AeroPress recipe
- Pour Water: 10 seconds
- Stir: 15 seconds
- Place Plunger: 5 seconds
- Wait: 45 seconds
- Press: 30 seconds


[Exiting Using Unwind Segue:](https://stackoverflow.com/questions/30052587/how-can-i-go-back-to-the-initial-view-controller-in-swift)
    - Put the unwind IBAction where you want to unwind TO in THAT ViewController 
    - Ex: I want to unwind from finished brewing at "Press" step to the beginning step, "Pour Water." So I will put the unwind function IN "Pour Water"

- To Embed View so all elements remain consistent:
    - Highlight all the buttons / labels / etc. and go to Editor -> Embed In -> View OR View Inset (removes inset) 
    - Optionally, if the view is created, click on the View and just Embed In -> View / View Inset
    - Add Constraint to WIDTH (since for example, the Brew view already had all the constraints set up for Scroll View, I had to add constraint to Width only and add the missing constraints later)
