import 'package:beauty_habit_tracker/products/product_display_style.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:beauty_habit_tracker/utils/button_factory.dart';
import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:beauty_habit_tracker/products/operation_on_product_method.dart';
import 'package:beauty_habit_tracker/products/product_display_widgets.dart';

import '../../utils/button_factory.dart';

class DisplaySealedProduct extends StatefulWidget {
  final String productId;
  final ProductModel productModel;

  const DisplaySealedProduct({
    super.key,
    required this.productId,
    required this.productModel,
  });

  @override
  State<DisplaySealedProduct> createState() {
    return _DisplaySealedProductState();
  }
}

class _DisplaySealedProductState extends State<DisplaySealedProduct> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _noteController = TextEditingController();
  bool _opened = false;
  late String productId;
  late ProductModel _productModel;
  Timestamp _openDate = defaultMaxTime;

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    _productModel = widget.productModel;
    _openDate = _productModel.openOn!;
    _noteController = TextEditingController(text: _productModel.note);
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
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 400,
                    height: 80,
                    child: showNote(true),
                  ),
                  editStatus(),
                  showOpendate(context),
                  ProductAddDate(productModel: _productModel),
                  showPAO(),
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
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.black)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Products()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                      ProjectButton.primary(
                          semanticsLabel: 'Update',
                          label: 'Update',
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                          ),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext updateDialogcontext) {
                                  return AlertDialog(
                                      title: const Text(
                                          'Review the Updated Information',
                                          style: subtitleStyle),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'status:${_productModel.status}',
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                              'open date:${displayTime(_productModel.openOn)}',
                                              textAlign: TextAlign.left),
                                          Text(
                                              'PAO:${_productModel.pAO} months',
                                              textAlign: TextAlign.left),
                                          Text(
                                              'Estimated EXD:${displayTime(_productModel.eXD)}',
                                              textAlign: TextAlign.left),
                                          Text(
                                              'Customized Note:${_productModel.note}',
                                              textAlign: TextAlign.left),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('No, go back'),
                                          onPressed: () {
                                            Navigator.pop(updateDialogcontext);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                              'Yes, confirm to update'),
                                          onPressed: () async {
                                            final snackBar = SnackBar(
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: Row(
                                                children: const <Widget>[
                                                  CircularProgressIndicator(),
                                                  Text(" Updating ...")
                                                ],
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            await updateProduct(
                                                productId, _productModel);
                                            Future.delayed(
                                                const Duration(seconds: 3), () {
                                              Navigator.pop(
                                                  updateDialogcontext);
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Products()),
                                                  (Route<dynamic> route) =>
                                                      true);
                                            });
                                          },
                                        ),
                                      ]);
                                });
                          })
                    ],
                  ),
                ])));
  }

  Row showPAO() {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          flex: 2,
          child: Text(
            'Estimated PAO',
            style: subtitleStyle,
            textDirection: TextDirection.ltr,
          ),
        ),
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

  Row showOpendate(BuildContext context) {
    return Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Expanded(
            child: Text('Open date',
                style: subtitleStyle, textDirection: TextDirection.ltr),
          ),
          Expanded(
              child: Text(displayTime(_productModel.openOn),
                  style: productInfoStyle, textDirection: TextDirection.ltr)),
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.calendar_today_rounded,
              size: 30,
              color: Colors.blue,
              textDirection: TextDirection.ltr,
            ),
            visualDensity: VisualDensity.comfortable,
            enableFeedback: true,
            onPressed: () {
              _productModel.isOpen()
                  ? showDatePicker(
                          helpText: 'Choose the open date',
                          fieldHintText: 'Choose the open date',
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019),
                          lastDate: DateTime.now())
                      .then((value) {
                      if (value != null) {
                        setState(() {
                          _openDate = Timestamp.fromDate(value);
                          _productModel.open(_openDate);
                          _productModel.setEXD();
                        });
                      }
                    })
                  : null;
            },
          ),
        ]);
  }

  Row editStatus() {
    return Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Expanded(
            child: Text(
              'Product status',
              style: subtitleStyle,
              textDirection: TextDirection.ltr,
            ),
          ),
          Switch(
            value: _opened,
            onChanged: (value) {
              _opened = value;
              setState(() {
                if (_opened) {
                  _openDate = Timestamp.now();
                  _productModel.open(_openDate);
                } else {
                  _openDate = defaultMaxTime;
                  _productModel.open(_openDate);
                  _productModel.status = 'Sealed';
                }
                _productModel.setEXD();
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),
        ]);
  }

  TextField showNote(bool isEditable) {
    return TextField(
      textDirection: TextDirection.ltr,
      enabled: isEditable,
      maxLength: 200,
      controller: _noteController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Customized Notes'),
      onChanged: (value) {
        setState(() {
          _productModel.note = _noteController.text;
        });
      },
    );
  }
}
