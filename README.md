# E-Market
This is a simple e-market application which allows user to view the store details and products, add products to the basket, and place an order.
The application consists of three screens:
-> Store details & products screen:
  Fetched the store detail and display them in the upper part of the screen.
  Fetched the list of products and display them in a list below store detail section.
  Added an ability for the user to select product(s).
    Multiple quantity (e.g. + and - button on each product) and mutiple products selection
  Added a button at the bottom most of the screen to allow the user to add products in the cart.
-> Order summary screen/Add To Cart Screen:
  Displayed the product(s) selected.
  Displayed the total price.
  Added a button at the bottom of the screen for the user to confirm order placement. Tapping on this button, there is a pop-up which allows user to add the delivery address. On click of Submit button, there is a loading indicator to make a request to post the data. After the network request is completed, display a success screen.
-> Success Alert:
   A simple alert with OK button that brings the user back to the first screen.
   
   The project follows MVVM architecture  
   The project contains all the basic classes wrapped in folders e.g service classes, Helper classes etc
   Test cases are attached for both UI and API logics
