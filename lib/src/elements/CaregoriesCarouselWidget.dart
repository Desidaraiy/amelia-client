import 'package:flutter/material.dart';
import 'package:markets/src/components/CategoryWidget.dart';

import '../elements/CategoriesCarouselItemWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/category.dart';

// ignore: must_be_immutable
class CategoriesCarouselWidget extends StatelessWidget {
  List<Category> categories;

  CategoriesCarouselWidget({Key key, this.categories}) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return this.categories.isEmpty
  //       ? CircularLoadingWidget(height: 150)
  //       : Container(
  //           height: 150,
  //           padding: EdgeInsets.symmetric(vertical: 10),
  //           child: ListView.builder(
  //             itemCount: this.categories.length,
  //             scrollDirection: Axis.horizontal,
  //             itemBuilder: (context, index) {
  //               double _marginLeft = 0;
  //               (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
  //               return new CategoriesCarouselItemWidget(
  //                 marginLeft: _marginLeft,
  //                 category: this.categories.elementAt(index),
  //               );
  //             },
  //           ));
  // }
  Widget build(BuildContext context) {
    return this.categories.isEmpty
        ? CircularLoadingWidget(height: 100)
        : Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListView.builder(
              itemCount: this.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // double _marginLeft = 0;
                // (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                // return new CategoriesCarouselItemWidget(
                //   marginLeft: _marginLeft,
                //   category: this.categories.elementAt(index),
                // );
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: CustomCategory(
                    price: "",
                    enableBorder: false,
                    free: false,
                    title: this.categories[index].name,
                    categoryPhoto:
                        // Image(image: AssetImage('assets/icons/product.png')),
                        Image(
                            image:
                                NetworkImage(this.categories[index].image.url)),
                    category: this.categories[index],
                  ),
                );
              },
            ));
  }
}
