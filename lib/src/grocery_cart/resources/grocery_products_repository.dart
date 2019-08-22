
import 'package:grocery_shop/src/grocery_cart/models/grocery_product.dart';

class GroceryProductsRepository{
	
	List<GroceryProduct>  fetchAllProducts() {
		return [
			new GroceryProduct("assets/images/spelt_noodles.png", "Biona Organic Spelt Noodles", 2.99, 250, 0),
			new GroceryProduct("assets/images/spelt_italian.png", "Biona Organic Spelt Fusili Brown", 2.35, 500, 1),
			new GroceryProduct("assets/images/spelt_spaghetti.png", "Biona Organic Whole Spelt Spaghetti", 2.35, 500, 2),
			new GroceryProduct("assets/images/spelt_tagliatelle.png", "Biona Organic Spelt Spinach Artisan Tagliatelle", 1.99, 250, 3),
			new GroceryProduct("assets/images/spelt_penne.png", "Biona Organic Whole Spelt Penne", 2.35, 500, 4),
			new GroceryProduct("assets/images/spelt_tagliatelle.png", "Biona Organic Spelt Spinach Artisan Tagliatelle", 1.99, 250, 5),
			new GroceryProduct("assets/images/spelt_fusilli.png", "Biona Organic Spelt Fusilli Tricolore", 1.99, 250, 6),
		];
	}
}