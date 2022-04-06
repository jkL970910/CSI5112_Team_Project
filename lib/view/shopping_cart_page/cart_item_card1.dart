import 'dart:convert';

import 'package:csi5112_project/data/cart_item_data.dart';
import 'package:csi5112_project/data/cart_product.dart';
import 'package:csi5112_project/data/http_data.dart';
import 'package:csi5112_project/data/user_data.dart';
import 'package:csi5112_project/presenter/cart_item_presenter.dart';
import 'package:csi5112_project/view/shopping_cart_page/cart_box.dart';
import 'package:flutter/material.dart';

class CartItemCard1 extends StatefulWidget {
  const CartItemCard1(
      {Key? key,
      required this.user,
      required this.refresh,
      required this.cartProduct,
      this.updatePrice,
      required this.amountPrice,
      required this.isClickedAll,
      required this.amountPriceAdd})
      : super(key: key);

  final CartProduct cartProduct;
  final User user;
  final refresh;
  final updatePrice;
  final int amountPrice;
  final bool isClickedAll;
  final int amountPriceAdd;

  @override
  _CartCardState1 createState() => _CartCardState1();
}

class _CartCardState1 extends State<CartItemCard1>
    implements CartItemsListViewContract {
  late CartItemsListPresenter _presenter;
  var retry = false;
  final itemFormKey = GlobalKey<FormState>();
  bool isClicked = false;
  bool isClickedMinus = false;
  bool isClickAdd = false;
  int value = 1;

  _CartCardState1() {
    _presenter = CartItemsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    value = widget.cartProduct.quantity;
    // _presenter.loadProducts(HttpRequest('Get', 'Products?product_id=${widget.cartProduct.product_id}', {}));
  }

  updateCartItem(int? quantity) {
    CartItem cartItem = CartItem();
    cartItem.item_id = widget.cartProduct.item_id;
    cartItem.quantity = quantity!;
    cartItem.customer_id = widget.user.customer_id;
    cartItem.price = widget.cartProduct.price;
    cartItem.product_id = widget.cartProduct.product_id;
    _presenter.loadItems(HttpRequest(
        'Put',
        'CartItems/update?item_id=${widget.cartProduct.item_id}',
        jsonEncode(cartItem)));
    retry = true;
    // print("fuck");
  }

  // void updateNum(int value) {
  //   setState(() {
  //     selectedValue = value;
  //   });
  // }

  int CompareWithZero(int value) {
    if (value > 0) {
      return value;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: IconButton(
                color: isClicked
                    ? Colors.green
                    : const Color.fromRGBO(200, 200, 200, 1),
                icon: const Icon(Icons.check_circle_outline),
                onPressed: () {
                  setState(() {
                    isClicked = !isClicked;
                    int res = isClicked
                        ? widget.cartProduct.price * value
                        : -(widget.cartProduct.price * value);
                    widget.updatePrice(res);
                  });
                },
              ),
            ),
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                widget.cartProduct.image,
                // height: 30,
                // fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.cartProduct.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 2.0)),
                            Text(
                              widget.cartProduct.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "price: \$" +
                                  widget.cartProduct.price.toString() +
                                  "    " +
                                  "tax: \$" +
                                  (widget.cartProduct.price * 0.13).toString(),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "stored in " + widget.cartProduct.manufacturer,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.2,
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue[600],
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      color: const Color.fromRGBO(200, 200, 200, 1),
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          isClickedMinus = !isClickedMinus;
                          value = CompareWithZero(value - 1);
                        });
                        updateCartItem(value);
                      },
                    ),
                    Text(value.toString()),
                    IconButton(
                      color: const Color.fromRGBO(200, 200, 200, 1),
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          isClickAdd = !isClickAdd;
                          value = CompareWithZero(value + 1);
                        });
                        updateCartItem(value);
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  @override
  void onLoadCartItemsComplete(List<CartItem> items) {
    widget.refresh();
    print("fresh");
  }

  @override
  void onLoadCartItemsError(onError) {
    print(onError);
  }
}