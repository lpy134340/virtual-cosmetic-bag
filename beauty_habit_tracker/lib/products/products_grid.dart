import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key, required this.status});
  final String status;

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final Icon opened = const Icon(
    Icons.lock_open_rounded,
    color: Colors.white,
  );
  final Icon sealed = const Icon(Icons.lock_outline, color: Colors.white);
  final Icon archived = const Icon(Icons.archive, color: Colors.white);

  int daysBetween(DateTime fromDate, DateTime toDate) {
    fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day);
    toDate = DateTime(toDate.year, toDate.month, toDate.day);
    return (toDate.difference(fromDate).inHours / 24).round();
  }

  int getNumberOfDays(DateTime exd) {
    int days = daysBetween(DateTime.now(), exd);
    return days;
  }

  getProducts() {
    try {
      Stream<QuerySnapshot> products = FirebaseFirestore.instance
          .collection('/product_list_per_user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('/products')
          .orderBy('EXD')
          .limit(6)
          .get()
          .asStream();
      return products;
    } catch (Exc) {
      rethrow;
    }
  }

  getProductsByStatus(productStatus) {
    try {
      Stream<QuerySnapshot> products = FirebaseFirestore.instance
          .collection('/product_list_per_user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('/products')
          .where('Status', isEqualTo: productStatus)
          .get()
          .asStream();
      return products;
      // ignore: non_constant_identifier_names
    } catch (Exc) {
      // ignore: avoid_print
      print(Exc);
      rethrow;
    }
  }

  displayIcon(String status) {
    if (status == 'Sealed') {
      return sealed;
    } else if (status == 'Opened') {
      return opened;
    } else {
      return archived;
    }
  }


  String getRemainShelfLife(Timestamp exd) {
    var remain = exd.toDate().difference(DateTime.now()).inDays;
    return '$remain Days';
  }

  @override
  Widget build(BuildContext context) {
    final prodStatus = widget.status;
    debugPrint(prodStatus);
    return StreamBuilder<QuerySnapshot>(
        stream: prodStatus != 'All'
            ? getProductsByStatus(prodStatus)
            : getProducts(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const Text("Could not get Products!");
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              var data = Map<String, dynamic>.from(
                  snapshot.data?.docs[index].data() as Map);
              return Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                            tileColor: Colors.lightBlue,
                            title: 
                            Text(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              getRemainShelfLife((data['EXD'] as Timestamp)),
                            ),
                            subtitle: Text(
                              '${data['Brand']}',
                              textAlign: TextAlign.center,
                            ),
                            trailing: displayIcon(data['Status'])),
                        Column(children: <Widget>[
                          SizedBox(
                              height: 100.0,
                              child: Ink.image(
                                image: NetworkImage(data['Image']),
                                fit: BoxFit.cover,
                              )),
                        ]),
                      ]));
            },
            itemCount: snapshot.data?.docs.length,
          );
        });
  }
}
