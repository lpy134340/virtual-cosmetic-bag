// ignore_for_file: use_build_context_synchronously

import 'package:beauty_habit_tracker/products/add_product_page.dart';
import 'package:beauty_habit_tracker/products/single_product/single_product_sealed.dart';
import 'package:beauty_habit_tracker/navigation_related/sidebar.dart';
import 'package:beauty_habit_tracker/products/single_product/single_product_opened.dart';
import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'archived_products.dart';
import 'operation_on_product_method.dart';

class Products extends StatefulWidget {
  const Products({super.key});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: <Widget>[
              const Text(
                semanticsLabel: 'All Products',
                'All Products',
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              const SizedBox(height: 10),
              SizedBox(
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
              const SizedBox(height: 10),
              Text(
                'Opened',
                semanticsLabel: 'All Products',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  color: Colors.pink[100],
                  child: StreamBuilder<QuerySnapshot>(
                      stream: getStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Text(
                            "There is no product",
                            semanticsLabel: 'There is no product',
                          );
                        }
                        return SizedBox(
                            width: 330,
                            height: 200,
                            child: ListView(
                                children:
                                    getOpenedProductInfo(context, snapshot)));
                      })),
              const SizedBox(height: 30),
              Text(
                'Sealed',
                semanticsLabel: 'Sealed',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.green[100],
                  child: StreamBuilder<QuerySnapshot>(
                      stream: getStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("There is no product",
                              semanticsLabel: 'There is no product');
                        }
                        return SizedBox(
                            width: 330,
                            height: 200,
                            child: ListView(
                                children:
                                    getSealedProductInfo(context, snapshot)));
                      })),
            ],
          ),
        ),
      ),
    );
  }

  getOpenedProductInfo(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map((doc) {
      if (doc.get('Status') != 'Opened') {
        return const SizedBox.shrink();
      }
      return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            getProductInfo(doc),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    icon: const Icon(
                      CupertinoIcons.archivebox_fill,
                      size: 25,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      String productId = doc.id;
                      var product = await getProduct(productId);
                      if (product == null) {
                        showErrorMessage(context);
                        debugPrint('Can not get the product');
                        return;
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogcontext) {
                              return AlertDialog(
                                  title: const Text('Archive the product',
                                      semanticsLabel: 'Archive the product'),
                                  content: const Text(
                                    'Do you want to archive the product?',
                                    semanticsLabel:
                                        'Do you want to archive the product',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogcontext).pop();
                                      },
                                      child: const Text('Cancel',
                                          semanticsLabel: 'Cancel'),
                                    ),
                                    TextButton(
                                        child: const Text('Yes',
                                            semanticsLabel: 'Yes'),
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext finishcontext) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Archive the product',
                                                      semanticsLabel:
                                                          'Archive the product'),
                                                  content: const Text(
                                                    'Did you finished the product?',
                                                    semanticsLabel:
                                                        'Did you finished the product?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        var time =
                                                            defaultMaxTime;
                                                        Navigator.of(
                                                                finishcontext)
                                                            .pop();
                                                        Navigator.of(
                                                                dialogcontext)
                                                            .pop();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                getSnackBar());

                                                        await archiveProduct(
                                                            productId,
                                                            product,
                                                            time);
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 3),
                                                            () {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ArchivedProducts()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                true,
                                                          );
                                                        });
                                                      },
                                                      child: const Text(
                                                        'No',
                                                        semanticsLabel: 'No',
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        var time =
                                                            Timestamp.now();
                                                        await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime(
                                                              2019, 1, 1),
                                                          lastDate:
                                                              DateTime.now(),
                                                        ).then((value) async {
                                                          if (value == null) {
                                                            return;
                                                          } else {
                                                            time = Timestamp
                                                                .fromDate(
                                                                    value);

                                                            Navigator.of(
                                                                    finishcontext)
                                                                .pop();
                                                            Navigator.of(
                                                                    dialogcontext)
                                                                .pop();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    getSnackBar());

                                                            await archiveProduct(
                                                                productId,
                                                                product,
                                                                time);
                                                          }
                                                        });

                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ArchivedProducts()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                true,
                                                          );
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Yes',
                                                        semanticsLabel: 'Yes',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              });
                                        })
                                  ]);
                            });
                      }
                    }),
                TextButton(
                  child: const Text('...'),
                  onPressed: () async {
                    String productId = doc.id;
                    var product = await getProduct(productId);
                    if (product == null) {
                      showErrorMessage(context);
                    } else {
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayOpenedProduct(
                                  productId: productId, productModel: product)),
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  ListTile getProductInfo(QueryDocumentSnapshot<Object?> doc) {
    return ListTile(
      minLeadingWidth: 20,
      minVerticalPadding: 5,
      leading: Image.network(
        doc.get('Image'),
        height: 50,
        width: 50,
        filterQuality: FilterQuality.low,
      ),
      title: Text(doc.get('Brand').toString(),
          semanticsLabel: 'Brand is ${doc.get('Brand').toString()}',
          style: const TextStyle(color: Colors.black)),
      subtitle: Text(
        doc.get('Type').toString(),
        semanticsLabel: 'Type is ${doc.get('Type').toString()}',
        style: const TextStyle(color: Colors.black),
      ),
      trailing: Text(
        getRemainShelfLife(
          doc.get("EXD"),
        ),
        semanticsLabel:
            'Remaining Shelf life time is ${getRemainShelfLife(doc.get("EXD"))} days',
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Future<dynamic> showErrorMessage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext errorcontext) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Sorry, Try later!'),
            actions: [
              TextButton(
                child: const Text('Back'),
                onPressed: () {
                  Navigator.of(errorcontext).pop();
                },
              )
            ],
          );
        });
  }

  getSealedProductInfo(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map((doc) {
      if (doc.get('Status') == 'Sealed') {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              getProductInfo(doc),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.lock_open_fill,
                      size: 25,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      String productId = doc.id;
                      var product = await getProduct(productId);
                      if (product == null) {
                        showErrorMessage(context);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogcontext) {
                              return AlertDialog(
                                  title: const Text(
                                    'Open this product',
                                    semanticsLabel: 'Open this product',
                                  ),
                                  content: const Text(
                                      'Do you want to open it? ',
                                      semanticsLabel:
                                          'Do you want to open it?'),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          Navigator.of(dialogcontext).pop,
                                      child: const Text(
                                        'No',
                                        semanticsLabel:
                                            'click this button if you do not want to open it',
                                      ),
                                    ),
                                    TextButton(
                                        child: const Text(
                                          'Yes, select the open date',
                                          semanticsLabel:
                                              'Yes, select the open date',
                                        ),
                                        onPressed: () async {
                                          await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      Timestamp.now().toDate(),
                                                  firstDate:
                                                      DateTime(2010, 1, 1),
                                                  lastDate: DateTime.now())
                                              .then((value) async {
                                            if (value != null) {
                                              product.open(
                                                  Timestamp.fromDate(value));
                                              Navigator.of(dialogcontext).pop();
                                              await updateProduct(
                                                  productId, product);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Products()),
                                                  (Route<dynamic> route) =>
                                                      true);
                                            } else {
                                              Navigator.of(dialogcontext).pop();
                                            }
                                          });
                                          // refresh the page;
                                        })
                                  ]);
                            });
                      }
                    },
                  ),
                  TextButton(
                      child: const Text(
                        '...',
                        semanticsLabel: 'See more details about this product',
                      ),
                      onPressed: () async {
                        String productId = doc.id;
                        var product = await getProduct(productId);
                        if (product == null) {
                          debugPrint('can not fetch the product!');
                        } else {
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DisplaySealedProduct(
                                      productId: productId,
                                      productModel: product)),
                            );
                          });
                        }
                      }),
                ],
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    }).toList();
  }

  String getRemainShelfLife(Timestamp exd) {
    var remain = exd.toDate().difference(DateTime.now()).inDays;
    return '$remain Days';
  }
}

SnackBar getSnackBar() {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Row(
      children: const <Widget>[
        CircularProgressIndicator(),
        Text(
          "  Archiving ...",
          semanticsLabel: 'Archiving the product',
        )
      ],
    ),
  );
}
