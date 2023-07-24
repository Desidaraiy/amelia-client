import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/controllers/product_controller.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../elements/ProductsCarouselItemWidget.dart';
import '../elements/ProductsCarouselLoaderWidget.dart';
import '../models/Product.dart';
import 'ProductListItemWidget.dart';

class ProductListWidget extends StatefulWidget {
  final List<Product> productsList;
  final String heroTag;
  ProductListWidget({Key key, this.heroTag, this.productsList})
      : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends StateMVC<ProductListWidget> {
  ProductController _con;

  _ProductListWidgetState() : super(ProductController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: widget.productsList.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Product',
                        arguments: RouteArgument(
                            id: widget.productsList[index].id,
                            heroTag: widget.heroTag));
                  },
                  child: ProductListItemWidget(
                    image_width: 188,
                    image_height: 100,
                    info_height: 105,
                    info_width: 188,
                    product_name: widget.productsList[index].name,
                    product_category:
                        widget.productsList[index].category.name ??
                            widget.productsList[index].catname,
                    new_product: false,
                    review: false,
                    buttonText: false,
                    icon: Icon(Icons.add),
                    horizontal: false,
                    heroTag: widget.heroTag,
                    product: widget.productsList[index],
                    onPressed: () {},
                    // isFavorite:
                    //     _con.isInFavorite(widget.productsList[index].id),
                    // isInCart: _con.isInCart(widget.productsList[index].id),
                    handleFavorites: (p, fav) {
                      if (fav) {
                        _con.addToFavorite(p);
                      } else {
                        _con.removeFromFavorite(p.id);
                      }
                    },
                    handleCart: (p) {
                      // print('adding to cart id ${p.id}');
                      _con.addToCart(p);
                    },
                  ),
                ));
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
