import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String category;
  final int categoryIndex;
  final int categorySelectedIndex;
  final Function onTapped;
  Category({
    @required this.category,
    @required this.categorySelectedIndex,
    @required this.categoryIndex,
    @required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: categoryIndex == categorySelectedIndex
                ? Colors.grey[700]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '$category',
                style: TextStyle(
                  color: categoryIndex == categorySelectedIndex
                      ? Colors.white
                      : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
