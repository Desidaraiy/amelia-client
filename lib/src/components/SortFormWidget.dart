import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class SortFormWidget extends StatefulWidget {
  const SortFormWidget({Key key}) : super(key: key);

  @override
  State<SortFormWidget> createState() => _SortFormWidgetState();
}

enum ProductSorting {
  popular,
  newProducts,
  offPercent,
  rating,
  expensive,
  cheaper
}

const sortOptions = {
  ProductSorting.popular: "Популярное",
  ProductSorting.newProducts: "Новинки",
  ProductSorting.offPercent: "Размер скидки",
  ProductSorting.rating: "Высокий рейтинг",
  ProductSorting.expensive: "Сначала дешевле",
  ProductSorting.cheaper: "Сначала дороже"
};

// extension CatExtension on Cat {
//
//   static const names = {
//     Cat.black: 'Black Cat',
//     Cat.white: 'White Cat',
//     Cat.grey: 'Grey Cat',
//   };
//
//   String? get name => names[this];
//
// }

class _SortFormWidgetState extends State<SortFormWidget> {
  int selectedSorting;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 315,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView.builder(
          itemCount: sortOptions.values.length,
          // scrollDirection: Axis.vertical,
          itemBuilder: (context, int index) {
            ProductSorting key = sortOptions.keys.elementAt(index);
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedSorting = index;
                      print(ProductSorting.values[index]);
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(sortOptions[key], style: Theme.of(context).textTheme.bodyText2,)),
                      Container(
                        width: 44,
                        height: 44,
                        child: selectedSorting == index
                            ? SvgPicture.asset(
                                'assets/icons/radio_button_checked.svg',
                                color: neutral_500,
                                width: 24,
                                height: 24,
                                fit: BoxFit.scaleDown,
                              )
                            : SvgPicture.asset(
                                'assets/icons/radio_button_unchecked.svg',
                                color: neutral_500,
                                width: 24,
                                height: 24,
                                fit: BoxFit.scaleDown,
                              ),
                      ),
                    ],
                  ),
                ),
                index == sortOptions.values.length
                    ? SizedBox()
                    : SizedBox(
                        height: 8,
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
