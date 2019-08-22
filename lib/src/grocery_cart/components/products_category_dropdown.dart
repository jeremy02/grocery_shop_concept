import 'package:flutter/material.dart';

class ProductsCategoryDropMenu extends StatefulWidget{
	@override
	_ProductsCategoryDropMenu createState() => _ProductsCategoryDropMenu();
}

class _ProductsCategoryDropMenu extends State<ProductsCategoryDropMenu>{
	
	String _dropdownValue = null;
	List<String> _categories = ["Pasta","Noodles","Pasta & Noodles"];
	
	@override
	Widget build(BuildContext context){
		return DropdownButtonHideUnderline(
			child: DropdownButton<String>(
				value: _dropdownValue,
				hint: Text("Select Category"),
				isExpanded:false,
				isDense: true,
				onChanged: (String newValue) {
					setState(() {
						_dropdownValue = newValue;
					});
				},
				items: _categories.map<DropdownMenuItem<String>>((String value) {
					return DropdownMenuItem<String>(
						value: value,
						child: Text(
							value,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.bold,
								fontSize: 20
							),
						),
					);
				}).toList(),
		));
	}
}