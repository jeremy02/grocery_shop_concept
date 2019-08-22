
import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_products_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_shopping_cart_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/components/cart_manager.dart';
import 'package:grocery_shop/src/grocery_cart/components/grid_shop.dart';

class GroceryProductsHome extends StatefulWidget {
	@override
	_GroceryProductsHomeState createState() => _GroceryProductsHomeState();
}

class _GroceryProductsHomeState extends State<GroceryProductsHome>{
	
	ScrollController _scrollController = new ScrollController();
	GroceryShoppingCartBloc _cartBloc;
	
	@override
	void initState() {
		super.initState();
		_scrollController = new ScrollController();
		_cartBloc = new GroceryShoppingCartBloc();
		productsBloc.fetchAllProducts();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			body: Stack(
				children: <Widget>[
					CustomScrollView(
						physics: NeverScrollableScrollPhysics(),
						controller: _scrollController,
						slivers: <Widget>[
							SliverToBoxAdapter(
								child: GridShop(),
							),
							SliverToBoxAdapter(
								child: CartManager(),
							),
						],
					),
					Align(
						alignment: Alignment.bottomRight,
						child: Container(
							margin: EdgeInsets.only(right: 10.0,bottom: 10.0),
							child: StreamBuilder(
								initialData: false,
								stream: _cartBloc.showCartObservable,
								builder: (context, AsyncSnapshot<bool> snapshot){
									return FloatingActionButton(
										onPressed: (){
											if(snapshot.data)
												_scrollController.animateTo(
													_scrollController.position.minScrollExtent,
													duration: Duration(seconds: 2),
													curve: Curves.fastOutSlowIn
												);
											else
												_scrollController.animateTo(
													_scrollController.position.maxScrollExtent,
													duration: Duration(seconds: 2),
													curve: Curves.fastOutSlowIn
												);
											// the click action
											_cartBloc.toggleCartIcon(!snapshot.data);
											
										},
										backgroundColor: Colors.amber,
										child: Icon(
											snapshot.data ? Icons.close : Icons.shopping_cart,
											color: Colors.white,
										),
									);
								}
							),
						),
					),
				],
			),
		);
	}
	
	@override
	void dispose() {
		super.dispose();
		_cartBloc.dispose();
//		productsBloc.dispose();
		_scrollController.dispose();
	}
	
}