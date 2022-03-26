import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_store/detail.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';


class Tex {
  final String name;
  final int surname;
  final String img;

  String get getName => name;
  int get getSurname => surname;
  String get getImg => img;

  Tex({required this.name, required this.surname, required this.img});
}

class CounterModel extends ChangeNotifier {
  List<Tex> taskList = [];

  int _countNum = 0;
  int get countNum => _countNum;

  void increment() {
    _countNum++;
    notifyListeners();
  }

  void addCart(Tex tex) {
    taskList.add(tex);
    notifyListeners();
  }

  void removeList(int item) {
    taskList.removeAt(item);
    notifyListeners();
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

List<Tex> spiska = [
  Tex(
      name: 'iPhone 13',
      surname: 1000,
      img: 'https://phonesdata.com/files/models/Apple-iPhone-13-542.jpg'),
  Tex(
      name: 'iPhone 13 Pro Max',
      surname: 1300,
      img:
          'https://texnomart.uz/frontend/web/thumb.php?src=/frontend/web/images/gallery/product/96494/27081/detail.jpg&w=560&h=850&a=t&zc=3'),
  Tex(
      name: 'iPhone 12 Pro Max',
      surname: 1000,
      img:
          'https://olcha.uz/image/original/products/6BHH1lvPxQrLkHfoCcqhQWknKp3Cib5tDDtEbWUbChFK8Ju0L9H0urbcD6MF.jpeg'),
  Tex(
      name: 'Samsung S21 Ultra',
      surname: 1100,
      img: 'https://helpix.ru/samsung/galaxy_s21_ultra/pic/01_p00.jpg'),
  Tex(
      name: 'Mi 11 Ultra',
      surname: 900,
      img:
          'https://cdn-files.kimovil.com/default/0005/89/thumb_488011_default_big.jpeg'),
  Tex(
      name: 'Samsung S21',
      surname: 900,
      img:
          'https://avatars.mds.yandex.net/get-mpic/4380539/img_id7341649431705533527.jpeg/orig'),
];

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _counter = Provider.of<CounterModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online shop'),
        actions: [
         Consumer<CounterModel>(
           builder: (context, todo, child){
           return Padding(
             padding: const EdgeInsets.only(right: 10),
             child: IconButton(
               onPressed: () {
                 Navigator.of(context).push(
                   MaterialPageRoute(
                     builder: (context) => ChangeNotifierProvider.value(
                       value: _counter,
                       child: const AddToCart(),
                     ),
                   ),
                 );
               },
               icon: Badge(
                 badgeContent: Text(todo.taskList.length.toString()),
                 child: const Icon(Icons.shopping_cart, size: 28,),
                 ),
             ),
           );
         },
         ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
          ),
          itemCount: spiska.length,
          itemBuilder: (BuildContext context, index) {
            return Container(
              child: Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 70,
                    height: 70,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                      placeholder: (context, url) => Container(
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(),
                      ),
                      imageUrl: spiska[index].img,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              Text(spiska[index].name),
                              Text('\$${spiska[index].surname}'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<CounterModel>(context, listen: false)
                                .addCart(
                              Tex(
                                name: spiska[index].name,
                                surname: spiska[index].surname,
                                img: spiska[index].img,
                              ),
                            );
                            final snackBar = SnackBar(
                              content:
                                  Text(spiska[index].name + ' Add to my cart'),
                              backgroundColor: (Colors.black),
                              action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ),
    );
  }
}
