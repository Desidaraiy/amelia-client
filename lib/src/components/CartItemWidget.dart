import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AddRemoveWidget.dart';
import 'package:markets/src/components/CounterWidget.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/Product.dart';
import 'package:markets/src/models/cart.dart';
import 'package:markets/src/repository/product_repository.dart' as repo;
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class CartItem extends StatefulWidget {
  const CartItem(
      {Key key,
      // this.topLeft,
      // this.topRight,
      // this.bottomLeft,
      // this.bottomRight,
      // this.title,
      // this.category,
      this.sale,
      this.price,
      // this.newPrice,
      // this.cardHeight,
      // this.imgSize,
      this.new_product,
      this.shade,
      this.itemShade,
      this.itemStroke,
      this.counter,
      this.productId,
      this.product,
      this.cart,
      this.handleCounter,
      this.handleDeletion,
      // this.selected,
      this.onChangeSelection,
      // this.cartController,
      this.in_stock})
      : super(key: key);
  final double topLeft = 0.0;
  final double topRight = 0.0;
  final double bottomLeft = 5.0;
  final double bottomRight = 5.0;
  // final String title;
  // final String category;
  final bool sale;
  final bool new_product;
  final String price;
  // final String newPrice;
  final double cardHeight = 62;
  final double imgSize = 50;
  final bool shade;
  final Color itemShade;
  final Color itemStroke;
  final int counter;
  final bool in_stock;
  final String productId;
  final Product product;
  final Cart cart;
  final bool selected = false;
  // final CartController cartController;
  final Function(int) handleCounter;
  final Function(Cart) handleDeletion;
  final Function(bool) onChangeSelection;
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends StateMVC<CartItem> {
  bool isSelected;
  int _quantity;
  int _price;
  int _sum;

  CartController _con;

  _CartItemState() : super(CartController()) {
    _con = controller;
  }

  Future<bool> _localFav;
  bool _localFavBool;

  void initFav() async {
    // _localFavBool = await _con.isInFavorite(widget.product.id);
    _localFav = _con.isInFavorite(widget.product.id);
  }

  void handleNewCartQuantity(counter) {
    setState(() {
      _sum = _price * counter;
      _quantity = counter;
      widget.handleCounter(counter);
    });
  }

  @override
  void didChangeDependencies() {
    initFav();
    setState(() {
      isSelected = widget.selected;
      _quantity = widget.cart.quantity.toInt();
      _price = widget.product.price.toInt();
      _sum = _quantity * _price;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return
        // FutureBuilder(
        //     future: repo.getProductById(widget.productId),
        //     builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('Error: ${snapshot.error}'),
        //         );
        //       } else if (!snapshot.hasData) {
        //         return Center(
        //           child: Text('No data found'),
        //         );
        //       } else {
        //         final _product = snapshot.data;
        //         return
        Row(
      children: [
        Container(
          height: 116,
          decoration: BoxDecoration(
            color: primary_50,
            // borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          child: Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.topStart,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                      widget.onChangeSelection(isSelected);
                    });
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.topLeft),
                          bottomLeft: Radius.circular(widget.bottomLeft)),
                      child: CachedNetworkImage(
                          height: 116,
                          width: 116,
                          fit: BoxFit.cover,
                          imageUrl: widget.product.image.url)),
                  // imageUrl:
                  //     "https://sun9-57.userapi.com/impg/4bQlcatv9WLaW08DQ-2tx9rKsbOi3mQzpYZtxA/KcErEhme7F0.jpg?size=721x1080&quality=95&sign=1c1477edebf44263a30222a5e6e25bea&type=album")),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.new_product == true
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: expanded_green_dimmed_400,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                child: Text(
                                  'новинка',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ))
                        : SizedBox(),
                    widget.sale == true
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: expanded_red_550,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                child: Text(
                                  '-20%',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ))
                        : SizedBox(),
                  ],
                ),
                isSelected
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                            widget.onChangeSelection(isSelected);
                          });
                        },
                        child: Container(
                          color: Color.fromRGBO(153, 181, 203, 0.45),
                          height: 116,
                          width: 116,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              'assets/icons/done_500_48.svg',
                              color: primary_50),
                        ),
                      )
                    : SizedBox(),
              ]),
        ),
        Expanded(
          child: Container(
            height: 116,
            decoration: BoxDecoration(
                color: primary_50,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.topRight),
                    bottomRight: Radius.circular(widget.bottomRight))),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      // widget.title,
                                      widget.product.name.toString(),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      widget.product.category.name.toString(),
                                      style:
                                          Theme.of(context).textTheme.overline,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/icons/close_24.svg',
                                    color: neutral_150),
                                onTap: () {
                                  widget.handleDeletion(widget.cart);
                                },
                              )
                            ],
                          ),
                          widget.shade == true
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: widget.itemShade,
                                          border: Border.all(
                                              color: widget.itemStroke,
                                              width: 0.5)),
                                    ),
                                  ],
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.product.price.toInt()}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text(
                                      '₽',
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          .merge(TextStyle(color: primary_700)),
                                    ),
                                  ],
                                ),
                                widget.sale == true
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            widget.price,
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline
                                                .merge(TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          // InkWell(
                          //   child: Container(
                          //     padding: EdgeInsets.all(6),
                          //     child: FutureBuilder<bool>(
                          //       future: _localFav,
                          //       builder: (BuildContext context,
                          //           AsyncSnapshot<bool> snapshot) {
                          //         if (snapshot.hasData) {
                          //           return SvgPicture.asset(
                          //             snapshot.data
                          //                 ? 'assets/icons/favorite_filled_true.svg'
                          //                 : 'assets/icons/favorite_filled_false.svg',
                          //             color: expanded_red_450,
                          //           );
                          //         } else if (snapshot.hasError) {
                          //           return SvgPicture.asset(
                          //             'assets/icons/favorite_filled_false.svg',
                          //             color: neutral_500,
                          //           );
                          //         } else {
                          //           return CircularProgressIndicator();
                          //         }
                          //       },
                          //     ),
                          //   ),
                          //   onTap: () {},
                          // ),
                          // SizedBox(
                          //   width: 6,
                          // ),
                          widget.in_stock
                              ? Counter(
                                  counter: _quantity,
                                  handleCounter: (counter) {
                                    handleNewCartQuantity(counter);
                                  },
                                )
                              : Text(
                                  S.of(context).out_of_stock,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .merge(TextStyle(color: neutral_400)),
                                )
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //         padding: EdgeInsets.all(6),
                          //         child: SvgPicture.asset(
                          //           'assets/icons/favorite_filled_false.svg',
                          //           color: expanded_red_450,
                          //         )),
                          //     PrimaryButton(
                          //       text: 'В корзину',
                          //       small: true,
                          //       onPressed: () {},
                          //       left_padding: 8,
                          //       right_padding: 8,
                          //       top_padding: 8,
                          //       bottom_padding: 8,
                          //       border_radius: 3,
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
    //   }
    // });
  }
}
