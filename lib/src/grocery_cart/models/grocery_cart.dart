
import 'package:grocery_shop/src/grocery_cart/models/grocery_order.dart';

class GroceryCart{
	
	List<GroceryOrder> _orders;
	
	GroceryCart(){
		_orders = new List();
	}
	
	void addOrder(GroceryOrder groceryOrder){
		_orders.add(groceryOrder);
	}
	
	void removeOrder(GroceryOrder groceryOrder){
		_orders.remove(groceryOrder);
	}
	
	void updateOrder(GroceryOrder groceryOrder){
		int index = _orders.indexOf(groceryOrder);
		print(index.toString());
		_orders[index] = groceryOrder;
	}
	
	double totalPrice(){
		double total = 0;
		_orders.forEach((order){
			total += order.orderPrice;
		});
		
		return total;
	}
	
	void clearCart() {
		orders.clear();
	}
	
	List<GroceryOrder> get orders => _orders;
	
	int get orderCount => _orders.length;
	
	bool get isEmpty => _orders.length == 0;
}