import 'package:beauty_habit_tracker/products/add_product_page.dart';
import 'package:beauty_habit_tracker/products/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostLoginHome extends StatefulWidget {
  const PostLoginHome({super.key});

  @override
  State<PostLoginHome> createState() => _PostLoginHomeState();
}

enum Status { opened, sealed, all }

class _PostLoginHomeState extends State<PostLoginHome> {
  String _userName = '';
  Status? _productStatus;
  String _statusToQuery = 'All';

  @override
  void initState() {
    super.initState();
    getUserName();
    _productStatus = Status.all;
    _statusToQuery = 'All';
  }

  Future getUserName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((userData) {
      setState(() {
        _userName = userData.data()!['firstName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        child: Column(children: [
          const SizedBox(height: 15),
          Text("Hello! $_userName",
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 2.0)),
          const SizedBox(height: 20),
          Container(
              height: 50,
              child: Center(
                  child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.green,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddProduct()),
                      (Route<dynamic> route) => true,
                    );
                  },
                ),
              ))),
          const SizedBox(height: 20),
          Text("Add New Product",
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 1.8)),
          const SizedBox(height: 25),
          Row(
            children: [
              const SizedBox(width: 20),
              const Text("Expiring soon.."),
              const SizedBox(width: 5),
              const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text('Filter by Product Status'),
                              actions: <Widget>[
                                ListTile(
                                  title: const Text('Opened'),
                                  leading: Radio<Status>(
                                    value: Status.opened,
                                    groupValue: _productStatus,
                                    onChanged: (Status? value) {
                                      setState(() {
                                        _productStatus = value;
                                        _statusToQuery = 'Opened';
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Sealed'),
                                  leading: Radio<Status>(
                                    value: Status.sealed,
                                    groupValue: _productStatus,
                                    onChanged: (Status? value) {
                                      setState(() {
                                        _productStatus = value;
                                        _statusToQuery = 'Sealed';
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Show All'),
                                  leading: Radio<Status>(
                                    value: Status.all,
                                    groupValue: _productStatus,
                                    onChanged: (Status? value) {
                                      setState(() {
                                        _productStatus = value;
                                        _statusToQuery = 'All';
                                      });
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(Icons.filter_alt))
            ],
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ProductsGrid(status: _statusToQuery))),
        ]));
  }
}
