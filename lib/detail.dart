import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_home.dart';


class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
    // ignore: unused_local_variable
    final _counter = Provider.of<CounterModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<CounterModel>(
        builder: (context, todo, child) {
          // ignore: unrelated_type_equality_checks
          return todo.taskList.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'number of products: ' +
                                todo.taskList.length.toString(),
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    // ignore: sized_box_for_whitespace
                    const SizedBox(height: 10,),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: 600,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                              ),
                          itemExtent: 80,
                          itemCount: todo.taskList.length,
                          // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
                          itemBuilder: (BuildContext, index) {
                            // ignore: unused_local_variable
                            return Card(
                              color: Colors.grey[300],
                              child: ListTile(
                                  onTap: () {},
                                  leading: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                                    placeholder: (context, url) => Container(
                                      width: 20,
                                      height: 20,
                                      child: const CircularProgressIndicator(),
                                    ),
                                    imageUrl: spiska[index].img,
                                  ),
                                  title: Text(todo.taskList[index].name),
                                  subtitle:
                                      Text('\$${todo.taskList[index].surname}', style: const TextStyle(color: Colors.black),),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Provider.of<CounterModel>(context,
                                              listen: false)
                                          .removeList(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )),
                            );
                          }),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    'isEmpty',
                    style: TextStyle(fontSize: 35),
                  ),
                );
        },
      ),
    );
  }
}
