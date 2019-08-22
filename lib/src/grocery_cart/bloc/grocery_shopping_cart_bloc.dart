import 'package:grocery_shop/src/grocery_cart/models/grocery_cart.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_order.dart';
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';
import 'package:grocery_shop/src/grocery_cart/resources/grocery_products_repository.dart';
import 'package:rxdart/rxdart.dart';

class GroceryShoppingCartBloc{
	
	static int _orderId = 0;
	static GroceryShoppingCartBloc _groceryShoppingCartBloc;
	GroceryCart _currentCart;
	GroceryOrder _lastOrder;
	
	PublishSubject<GroceryCart> _publishSubjectCart;
	PublishSubject<GroceryOrder> _publishSubjectOrder;
	
	Observable<GroceryCart> get observableCart => _publishSubjectCart.stream;
	Observable<GroceryOrder> get observableLastOrder => _publishSubjectOrder.stream;
	
	// displaying the cart icon
	BehaviorSubject<bool> _isShowCartBoolValue;
	// will be used to notify the FloatingButtonIcon when changes happen in the Stream.
	Observable<bool> get showCartObservable => _isShowCartBoolValue.stream;
	
	factory GroceryShoppingCartBloc(){
		if(_groceryShoppingCartBloc == null)
			_groceryShoppingCartBloc = new GroceryShoppingCartBloc._();
		
		return _groceryShoppingCartBloc;
	}
	
	GroceryShoppingCartBloc._(){
		_currentCart = new GroceryCart();
		_publishSubjectCart = new PublishSubject<GroceryCart>();
		_publishSubjectOrder = new PublishSubject<GroceryOrder>();
		
		// displaying the cart icons
		_isShowCartBoolValue = new BehaviorSubject<bool>.seeded(false);
	}
	
	
	// toggle the states of showing cart icon using this
//	Function(bool) get toggleCartIcon => _isShowCartBoolValue.sink.add;
	// toggle the states of showing cart icon using this
	void toggleCartIcon(bool isToggle) {
		_isShowCartBoolValue.sink.add(isToggle);
	}
	
	void _updateCart() {
		_publishSubjectCart.sink.add(_currentCart);
	}
	
	void _updateLastOrder(){
		_publishSubjectOrder.sink.add(_lastOrder);
	}
	
	void addOrderToCart(GroceryProduct groceryProduct, int quantity,GroceryOrder gOrder){
		
		if(gOrder == null){
			_lastOrder = new GroceryOrder(groceryProduct, quantity, _orderId++);
			_currentCart.addOrder(_lastOrder);
		}else{
			_lastOrder = gOrder;
			// change the quantity of order
			_lastOrder.setQuantity = quantity;
			// change the orderPrice
			_currentCart.updateOrder(_lastOrder);
		}
		_updateLastOrder();
		_updateCart();
	}
	
	// removing product from cart by checking the order it belongs to
	void removeProductFromCart(GroceryProduct groceryProduct){
		// get the order number or order where this product was added to
		// you can use singleWhere or firstWhere
//		GroceryOrder gOrder = _currentCart.orders.firstWhere((order) => order.product.id ==groceryProduct.id && order.product == groceryProduct, orElse: () => null);
		GroceryOrder gOrder = _currentCart.orders.firstWhere((order) => order.product == groceryProduct, orElse: () => null);
		
		_currentCart.removeOrder(gOrder);
		_updateCart();
	}
	
	// removing product from cart by using the order it belongs to
	void removerOrderFromCart(GroceryOrder groceryOrder){
		_currentCart.removeOrder(groceryOrder);
		_updateCart();
	}
	
	void emptyCart() {
		_currentCart.clearCart();
		_lastOrder = null;
		_currentCart = new GroceryCart();
		_updateLastOrder();
		_updateCart();
	}
	
	GroceryCart get currentCart => _currentCart;
	
	GroceryOrder get lastOrder => _lastOrder;
	
	dispose(){
		_groceryShoppingCartBloc = null;
		_publishSubjectCart.close();
		_publishSubjectOrder.close();
		
		// show cart icons
		_isShowCartBoolValue.close();
//		showCartObservable.drain();
//		showCartObservable.close();
	}
}

//final cartBloc = GroceryShoppingCartBloc();