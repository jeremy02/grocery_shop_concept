import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';
import 'package:grocery_shop/src/grocery_cart/resources/grocery_products_repository.dart';
import 'package:rxdart/rxdart.dart';

class GroceryProductsBloc{
	
	final _productsRepository = new GroceryProductsRepository();
	
	static GroceryProductsBloc _groceryProductsBloc;
	
	// get the list of all products
	PublishSubject<List<GroceryProduct>> _publishSubjectProducts;
	Observable<List<GroceryProduct>> get observableProductsList => _publishSubjectProducts.stream;
	
	factory GroceryProductsBloc(){
		if(_groceryProductsBloc == null)
			_groceryProductsBloc = new GroceryProductsBloc._();
		
		return _groceryProductsBloc;
	}
	
	GroceryProductsBloc._(){
		// get the list of all products
		_publishSubjectProducts = new PublishSubject<List<GroceryProduct>>();
	}
	
	// get the list of all products
	fetchAllProducts() async{
		List<GroceryProduct> _products = await _productsRepository.fetchAllProducts();
		_publishSubjectProducts.sink.add(_products);
	}
	
	dispose(){
		_publishSubjectProducts.close();
	}
}

final productsBloc = GroceryProductsBloc();