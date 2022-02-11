import 'package:csi5112_project/data/item_data.dart';
import 'package:csi5112_project/presenter/item_presenter_cart.dart';
import 'package:csi5112_project/view/item_detail_page/payment_success_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CartList(),
    );
  }
}

class CartBottomBar extends StatefulWidget {
  const CartBottomBar(
      {Key? key,
      required this.amountPrice,
      required this.isClickedAll,
      this.updateIsClickAll})
      : super(key: key);

  final int amountPrice;
  final bool isClickedAll;
  final updateIsClickAll;
  @override
  _CartBottomBarState createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Positioned(
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                  widget.updateIsClickAll(isClicked);
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: isClicked
                    ? Colors.green
                    : const Color.fromRGBO(200, 200, 200, 1),
              ),
              label: const Text("Select all"),
            ),
            Text('Total:  \$' + widget.amountPrice.toString() + '  '),
            Text('Tax:  \$' +
                (widget.amountPrice * 0.13).toString() +
                '           '),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const PaymentPage();
                  }),
                );
              },
              child: const Text('Place the order'),
            )
          ],
        ),
      ),
      left: 10,
      bottom: 7,
    );
  }
}

class CardBox extends StatefulWidget {
  const CardBox({Key? key, required this.selectedValue, this.updateNum})
      : super(key: key);

  final int selectedValue;
  final updateNum;
  @override
  _CartCardBoxState createState() => _CartCardBoxState();
}

class _CartCardBoxState extends State<CardBox> {
  final itemFormKey = GlobalKey<FormState>();
  var value = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DropdownButton<int>(
          // 弹框列表
          items: const [
            DropdownMenuItem(
              child: Text("×1"),
              value: 1,
              // onTap: () {
              //   value = 1;
              // },
            ),
            DropdownMenuItem(
              child: Text("×2"),
              value: 2,
              // onTap: () {
              //   value = 2;
              // },
            ),
            DropdownMenuItem(
              child: Text("×3"),
              value: 3,
              // onTap: () {
              //   value = 3;
              // },
            ),
            DropdownMenuItem(
              child: Text("×4"),
              value: 4,
              // onTap: () {
              //   value = 4;

              // },
            ),
            DropdownMenuItem(
              child: Text("×5"),
              value: 5,
              // onTap: () {
              //   value = 5;
              // },
            )
          ],

          hint: const Text("num"), // 下拉按钮的文字
          style: const TextStyle(fontSize: 15, color: Colors.green), // 按钮文字样式
          underline: const Divider(
            height: 1,
            color: Colors.blue,
          ), // 按钮底部的横线

          value: value, // 按钮默认显示弹框列表的哪个 item，和 DropdownMenuItem 的 value 相对应

          // 选了某个选项时触发
          onChanged: (int? newValue) {
            setState(() {
              value = newValue!;
              widget.updateNum(value);
            });
          },

          onTap: () {},
        ),
      ],
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard(
      {Key? key,
      required this.item,
      this.updatePrice,
      required this.amountPrice,
      required this.isClickedAll})
      : super(key: key);

  final Item item;
  final updatePrice;
  final int amountPrice;
  final bool isClickedAll;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<ItemCard> {
  final itemFormKey = GlobalKey<FormState>();
  bool isClicked = false;
  int selectedValue = 1;

  void updateNum(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    isClicked = widget.isClickedAll;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          CardBox(
            selectedValue: selectedValue,
            updateNum: updateNum,
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              widget.item.image,
              height: 30,
              // fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: IconButton(
              color: isClicked
                  ? Colors.green
                  : const Color.fromRGBO(200, 200, 200, 1),
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                  int res = isClicked
                      ? widget.amountPrice +
                          int.parse(widget.item.price) * selectedValue
                      : widget.amountPrice -
                          int.parse(widget.item.price) * selectedValue;
                  widget.updatePrice(res);
                });
              },
            ),
            title: Text(widget.item.name,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
            subtitle: Text(widget.item.description,
                style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
            trailing: Column(children: <Widget>[
              Text(
                  "price: \$" +
                      widget.item.price +
                      "    " +
                      "tax: \$" +
                      (double.parse(widget.item.price) * 0.13).toString(),
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
            ]),
          )
        ],
      ),
    );
  }
}

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);
  @override
  CartListState createState() => CartListState();
}

class CartListState extends State<CartList>
    implements ItemsListViewContractCart {
  late ItemsListPresenterCart _presenter;
  List<Item> itemsCart = [];
  int amountPrice = 0;
  bool isSearching = false;
  bool isClicked = false;
  bool isClickedAll = false;
  CartListState() {
    _presenter = ItemsListPresenterCart(this);
  }

  List<Widget> _getListItems() {
    var items = itemsCart.map((value) {
      return ItemCard(
          item: value,
          updatePrice: updatePrice,
          amountPrice: amountPrice,
          isClickedAll: isClickedAll);
    });
    return items.toList();
  }

  @override
  void initState() {
    super.initState();
    isSearching = true;
    isClicked = false;
    _presenter.loadItems();
  }

  void updatePrice(int value) {
    setState(() {
      amountPrice = value;
    });
  }

  void updateIsClickAll(bool value) {
    setState(() {
      isClickedAll = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        ListView(
          children: _getListItems(),
        ),
        CartBottomBar(
            amountPrice: amountPrice,
            isClickedAll: isClickedAll,
            updateIsClickAll: updateIsClickAll),
      ],
    );
  }

  @override
  void onLoadItemsComplete(List<Item> items) {
    setState(() {
      itemsCart = items;
      isSearching = false;
    });
    // TODO: implement onLoadItemsComplete
  }

  @override
  void onLoadItemsError() {
    // TODO: implement onLoadItemsError
  }
}
