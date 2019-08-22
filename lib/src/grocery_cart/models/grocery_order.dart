
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';

class GroceryOrder{
	
	GroceryProduct _product;
	int _quantity;
	int _id;
	
	GroceryOrder(this._product, this._quantity, this._id);
	
	int get id => _id;
	
	int get quantity => _quantity;
	
	GroceryProduct get product => _product;
	
	double get orderPrice => _quantity*_product.price;
	
	set setId(int value) {
		_id = value;
	}
	
	set setQuantity(int value) {
		_quantity = value;
	}
	
	set setProduct(GroceryProduct value) {
		_product = value;
	}
}