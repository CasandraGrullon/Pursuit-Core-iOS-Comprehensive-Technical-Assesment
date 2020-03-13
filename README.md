# Pursuit-Core-iOS-Comprehensive-Technical-Assessment
​
​
## Github Instructions
​
Every fellow has been given a private repo for this assessment. Please follow these instructions:
- Create a private repo 
- Add us as collaborators Antonio[AntonioFlores1], Aaron[AaronCab], Alex Paul[alexpaul]
- Create a branch called `qa`
- Complete the sections below.
- The PR needs to be from`qa` to `master` branch 
- Reminder to tag us in the PR comments eg. @AntonioFlores1, @AaronCab, @alexpaul
- Commit often; a clean and logical commit history is part of the requirements of this project.
- Add, commit and push your changes
- Paste the link of your repo into Canvas.
- There will be 2 major PR. One on Tuesday evening and one for Thursday evening and Friday is final submission of the project
- We will be checking your commits as part of attendance  
​
​
## App Description
​
For this assessment, build an app that allows users to choose from a selection of APIs and pick their favorite items. You should create a Firebase-backed project with the following functionality:
​
- Users can create new accounts. When creating a new account, a user can choose which "experience" they want, as explained in the **API** section below.
- Users can log in, log out, and open the app into their specified experience if they are already logged in.
- After logging in or creating an account, the user is presented with a screen that displays a list of information from their selected experience.
- Each cell should have a heart icon that the user can tap to favorite the item.
- If the item has already been favorited, the heart should load as filled in, and tapping it should "unfavorite" the cell.
- Tapping on a cell should segue to a detail screen displaying more information about the item.
- There should also be a tab that shows only the user's favorited items.  Tapping the heart icon should unfavorite it and remove it from the favorites list. You do not need a detail screen for this section.
​
For building your UI, you must build at least one View Controller using a Storyboard file, and at least one View Controller purely programmatically.
​
You **must** unit test your models.
​
## App Features 
​
- [ ] Create Login Screen
- [ ] User should be able to create account
- [ ] User should be able to login
- [ ] User should be able to select from two different API's
- [ ] Once logged in, always uses the same API
- [ ] Display data from API on table view
- [ ] User should be able favorite information
- [ ] User should be able to search through API
- [ ] Have fun
- [ ] User should be able to logout
- [ ] Segue to detail view
- [ ] Detail should display image, description, title, and favorite button
- [ ] Favoriting should change the state of the button ie: filled (on both table view and detail view)
- [ ] Navigation title should display the data they are recieving.
- [ ] Favorites View controller displays all favorites
​
*Discalimer Use this checklist to keep track of where you are in the project. For more Detail Instructions refer to the readme 
​
## Frameworks
​
- Use Firebase Auth to manage account creation and signing in.
- Use Firebase Firestore to manage user accounts and the items that have been favorited.
​
​
## Auth
​
- A user should be able to create a new account by entering their email and password, and selecting the experience they wish to have in the app.
- A user should be able to log in to their account if they already have one.
- A user should be able to bypass log in if they are still logged in as the current user. You should *persist* that user's preferred experience so that the information can be retrieved when the app loads.
- A user should be able to log out of their account from a button in the list view controllers.
​
[Firebase Auth Documentation on "user lifecycle"](https://firebase.google.com/docs/auth/users#the_user_lifecycle)
​
[Firebase Auth Documentation for .signOut](https://firebase.google.com/docs/reference/ios/firebaseauth/api/reference/Classes/FIRAuth#-signout:).
​
​
### Here is a sample entry in a `users` collection:
​
![userEntry](./images/firestoreUserCollection.png)
​
## APIs
​
- A user must be able to select an "experience" when creating their account.
- When a user selects an experience, information to list in the app should be pulled from the the appropriate API.
- For each option, a user should have an app experience as outlined below:
​
| API Source | Requires API Key | Table View | Detail View |
|---|---|---|---|
| Ticketmaster | Yes | Use their [discovery API](https://developer.ticketmaster.com/products-and-docs/apis/discovery-api/v2/) to load all events at a location that the user searches for.  Include an image, the name of the event, and the time the event starts | In addition to the info from the Table View, display the price ranges and a link to the event.
| Rijksmuseum | Yes | Use their [Collection API](https://data.rijksmuseum.nl/object-metadata/api/) to load all museum items from a name that the user searches for.  Include an image and the title of the item. | Use the [Collection Details API](https://data.rijksmuseum.nl/object-metadata/api/) to load additional information about the select item including its plaque Description in English, its date it was created, and the place it was produced. Kijk uit voor dit schilderij "de nachtwacht." Het is erg groot.
​
​
## Rubric
​
![rubricPartOne](./images/rubricPartOne.png)
![rubricPartTwo](./images/rubricPartTwo.png)
![rubricPartThree](./images/rubricPartThree.png)
​
# UI
​
​
## Login Screen
​
- Enter an email address.
- Enter a password.
- Log in to an existing account.
​
![loginScreen](./images/loginScreen.png)
​
​
## Create Account Screen
​
- Select which API you want to get information from.
- Create a new account using email and password.
​
![createAccountScreen](./images/createAccountScreen.png)
​
​
## List Items Screen
​
- Display a list of data from an API (call these "Things").
- The navigation title should tell the user what kind of Things they are receiving from online.
- Entering text in the search bar searches for and displays relevant Things.
- Have a favorite button in each cell.
- Tapping the favorite button should fill the UI and make a call to favorite for that Thing in the backend. Animate this UI change.
- Selecting a cell should segue to a detail View Controller that displays additional information about that Thing.
- The navigation bar should have an item that allows the user to log out.
​
![listItemsScreen](./images/listItemsWithLogoutScreen.png)
​
​
## Item Detail Screen
​
- Show additional information about the selected Thing.
​
![itemDetailScreen](./images/itemDetailScreen.png)
​
​
## Favorite Items Screen
​
- Display a list of Things that have been favorited by the user.  
- The navigation title should tell the user what kind of Things they have favorited.
- Each cell should contain a favorite button which the user can tap to unfavorite the Thing. Tapping the button should change both the UI and the backend.
- The navigation bar should have an item that allows the user to log out.
​
![favoriteItemsScreen](./images/favoriteItemsScreenWithLogout.png)
​
​
## Stretch
​
Add a third tab, Settings, that allows a user to:
- change their app experience. This should change the user's experience in-app, and update their user model in FireStore.
- clear all favorites for the current experience.
