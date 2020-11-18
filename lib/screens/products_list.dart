import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/screens/product_detail.dart';
import 'package:ecommerceapp/skeletons/category_list_skeleton.dart';
import 'package:ecommerceapp/skeletons/product_list_skeleton.dart';
import 'package:ecommerceapp/widgets/category.dart';
import 'package:ecommerceapp/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var _textEditingController = TextEditingController();
  var _productController = Get.put(ProductController());
  var _categoryController = Get.put(CategoryController());

  int _categorySelectedIndex;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_handleSearchField);
    _categorySelectedIndex = 0;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _handleSearchField() {
    _productController.getProductByCategoryOrName(_textEditingController.text);
    _categorySelectedIndex = null;
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
              child: Obx(() {
                if (_categoryController.isLoadingCategories.value)
                  return Shimmer.fromColors(
                    child: CategoryListSkeleton(),
                    baseColor: Colors.grey[200],
                    highlightColor: Colors.grey[400],
                  );

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryController.categoryList.length,
                    itemBuilder: (context, index) {
                      return Category(
                        category:
                            _categoryController.categoryList[index].category,
                        categoryIndex: index,
                        categorySelectedIndex: _categorySelectedIndex,
                        onTapped: () {
                          setState(() {
                            _categorySelectedIndex = index;
                          });
                          _productController.getProductByCategory(
                              _categoryController.categoryList[index].category);
                        },
                      );
                    });
              }),
            ),

            SizedBox(
              height: 30,
            ),

            // List of products
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                child: Obx(() {
                  if (_productController.isLoadingAllProducts.value)
                    return Center(
                      child: Shimmer.fromColors(
                        child: ProductListSkeleton(),
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[400],
                      ),
                    );
                  if (!_productController.isLoadingAllProducts.value &&
                      _productController.productList.length == 0)
                    return Center(
                      child: Text(
                        'Results not found ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    );

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: _productController.productList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: _productController.productList[index],
                        onProductTapped: () {
                          _productController.selectedProduct.value =
                              _productController.productList[index];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(),
                            ),
                          );
                        },
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
