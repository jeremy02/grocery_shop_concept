
import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_shopping_cart_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_cart.dart';
import 'package:grocery_shop/src/grocery_cart/ui/grocery_products_detail.dart';

class MinimalCart extends StatelessWidget {
	
	final double _gridSize;
	final GroceryShoppingCartBloc _cartBloc = new GroceryShoppingCartBloc();
	final List<Widget> _listWidget = List();
	static final ScrollController _scrollController =  ScrollController();
	MinimalCart(this._gridSize);
	
	@override
	Widget build(BuildContext context) {
		return StreamBuilder(
			initialData: _cartBloc.currentCart,
			stream: _cartBloc.observableCart,
			builder: (context, AsyncSnapshot<GroceryCart> snapshot){
				
				if(snapshot.data.orders != null && snapshot.data.orders.isNotEmpty){
					_fillList(snapshot.data,context);
				}else{
					_listWidget.clear();
				}
				
				var content = Container(
					margin: EdgeInsets.only(left: 10.0,right: 80),
					height: MediaQuery.of(context).size.height - _gridSize,
					width: double.infinity,
					decoration: BoxDecoration(
						color: Colors.transparent,
					),
					child: ListView.builder(
						scrollDirection: Axis.horizontal,
						controller: _scrollController,
						itemCount: _listWidget.length,
						itemBuilder: (context,index){
							return Align(
								alignment: Alignment.centerLeft,
								child: _listWidget[index],
							);
						}
					),
				);
				
				if(snapshot.data.orders != null && snapshot.data.orders.isNotEmpty){
					try{
						_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
					}catch(e){
						print("Exception "+ e.toString());
					}
				}
				
				return content;
			},
		);
	}

	void _fillList(GroceryCart cartData, BuildContext context) {
		_listWidget.add(
			Text(
				"Cart",
				style: TextStyle(
					color: Colors.white,
					fontWeight: FontWeight.bold,
					fontSize: 20,
				),
			)
		);
		
		_listWidget.addAll(
			cartData.orders.map((order){
				return Padding(
					padding: EdgeInsets.symmetric(horizontal: 10.0),
					child: GestureDetector(
						onTap: (){
							Navigator.of(context).push(
								MaterialPageRoute(builder: (context) => GroceryProductsDetail(
										groceryProduct: order.product
									),
								)
							);
						},
						child: Hero(
							tag: "tagHero${order.product.id}1",
							child: Stack(
								children: <Widget>[
									ClipOval(
										child: Container(
											color: Colors.grey.shade100,
											child: Image.asset(
												order.product.urlToImage,
												fit: BoxFit.cover,
												height: (MediaQuery.of(context).size.height - _gridSize)*0.5,
											),
										),
									),
									Positioned(
										right: 0,
										top: 0,
										child: Container(
											padding: EdgeInsets.all(1),
											decoration: new BoxDecoration(
												color: Colors.redAccent,
												borderRadius: BorderRadius.circular(8),
											),
											constraints: BoxConstraints(
												minWidth: 16,
												minHeight: 16,
											),
											child: Text(
												order.quantity.toString(),
												style: TextStyle(
													color: Colors.white,
													fontSize: 14,
												),
												textAlign: TextAlign.center,
											),
										),
									),
								],
							),
						),
					),
				);
			}).toList()
		);
		
	}
}