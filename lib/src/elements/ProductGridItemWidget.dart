import 'package:flutter/material.dart';
import 'package:markets/src/helpers/helper.dart';

import '../models/Product.dart';
import '../models/route_argument.dart';

class ProductGridItemWidget extends StatefulWidget {
  final String heroTag;
  final Product product;
  final VoidCallback onPressed;

  ProductGridItemWidget({Key key, this.heroTag, this.product, this.onPressed})
      : super(key: key);

  @override
  _ProductGridItemWidgetState createState() => _ProductGridItemWidgetState();
}

class _ProductGridItemWidgetState extends State<ProductGridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(
                heroTag: this.widget.heroTag, id: this.widget.product.id));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Expanded(
                child: Hero(
                  tag: widget.heroTag + widget.product.id,
                  child: Container(

                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(this.widget.product.image.thumb),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),

                    ),
                  ),
                ),
              ),

              Text(
                widget.product.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),

              Text(
                widget.product.market.name,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5,),
              Helper.getPrice(widget.product.price, context,
                  style: Theme.of(context).textTheme.headline3),

            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: MaterialButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              onPressed: () {
                widget.onPressed();
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              color: Theme.of(context).accentColor.withOpacity(0.9),
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
