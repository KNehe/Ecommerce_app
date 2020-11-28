import 'package:badges/badges.dart';
import 'package:ecommerceapp/constants/screen_ids.dart';
import 'package:ecommerceapp/constants/screen_titles.dart';
import 'package:ecommerceapp/controllers/cart_controller.dart';
import 'package:ecommerceapp/controllers/category_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/screens/product_detail.dart';
import 'package:ecommerceapp/screens/shopping_cart.dart';
import 'package:ecommerceapp/skeletons/category_list_skeleton.dart';
import 'package:ecommerceapp/skeletons/product_list_skeleton.dart';
import 'package:ecommerceapp/widgets/category.dart';
import 'package:ecommerceapp/widgets/drawer.dart';
import 'package:ecommerceapp/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  ProductList({Key key}) : super(key: key);
  static String id = ProductList_Screen_Id;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var _textEditingController = TextEditingController();
  int _categorySelectedIndex;
  var _productController;
  var _cartController;
  var _categoryController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _productController = Provider.of<ProductController>(context, listen: false);
    _productController.getAllProducts(_scaffoldKey);
    _categoryController =
        Provider.of<CategoryController>(context, listen: false);
    _categoryController.getAllCategories(_scaffoldKey);
    _cartController = Provider.of<CartController>(context, listen: false);
    _cartController.getSavedCart();
    _textEditingController.addListener(_handleSearchField);
    _categorySelectedIndex = 0;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  _handleSearchField() {
    _productController.getProductByCategoryOrName(
      _textEditingController.text,
    );
    _categorySelectedIndex = null;
  }

  Future _handleRefresh() {
    _categoryController.getAllCategories(_scaffoldKey);
    _productController.getAllProducts(_scaffoldKey);
    _categorySelectedIndex = 0;
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _leftMargin = 18;
    double _rightMargin = 10;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "$ProductList_Screen_Title",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: _rightMargin),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ShoppingCart.id);
              },
              child: Badge(
                padding: EdgeInsets.all(5),
                badgeContent: Text(
                  '${context.watch<CartController>().cart.length}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  //search field
                  Container(
                    height: size.height / 15,
                    margin:
                        EdgeInsets.only(left: _leftMargin, right: _rightMargin),
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
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),

            // Horizontal list of categories
            Container(
                height: 50,
                margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                child: Consumer<CategoryController>(
                    builder: (context, cateogoryCtlr, child) {
                  if (cateogoryCtlr.isLoadingCategories)
                    return Shimmer.fromColors(
                      child: CategoryListSkeleton(),
                      baseColor: Colors.grey[200],
                      highlightColor: Colors.grey[400],
                    );

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cateogoryCtlr.categoryList.length,
                      itemBuilder: (context, index) {
                        return Category(
                          category: cateogoryCtlr.categoryList[index].category,
                          categoryIndex: index,
                          categorySelectedIndex: _categorySelectedIndex,
                          onTapped: () {
                            setState(() {
                              _categorySelectedIndex = index;
                            });
                            _productController.getProductByCategory(
                                cateogoryCtlr.categoryList[index].category,
                                _scaffoldKey);
                          },
                        );
                      });
                })),
            SizedBox(
              height: 30,
            ),

            // List of products
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                child: Consumer<ProductController>(
                    builder: (context, productCtlr, child) {
                  if (productCtlr.isLoadingAllProducts)
                    return Center(
                      child: Shimmer.fromColors(
                        child: ProductListSkeleton(),
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[400],
                      ),
                    );
                  if (!productCtlr.isLoadingAllProducts &&
                      productCtlr.productList.length == 0)
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
                    itemCount: productCtlr.productList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: productCtlr.productList[index],
                        onProductTapped: () {
                          _cartController.setCurrentItem(
                              productCtlr.productList[index].id, _scaffoldKey);
                          Navigator.pushNamed(context, ProductDetail.id);
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
      drawer: CDrawer(),
    );
  }
}
