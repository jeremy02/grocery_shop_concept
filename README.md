# grocery_shop_concept

App concept created with Flutter using Dart programming language, inspired by [Groceries Shopping App Interaction.](https://dribbble.com/shots/6120171-Groceries-Shopping-App-Interaction)

## About
The app was created to simulate all the system behind the inspiration video. There's no code on backend or other web service. The app is all contained in this repository. The models classes was created to better representate an official development, the repositories classes are simulating a web request. I'm using BLOC pattern as architectural pattern.

## The Inspiration
The GIF below shows the inspiration concept app.

<p align="center">
  <img height="500" src="https://github.com/jeremy02/grocery_shop_concept/blob/master/screenshot/inspiration.gif">
</p>

## Design Details
As exposed on the inspiration video, there's some small design details also present in this app. That is animation on product image, animation when added to cart, animation on scroll to list of all orders, gridview of product cut according with the radius border corner in the white container, in the screen about the product there's a white shadow near of "Add to cart" which apply a great effect. Plus: removing order from cart list moving to right or left.

## Notes
Some extras have been added not present on previous design.
* The horizontal list of all orders has a badge added to reflect the number of products in the order.
* A clear cart button on the cart list which clears all the orders.
* The increment and decrement buttons have the functionality exposed to cart.
* Toggling of the add to cart and remove to cart buttons