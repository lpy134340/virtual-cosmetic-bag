import 'package:beauty_habit_tracker/navigation_related/sidebar.dart';
import 'package:beauty_habit_tracker/products/single_product/single_product_archived.dart';
import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'operation_on_product_method.dart';

class ArchivedProducts extends StatefulWidget {
  const ArchivedProducts({super.key});

  @override
  State<ArchivedProducts> createState() => _ArchivedProductsState();
}

class _ArchivedProductsState extends State<ArchivedProducts> {
  final ScrollController _controller = ScrollController();
  String archivedInfo = '''
means stop tracking the expiration date of the product. 
Here stored all inactive products. You can filter them by year or finished status.
Archiving a product is important for us to track your habit, generate reports, and send you recommendations.
Remember to archive a product when

1) the product is expired
2) the product is finished
3) the product is returned
4) the product is logged by mistake 
(archive, then permanently delete)

See more on the user guidance
''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 35, left: 50, right: 50, bottom: 50),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Archived',
                      textAlign: TextAlign.center,
                      semanticsLabel: 'Archived',
                      style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                  content: Text(archivedInfo,
                                      semanticsLabel: archivedInfo)));
                        },
                        icon: const Icon(CupertinoIcons.question_circle_fill,
                            semanticLabel: 'instructions', color: Colors.black))
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                    color: Colors.pink[100],
                    child: StreamBuilder<QuerySnapshot>(
                        stream: getStreamArchived(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            // ignore: unused_label
                            semanticLabel:
                            'There is no product';
                            // todo: is this gonna work?
                            return const Text("There is no product");
                          }
                          return SizedBox(
                              width: 400,
                              height: 550,
                              child: ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  controller: _controller,
                                  children: getArchivedProductInfo(
                                      context, snapshot)));
                        })),
              ]),
        ));
  }

  getArchivedProductInfo(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map((doc) {
      if (doc.get('Status') != 'Archived') {
        return const SizedBox.shrink();
      }
      return Card(
          child: Column(children: <Widget>[
        ListTile(
          minLeadingWidth: 0,
          minVerticalPadding: 5,
          leading: Image.network(
            doc.get('Image'),
            height: 50,
            width: 50,
            filterQuality: FilterQuality.low,
          ),
          title: Text(doc.get('Brand'),
              style: const TextStyle(color: Colors.black)),
          subtitle: Text(
            doc.get('Type').toString(),
            style: const TextStyle(color: Colors.black),
          ),
          trailing: TextButton(
            child: const Text(
              '...',
              semanticsLabel: 'view product details',
            ),
            onPressed: () async {
              String productId = doc.id;
              var product = await getProduct(productId);
              if (product == null) {
                debugPrint('can not fetch the product!');
              } else {
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DisplayArchivedProduct(
                            productId: productId, productModel: product)),
                  );
                });
              }
            },
          ),
          //trailing: showFinishData(doc.get('Finished_Date')),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Archived Date: "),
              Text(DateFormat('yyyy-MM-dd')
                  .format(doc.get('Archived_Date').toDate())),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Finished: "),
              showFinishData(doc.get('Finished_Date')),
              IconButton(
                  icon: const Icon(
                    CupertinoIcons.trash_circle_fill,
                    size: 25,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("Delete this product?"),
                              content: const Text(
                                  "This product will not be included in habit tracking anymore."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            )).then((value) async {
                      if (value == true) {
                        final snackBar = SnackBar(
                          duration: const Duration(seconds: 3),
                          content: Row(
                            children: const <Widget>[
                              CircularProgressIndicator(),
                              Text("  Deleting ...")
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        await deleteProduct(doc.id);
                        Future.delayed(const Duration(seconds: 3), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ArchivedProducts()),
                          );
                        });
                      }
                    });
                  })
            ],
          ),
        ),
      ]));
    }).toList();
  }

  showFinishData(Timestamp time) {
    if (time == defaultMaxTime) {
      return const Text(
        'Not Finished!',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text(
        'Finished',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      );
    }
  }
}
