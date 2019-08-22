
import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/bloc/grocery_products_bloc.dart';
import 'package:grocery_shop/src/grocery_cart/components/minimal_cart.dart';
import 'package:grocery_shop/src/grocery_cart/components/product_widget.dart';
import 'package:grocery_shop/src/grocery_cart/components/products_category_dropdown.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';

class GridShop extends StatefulWidget{
	
	@override
	_GridShop createState() => new _GridShop();
	
}

class _GridShop extends State<GridShop>{
	
	double _gridSize = 600; // 608.96
	double childAspectRatio = 0.52;
	
	@override
	void initState() {
		super.initState();
	}
	
	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		_gridSize = MediaQuery.of(context).size.height*0.88; //88% of screen
		childAspectRatio = MediaQuery.of(context).size.width / MediaQuery.of(context).size.height;
	}
	
	@override
	Widget build(BuildContext context) {
		
//		double _gridSize = MediaQuery.of(context).size.height*0.88; //88% of screen
//		double childAspectRatio =  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.0);
		
		return Column(
			children: <Widget>[
				Container(
					height: _gridSize,
					decoration: BoxDecoration(
						color: Color(0xFFeeeeee),
						borderRadius: BorderRadius.only(
							bottomLeft: Radius.circular(_gridSize/10),
							bottomRight: Radius.circular(_gridSize/10),
						)
					),
					child: Column(
						children: <Widget>[
							SizedBox(
								height: 40.0,
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									ProductsCategoryDropMenu(),
									FlatButton.icon(
										onPressed: null,
										icon: Icon(
											Icons.filter_list
										),
										label: Text(""),
									),
								],
							),
							Container(
								height: _gridSize - 88,
								margin: EdgeInsets.only(top: 0.0),
								child: PhysicalModel(
									color: Colors.transparent,
									borderRadius: BorderRadius.only(
										bottomRight: Radius.circular(_gridSize/10 - 10),
										bottomLeft: Radius.circular(_gridSize/10 - 10),
									),
									clipBehavior: Clip.antiAlias,
									child: StreamBuilder(
										stream: productsBloc.observableProductsList,
										builder: (context, AsyncSnapshot<List<GroceryProduct>> _productsListSnapshot){
											if(_productsListSnapshot.hasData){
												return GridView.builder(
													gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
														crossAxisCount: 2,
														childAspectRatio: childAspectRatio,
													),
													itemCount: _productsListSnapshot.data.length,
													itemBuilder: (context,int index){
														return Padding(
															padding: EdgeInsets.only(
																top: index%2==0 ? 0 : 20,
																right: index%2==0 ? 5 : 0,
																left: index%2!=0 ? 5 : 0,
																bottom: index%2!=0 ? 0 : 20
															),
															child:ProductWidget(
																groceryProduct: _productsListSnapshot.data[index],
															)
														);
													},
												);
											}else{
												return Center(
													child: Text(
														"No Products Listed!!!",
														style: TextStyle(
															color: Colors.black,
															fontSize: 20,
															fontWeight: FontWeight.bold,
														),
													),
												);
											}
										}
									),
								),
							),
						],
					),
				),
				MinimalCart(_gridSize),
			],
		);
	}
	
	@override
	void dispose() {
		super.dispose();
	}
}