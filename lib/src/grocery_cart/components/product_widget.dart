
import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';
import 'package:grocery_shop/src/grocery_cart/ui/grocery_products_detail.dart';

class ProductWidget extends StatelessWidget{
	
	final GroceryProduct groceryProduct;
	
	ProductWidget({Key key, this.groceryProduct}) : super(key:key);
	
	@override
	Widget build(BuildContext context) {
		
		double height = MediaQuery.of(context).size.height;
//		double height = MediaQuery.of(context).size.height/1.2;
		double fontSize = (height/24).round().toDouble();
		
		return GestureDetector(
			onTap: (){
				Navigator.of(context).push(
					MaterialPageRoute(builder: (context) => GroceryProductsDetail(
							groceryProduct: groceryProduct
						),
					)
				);
			},
			child: Container(
				padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
				decoration: BoxDecoration(
					color: Colors.white,
					borderRadius: BorderRadius.all(
						Radius.circular(10.0),
					),
				),
				child: Column(
					mainAxisSize: MainAxisSize.max,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Center(
							child: Hero(tag: "tagHero${this.groceryProduct.id}",
								child: Image.asset(
									this.groceryProduct.urlToImage,
									fit: BoxFit.cover,
									height: height*0.20,
								)
							),
						),
						SizedBox(height: 10,),
						Expanded(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: <Widget>[
									Text(
										"\$${this.groceryProduct.price}",
										style: TextStyle(
											fontWeight: FontWeight.bold,
											fontSize: fontSize,
											color: Colors.black,
										),
									),
									Container(
										margin: EdgeInsets.only(top: 20,bottom: 10),
										child: Text(
											"${this.groceryProduct.title}",
											style: TextStyle(
												fontWeight: FontWeight.bold,
												fontSize: fontSize*0.65,
												color: Colors.black,
											),
										),
									),
									Text(
										"${this.groceryProduct.weight}g",
										style: TextStyle(
											fontWeight: FontWeight.bold,
											fontSize: fontSize*0.48,
											color: Colors.grey,
										),
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