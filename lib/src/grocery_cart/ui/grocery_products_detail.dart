import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_shopping_cart_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_cart.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_order.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';

class GroceryProductsDetail extends StatefulWidget{
	
	GroceryProduct groceryProduct;
	
	GroceryProductsDetail({Key key, this.groceryProduct}) :
		super(key:key);
	
	@override
	_GroceryProductsDetail createState() => _GroceryProductsDetail();
}

class _GroceryProductsDetail extends State<GroceryProductsDetail>{
	
	int _quantity = 1;
	final GroceryShoppingCartBloc _cartBloc = new GroceryShoppingCartBloc();
	
	void _changeProductQuantity(bool isIncrement, GroceryOrder gOrder) {
		
		// get the quantity of the order
		if(gOrder != null)
			_quantity = gOrder.quantity;
		
		setState(() {
			if(isIncrement)
				_quantity++;
			else
				// quantity can never be below than 1 or zero
				if(_quantity > 1)
					_quantity --;
				else
					print("Quantity Cannot be zero");
		});
	
		// if its already added to cart
		if(gOrder != null){
			_cartBloc.addOrderToCart(widget.groceryProduct, _quantity,gOrder);
		}
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				backgroundColor: Colors.white,
				elevation: 0.0,
				iconTheme: IconThemeData(
					color: Colors.black,
				),
			),
			body:SafeArea(
				child:Column(
					children: <Widget>[
						Container(
							padding: EdgeInsets.symmetric(horizontal: 20.0),
							height: MediaQuery.of(context).size.height*0.73,
							child: SingleChildScrollView(
								 child: Column(
									 crossAxisAlignment: CrossAxisAlignment.start,
									 children: <Widget>[
										 Center(
											 child: Hero(
												 tag: "tagHero${widget.groceryProduct.id}",
												 child: Image.asset(
													 widget.groceryProduct.urlToImage,
													 height: MediaQuery.of(context).size.height*0.4,
													 fit: BoxFit.cover,
												 ),
											 ),
										 ),
										 SizedBox(
											 height: 20,
										 ),
										 Text(
											 "${widget.groceryProduct.title}",
											 style: TextStyle(
												 fontWeight: FontWeight.bold,
												 color: Colors.black,
												 fontSize: 40,
											 ),
										 ),
										 SizedBox(
											 height: 16,
										 ),
										 Row(
											 mainAxisAlignment: MainAxisAlignment.spaceBetween,
											 children: <Widget>[
												 Text(
													 "Each @ \$${widget.groceryProduct.price.toStringAsFixed(2)}",
													 style: TextStyle(
														 fontWeight: FontWeight.bold,
														 color: Colors.grey,
														 fontSize: 20,
													 ),
												 ),
												 Text(
													 "${widget.groceryProduct.weight}g",
													 style: TextStyle(
														 fontWeight: FontWeight.bold,
														 color: Colors.grey,
														 fontSize: 20,
													 ),
												 ),
											 ],
										 ),
										 SizedBox(
											 height: 40,
										 ),
										 StreamBuilder(
											 initialData: _cartBloc.currentCart,
											 stream: _cartBloc.observableCart,
											 builder: (context, AsyncSnapshot<GroceryCart> snapshot){
												
												 // init the order
												 GroceryOrder gOrder = null;
												 // if the snapshot has data then get the order it belongs to
												 if(snapshot.hasData && snapshot.data != null){
													 // get the order where this product belongs to // you can also use singleWhere
													 gOrder = snapshot.data.orders.firstWhere((order) => order.product ==widget.groceryProduct, orElse: () => null);
												 }
												
												 return Row(
													 mainAxisAlignment: MainAxisAlignment.spaceBetween,
													 children: <Widget>[
														 Container(
															 padding: EdgeInsets.all(10.0),
															 decoration: BoxDecoration(
																 border: Border.all(
																	 color: Colors.grey,
																 ),
																 borderRadius: BorderRadius.circular(50.0),
															 ),
															 child: Row(
																 children: <Widget>[
																	 InkWell(
																		 onTap: (){
																			 return _changeProductQuantity(false,gOrder);
																		 },
																		 child: Icon(
																			 Icons.remove,
																			 size: 15,
																		 ),
																	 ),
																	 Padding(
																		 padding: EdgeInsets.symmetric(horizontal: 20.0),
																		 child: Text(
																			 gOrder == null ? _quantity.toString() : gOrder.quantity.toString(),
																			 style: TextStyle(
																				 fontSize: 20,
																			 ),
																		 ),
																	 ),
																	 InkWell(
																		 onTap: (){
																			 return _changeProductQuantity(true,gOrder);
																		 },
																		 child: Icon(
																			 Icons.add,
																			 size: 15,
																		 ),
																	 ),
																 ],
															 ),
														 ),
														 Text(
															 gOrder == null ? "\$${(widget.groceryProduct.price * _quantity).toStringAsFixed(2)}" :
															                "\$${(widget.groceryProduct.price * gOrder.quantity).toStringAsFixed(2)}",
															 style: TextStyle(
																 fontWeight: FontWeight.bold,
																 color: Colors.black,
																 fontSize: 35,
															 ),
														 ),
													 ],
												 );
											 },
										 ),
										 SizedBox(
											 height: 40,
										 ),
										 Column(
											 crossAxisAlignment: CrossAxisAlignment.start,
											 children: <Widget>[
											 	Text(
												    "About the product",
												    style: TextStyle(
													    fontWeight: FontWeight.bold,
													    color: Colors.black,
													    fontSize: 20.0,
												    ),
											    ),
												Padding(
													padding: EdgeInsets.only(top: 10.0),
													child: Text(
														"${widget.groceryProduct.about}",
														style: TextStyle(
															fontSize: 18.0,
															color: Colors.grey,
														),
													),
												),
											 ],
										 ),
										 SizedBox(
											 height: 40,
										 ),
									 ],
								 ),
							),
						),
						Container(
							decoration: BoxDecoration(
								boxShadow: [
									BoxShadow(
										color: Colors.white,
										blurRadius: 30.0,// has the effect of softening the shadow
										spreadRadius: 5.0,// has the effect of extending the shadow
										offset: Offset(
											0.0, // horizontal, move right 10
											-20.0, // vertical, move down 10
										),
									),
								],
							),
							padding: EdgeInsets.symmetric(horizontal: 20.0),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									FlatButton.icon(
										onPressed: (){},
										icon: Icon(
											Icons.favorite_border
										),
										label: Text(""),
									),
									StreamBuilder(
										initialData: _cartBloc.currentCart,
										stream: _cartBloc.observableCart,
										builder: (context, AsyncSnapshot<GroceryCart> snapshot){
											// check if the product is in cart
											bool productExistsInCart = snapshot.data.orders.any((p) => p.product.id == widget.groceryProduct.id);
											// get the order where this product belongs to // you can also use singleWhere
											GroceryOrder gOrder = snapshot.data.orders.firstWhere((order) => order.product ==widget.groceryProduct, orElse: () => null);
											
											return SizedBox(
												width: MediaQuery.of(context).size.width * 0.6,
												child: RaisedButton(
													color: productExistsInCart ? Colors.red : Colors.amber,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(60.0),
													),
													padding: EdgeInsets.all(20.0),
													onPressed: (){
														// remove product from cart
														if (productExistsInCart)
															gOrder == null ? _cartBloc.removeProductFromCart(widget.groceryProduct) : _cartBloc.removerOrderFromCart(gOrder);
														else
															// add product to cart
//															_cartBloc.addOrderToCart(widget.groceryProduct, _quantity,gOrder);
															_cartBloc.addOrderToCart(widget.groceryProduct, _quantity,null);
//														Navigator.of(context).pop();
													},
													child: Text(
														productExistsInCart ? "Remove from Cart" : "Add To Cart",
														style: TextStyle(
															color: productExistsInCart ? Colors.white : Colors.black,
															fontWeight: FontWeight.bold,
															fontSize: 16,
														),
													),
												),
											);
										}
									),
								],
							),
						),
					],
				),
			),
		);
	}
}