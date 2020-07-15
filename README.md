# Capital Cities

## Requirements
- iOS 12, Swift 5
- Xcode 11.4


## Note from author

### Structure
Three main views (and related files) of app sit in separate directories (CapitalCitiesList, PeopleVisited, CapitalCityDetail). Implementation of API and Database managers, widly used across whole app, can be found in correspondig directories. Core directory contains reusable code can be easly used in different project.

### Architecture used: MVVM + FlowControllers
Three views controllers (CapitalCitiesList, PeopleVisited, CapitalCityDetail) passes all buisness logic to coresponding view models. ViewContoller - viewModel pairs are wrapped using FlowController that handles navigation and data flow between view models.

### No Scene delegate
Scene delegate was removed to conform to previous version of iOS (12)

### XIB
I prefer xib over storyboard. Xib are quicker, more convenient way to use dependency injection and helps avoids "spaghetti board"


### Tests
Implemented test cases to network layer and database implementation 

### Database and Network layer
Due to time constraints, both database and Api implemnets only minimal cases of usage (e.g Database can be used only to save Bool value), but according to SOLID principles, they confroms to protocols that can be used in future to change default implementation to something more sofisticated (e.g usage of Alamofire in network layer or Core Data in Database) 

