import 'package:ecommerceapp/screens/product_detail.dart';
import 'package:ecommerceapp/widgets/category.dart';
import 'package:ecommerceapp/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController _textEditingController;
  //dummy data
  List<String> _categories = [
    "All",
    "Phones",
    "Laptops",
    "Food",
    "Clothes",
    "Shoes shoes",
    "Beds beds beds"
  ];

  List<String> _products = [
    "Fish",
    "Cake",
    "Fish",
    "Cake",
    "Fish",
    "Cake",
    "Fish",
    "Cake"
  ];

  int _categorySelectedIndex;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _categorySelectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 18;
    double _rightMargin = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Store",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
              onPressed: () {})
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            //search field
            Container(
              height: size.height / 15,
              margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: TextField(
                controller: _textEditingController,
                onChanged: (String value) {},
                decoration: InputDecoration(
                  hintText: "Search by product name or category",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[300],
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //title
            Container(
              margin: EdgeInsets.only(left: _leftMargin),
              child: Text(
                "Get The Best Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // Horizontal list of categories
            Container(
              height: 50,
              margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return Category(
                      category: _categories[index],
                      categoryIndex: index,
                      categorySelectedIndex: _categorySelectedIndex,
                      onTapped: () {
                        setState(() {
                          _categorySelectedIndex = index;
                        });
                      },
                    );
                  }),
            ),

            SizedBox(
              height: 30,
            ),

            // List of products
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return Product(
                        productName: _products[index],
                        productPrice: '\$100',
                        productImage: index % 2 == 0
                            ? Image.asset("assets/images/fish.jpg")
                            : Image.asset("assets/images/cake.jpg"),
                        onProductTapped: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),

            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
