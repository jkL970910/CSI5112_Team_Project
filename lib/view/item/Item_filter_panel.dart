import 'package:flutter/material.dart';
import '../../data/item_data.dart';
import 'item_card.dart';
import 'Item_edit.dart';
import '../../components/invisible_dropdown.dart';

class ItemFilterPanel extends StatefulWidget {
  const ItemFilterPanel(
      {Key? key,
      required this.originItems,
      required this.items,
      this.onSelectFinish,
      this.onEditFinish})
      : super(key: key);

  final List<Item> items;
  final List<Item> originItems;
  final onEditFinish;
  final onSelectFinish;

  @override
  _ItemFilterPanelState createState() => _ItemFilterPanelState();
}

class _ItemFilterPanelState extends State<ItemFilterPanel> {
  bool priceAscending = true;
  bool isMarchant = false; // user_role

  @override
  void initState() {
    super.initState();
    priceAscending = true;
  }

  @override
  Widget build(BuildContext context) {
    List<Item> sortList = List.from(widget.items);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 55,
        flexibleSpace: Row(children: <Widget>[
          Expanded(
              child: Center(
            child: TextButton(
              onPressed: () => {
                setState(() {
                  priceAscending = !priceAscending;
                }),
                priceAscending
                    ? sortList.sort((a, b) =>
                        int.parse(a.price).compareTo(int.parse(b.price)))
                    : sortList.sort((a, b) =>
                        int.parse(b.price).compareTo(int.parse(a.price))),
                widget.onSelectFinish(sortList)
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Prices", style: TextStyle(color: Colors.black)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up,
                          size: 18,
                          color: priceAscending ? Colors.black : Colors.grey),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18,
                          color: priceAscending ? Colors.grey : Colors.black)
                    ],
                  )
                ],
              ),
            ),
          )),
          Expanded(
            child: Stack(
              children: [
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.location_on),
                    Text("Location")
                  ],
                )),
                InvisibleDropdown(
                    type: "location",
                    items: widget.originItems,
                    onFilterFinish: (value) => widget.onSelectFinish(value)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    Text("Filter"),
                    Icon(Icons.filter_alt)
                  ],
                )),
                InvisibleDropdown(
                    type: "type",
                    items: widget.originItems,
                    onFilterFinish: (value) => widget.onSelectFinish(value)),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: Visibility(
        visible: isMarchant,
        maintainState: false,
        child: ItemEdit(
            item: Item(), onEditFinish: widget.onEditFinish, editRole: "add"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 2,
          childAspectRatio: 2 / 3.1,
        ),
        shrinkWrap: true,
        children: buildItemList(),
      ),
    );
  }

  List<ItemCard> buildItemList() {
    return widget.items
        .map((itemsState) => ItemCard(
            item: itemsState,
            isMarchant: isMarchant,
            onEditFinish: widget.onEditFinish))
        .toList();
  }
}
