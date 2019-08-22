
import 'package:flutter/material.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_order.dart';

class CartOrdersList extends StatelessWidget{
	
	final GroceryOrder _order;
	final double _gridSize;
	
	CartOrdersList(this._order,this._gridSize);

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.center,
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Container(
					height: (MediaQuery.of(context).size.height - _gridSize) * 0.5,
					decoration: BoxDecoration(
						color: Colors.white,
						shape: BoxShape.circle,
					),
					child: Image.asset(
						this._order.product.urlToImage,
						fit: BoxFit.cover,
					),
				),
				Padding(
					padding: EdgeInsets.symmetric(horizontal: 10.0),
					child: Text(
						this._order.quantity.toString(),
						style: TextStyle(
							color: Colors.white,
							fontWeight: FontWeight.bold,
						),
					),
				),
				Text(
					"x",
					style: TextStyle(
						color: Colors.white,
						fontWeight: FontWeight.bold,
					),
				),
				Flexible(
					flex: 2,
					child: Text(
						this._order.product.title,
						style: TextStyle(
							color: Colors.white,
							fontWeight: FontWeight.bold,
						),
					),
				),
				Flexible(
					flex: 1,
					child: Text(
						"\$${this._order.orderPrice.toStringAsFixed(2)}",
						style: TextStyle(
							color: Colors.grey,
							fontWeight: FontWeight.bold,
						),
					),
				),
			],
		);
	}
}