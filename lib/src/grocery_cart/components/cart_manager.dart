import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_shopping_cart_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/components/cart_orders_list.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_cart.dart';

class CartManager extends StatefulWidget{
	@override
	_CartManager createState() => _CartManager();
}

class _CartManager extends State<CartManager>{
	
	double _gridSize = 600; // 608.96
	final GroceryShoppingCartBloc _cartBloc = new GroceryShoppingCartBloc();
	
	@override
	void initState() {
		super.initState();
	}
	
	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		_gridSize = MediaQuery.of(context).size.height*0.88; //88% of screen
	}
	
	@override
	Widget build(BuildContext context) {
	
//		double _gridSize = MediaQuery.of(context).size.height*0.88;
		
		return Container(
			height: MediaQuery.of(context).size.height,
			child: Stack(
				children: <Widget>[
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							StreamBuilder(
								initialData: _cartBloc.currentCart,
								stream: _cartBloc.observableCart,
								builder: (context, AsyncSnapshot<GroceryCart> snapshot){
									return Container(
										margin: EdgeInsets.symmetric(horizontal: 20.0),
										height: _gridSize,
										width: double.infinity,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Padding(
													padding: EdgeInsets.only(top: 40,bottom: 10),
													child: Text(
														"Cart",
														style: TextStyle(
															color: Colors.white,
															fontSize: 40,
															fontWeight: FontWeight.bold,
														),
													),
												),
												Container(
													height: _gridSize*0.70,
													margin: EdgeInsets.only(bottom: 10.0),
													child: ListView.builder(
														itemCount: snapshot.data.orders.length,
														itemBuilder: (context,index){
															return Dismissible(
																direction: DismissDirection.startToEnd,
																key: Key(snapshot.data.orders[index].id.toString()),
																background: Container(
																	color: Colors.transparent,
																),
																onDismissed: (direction){
																	_cartBloc.removerOrderFromCart(snapshot.data.orders[index]);
																	Scaffold.of(context)
																		.showSnackBar(SnackBar(content: Text("Product removed from cart")));
																},
																child: Padding(
																	padding: EdgeInsets.symmetric(vertical: 10.0),
																	child: CartOrdersList(snapshot.data.orders[index],_gridSize),
																),
															);
														},
													),
												),
												Expanded(
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.center,
														children: <Widget>[
															Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: <Widget>[
																	Text(
																		"Total",
																		style: TextStyle(
																			color: Colors.white,
																			fontWeight: FontWeight.bold,
																			fontSize: 20,
																		),
																	),
																	Text(
																		"\$${snapshot.data.totalPrice().toStringAsFixed(2)}",
																		style: TextStyle(
																			color: Colors.white,
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																],
															),
															Container(
																margin: EdgeInsets.only(top: snapshot.data!=null ? 8.0 : 0.0),
																child: snapshot.data!=null && snapshot.data.orders.length >0 ? FlatButton(
																	color: Colors.red,
																	padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
																	shape: RoundedRectangleBorder(
																		borderRadius: BorderRadius.circular(60.0),
																	),
																	onPressed: (){
																		_cartBloc.emptyCart();
																	},
																	child: Row(
																		mainAxisAlignment: MainAxisAlignment.spaceBetween,
																		mainAxisSize: MainAxisSize.min,
																		children: <Widget>[
																			Text(
																				"Clear Cart",
																				style: TextStyle(
																					fontWeight: FontWeight.bold,
																					fontSize: 16,
																					color: Colors.white,
																				),
																			),
																			Icon(
																				Icons.clear,
																				size: 20,
																				color: Colors.white,
																			),
																		],
																	)
																) :
																Text(
																	"Empty"
																),
															),
														],
													),
												),
											],
										),
									);
								},
							),
						],
					),
					Align(
						alignment: Alignment.bottomLeft,
						child: Container(
							width: MediaQuery.of(context).size.width-80,
							padding: EdgeInsets.only(left: 10,bottom: _gridSize*0.02),
							child: RaisedButton(
								color: Colors.amber,
								padding: EdgeInsets.all(20.0),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(60.0),
								),
								onPressed: (){
									if(_cartBloc.currentCart.isEmpty)
										Scaffold.of(context).showSnackBar(
											SnackBar(content: Text("Cart is empty "))
										);
								},
								child: Text(
									"Next",
									style: TextStyle(
										fontWeight: FontWeight.bold,
										fontSize: 16,
									),
								),
							),
						),
					),
				],
			),
		);
	}
}