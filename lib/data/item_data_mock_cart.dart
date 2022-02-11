import 'dart:async';
import 'item_data.dart';

class MockItemRepositoryCart implements ItemRepository {
  @override
  Future<List<Item>> fetch() => Future.value(kContacts);
}

var kContacts = <Item>[
  Item(
    id: '1234',
    name: 'Alienware',
    type: 'Computer',
    price: "1000",
    orderId: "0",
    date: "2022.01.01",
    image:
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Dell Computer",
    location: 'LA',
    chat: <Chat>[
      Chat(
          name: "Jack",
          date: "01/02/2021",
          comment: "Is this laptop suitable for students?"),
      Chat(
          name: "Tom",
          date: "03/02/2021",
          comment: "I use it in university, I think it's good"),
      Chat(
          name: "Alice",
          date: "05/02/2021",
          comment: "My son is satisfied with it"),
    ],
  ),
  Item(
    id: '2234',
    name: 'Macbook',
    type: 'Computer',
    price: "2000",
    orderId: "0",
    date: "2022.01.01",
    image:
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Apple Computer",
    location: 'NYU',
    chat: <Chat>[
      Chat(
          name: "Jack",
          date: "01/02/2021",
          comment: "Is this laptop suitable for students?"),
      Chat(
          name: "Tom",
          date: "03/02/2021",
          comment: "I use it in university, I think it's good"),
      Chat(
          name: "Alice",
          date: "05/02/2021",
          comment: "My son is satisfied with it"),
    ],
  ),
  Item(
    id: '3234',
    name: 'Iphone',
    type: 'Phone',
    price: "300",
    orderId: "0",
    date: "2022.01.01",
    image:
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Apple Phone",
    location: 'LA',
    chat: <Chat>[
      Chat(
          name: "Jack",
          date: "01/02/2021",
          comment: "Is this laptop suitable for students?"),
      Chat(
          name: "Tom",
          date: "03/02/2021",
          comment: "I use it in university, I think it's good"),
      Chat(
          name: "Alice",
          date: "05/02/2021",
          comment: "My son is satisfied with it"),
    ],
  ),
  Item(
    id: '4234',
    name: 'Galaxy S22',
    type: 'Phone',
    price: "400",
    orderId: "0",
    date: "2022.01.01",
    image:
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    description: "A Great Samsung Computer",
    location: 'WU',
    chat: <Chat>[
      Chat(
          name: "Jack",
          date: "01/02/2021",
          comment: "Is this laptop suitable for students?"),
      Chat(
          name: "Tom",
          date: "03/02/2021",
          comment: "I use it in university, I think it's good"),
      Chat(
          name: "Alice",
          date: "05/02/2021",
          comment: "My son is satisfied with it"),
    ],
  )
];
