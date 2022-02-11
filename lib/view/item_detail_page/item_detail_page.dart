import 'package:flutter/material.dart';
import '../item_cart_page/item_cart_page.dart';
import 'payment_success_page.dart';
import 'product_description.dart';
import 'product_img.dart';
import '../../data/item_data.dart';
import '../item_chat_page/item_chat_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.item,
    this.onEditFinish,
  }) : super(key: key);

  final Item item;
  final onEditFinish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.type + " Store")),
      body: ListView(children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        ProductImg(item: item),
        ProductDescription(item: item),
        const Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Material(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'place the order',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const PaymentPage();
                      }),
                    );
                  },
                ),
              ),
            )),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
            width: 30,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Material(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
                elevation: 6,
                child: MaterialButton(
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const CartPage();
                      }),
                    );
                  },
                ),
              ),
            )),
        const Padding(padding: EdgeInsets.only(top: 30)),
        ItemChatPage(item: item, onEditFinish: onEditFinish)
      ]),
    );
  }
}
