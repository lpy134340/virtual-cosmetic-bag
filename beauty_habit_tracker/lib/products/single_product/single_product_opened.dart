// ignore_for_file: use_build_context_synchronously

import 'package:beauty_habit_tracker/products/operation_on_product_method.dart';
import 'package:beauty_habit_tracker/products/archived_products.dart';
import 'package:beauty_habit_tracker/products/product_display_style.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../product_display_widgets.dart';

import '../../utils/button_factory.dart';
import '../../utils/product_info/products_static_info.dart';

class DisplayOpenedProduct extends StatefulWidget {
  final String productId;
  final ProductModel productModel;

  const DisplayOpenedProduct({
    super.key,
    required this.productId,
    required this.productModel,
  });

  @override
  State<DisplayOpenedProduct> createState() {
    return _DisplayOpenedProductState();
  }
}

class _DisplayOpenedProductState extends State<DisplayOpenedProduct> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductModel _productModel;
  late Timestamp _finishDate;

  @override
  void initState() {
    super.initState();
    setState(() {
      _productModel = widget.productModel;
      _finishDate = _productModel.finishedOn as Timestamp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Padding(
            padding: const EdgeInsets.all(60.0),
            child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductImage(productModel: _productModel),
                    ],
                  ),
                  ProductBrand(productModel: _productModel),
                  ProductType(productModel: _productModel),
                  ProductName(productModel: _productModel),
                  ProductStatus(productModel: _productModel),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: ProductNote(productModel: _productModel)),
                  ProductAddDate(productModel: _productModel),
                  ProductOpenDate(productModel: _productModel),
                  ProductPAO(productModel: _productModel),
                  //setProductPao(),
                  ProductEXD(productModel: _productModel),
                  ProductFinishDate(productModel: _productModel),
                  ProductArchiveDate(productModel: _productModel),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // cancel button
                      ProjectButton.primary(
                          semanticsLabel: 'Cancel',
                          label: 'Cancel',
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.black)),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Products()),
                              (Route<dynamic> route) => true,
                            );
                          }),

                      ProjectButton.primary(
                          semanticsLabel: 'Archive',
                          label: 'Archive',
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                          ),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext archiveDialogcontext) {
                                  return AlertDialog(
                                    title: const Text('Archive the product'),
                                    content: const Text(
                                        'Do you want to archive the product?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(archiveDialogcontext)
                                              .pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                          child: const Text('Yes'),
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    finishDialogcontext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Archive the product'),
                                                    content: const Text(
                                                        'Did you finished the product?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          final snackBar =
                                                              SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            content: Row(
                                                              children: const <
                                                                  Widget>[
                                                                CircularProgressIndicator(),
                                                                Text(
                                                                    "  Archiving ...")
                                                              ],
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);

                                                          Navigator.of(
                                                                  archiveDialogcontext)
                                                              .pop();
                                                          Navigator.of(
                                                                  finishDialogcontext)
                                                              .pop();
                                                          //todo: backend of update productModel;
                                                          await archiveProduct(
                                                              widget.productId,
                                                              _productModel,
                                                              _finishDate);

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
                                                                        const ArchivedProducts(),
                                                              ),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  true,
                                                            );
                                                          });
                                                        },
                                                        child: const Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
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
                                                              _finishDate =
                                                                  Timestamp
                                                                      .fromDate(
                                                                          value);
                                                            }
                                                          });

                                                          Navigator.of(
                                                                  finishDialogcontext)
                                                              .pop();

                                                          Navigator.of(
                                                                  archiveDialogcontext)
                                                              .pop();

                                                          final snackBar =
                                                              SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            content: Row(
                                                              children: const <
                                                                  Widget>[
                                                                CircularProgressIndicator(),
                                                                Text(
                                                                    "  Archiving ...")
                                                              ],
                                                            ),
                                                          );
                                                          await archiveProduct(
                                                              widget.productId,
                                                              _productModel,
                                                              _finishDate);

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);

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
                                                                        const ArchivedProducts(),
                                                              ),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  true,
                                                            );
                                                          });
                                                        },
                                                        child:
                                                            const Text('Yes'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          })
                                    ],
                                  );
                                });
                          }),
                    ],
                  )
                ])));
  }

  Row setProductPao() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      textDirection: TextDirection.ltr,
      children: [
        const Text('Estimated PAO',
            style: subtitleStyle, textDirection: TextDirection.ltr),
        DropdownButton(
            isExpanded: false,
            icon: const Icon(
              Icons.timer,
              color: Colors.blue,
            ),
            iconSize: 30,
            value: _productModel.pAO,
            items: paoList
                .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e.toString())))
                .toList(),
            onChanged: (value) {
              setState(() {
                _productModel.setPao(value as int);
                _productModel.setEXD();
              });
            }),
      ],
    );
  }
}
