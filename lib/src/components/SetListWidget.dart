import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/models/route_argument.dart';

import '../elements/ProductsCarouselItemWidget.dart';
import '../elements/ProductsCarouselLoaderWidget.dart';
import '../models/Product.dart';
import 'ProductListItemWidget.dart';

class SetListWidget extends StatelessWidget {
  final List<Product> productsList;
  final String heroTag;
  SetListWidget({Key key, this.heroTag, this.productsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productsList.isEmpty
        ? ProductsCarouselLoaderWidget()
        : Container(
            height: 230,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return Container(
                    margin:
                        EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Product',
                            arguments: RouteArgument(
                                id: productsList[index].id, heroTag: heroTag));
                      },
                      child: ProductListItemWidget(
                          image_width: 188,
                          image_height: 100,
                          info_height: 105,
                          info_width: 188,
                          product_name: productsList[index].name,
                          product_category:
                              productsList[index].category.name.toString(),
                          new_product: false,
                          review: false,
                          buttonText: false,
                          icon: Icon(Icons.add),
                          horizontal: false,
                          heroTag: heroTag,
                          product: productsList[index],
                          onPressed: () {}),
                    ));
              },
              scrollDirection: Axis.horizontal,
            ));
  }
}
