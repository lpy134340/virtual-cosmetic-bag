import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:beauty_habit_tracker/navigation_related/sidebar.dart';
import 'package:flutter/material.dart';
import '../operation_on_product_method.dart';
import '../product_display_widgets.dart';
import '../../utils/button_factory.dart';

class DisplayArchivedProduct extends StatefulWidget {
  final String productId;
  final ProductModel productModel;

  const DisplayArchivedProduct({
    super.key,
    required this.productId,
    required this.productModel,
  });

  @override
  State<DisplayArchivedProduct> createState() {
    return _DisplayArchivedProductState();
  }
}

class _DisplayArchivedProductState extends State<DisplayArchivedProduct> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ProductModel _productModel;
  // ignore: unused_field
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    setState(() {
      _productModel = widget.productModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        key: scaffoldKey,
        body: Padding(
            padding: const EdgeInsets.all(60.0),
            child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductImage(productModel: _productModel),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ProductBrand(productModel: _productModel),
                        ProductType(productModel: _productModel),
                        ProductName(productModel: _productModel),
                        ProductStatus(productModel: _productModel),
                      ]),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 80,
                      width: 400,
                      child: ProductNote(productModel: _productModel)),
                  const SizedBox(height: 20),
                  ProductOpenDate(productModel: _productModel),
                  ProductAddDate(productModel: _productModel),
                  ProductPAO(productModel: _productModel),
                  ProductEXD(productModel: _productModel),
                  ProductFinishDate(productModel: _productModel),
                  ProductArchiveDate(productModel: _productModel),
                  const SizedBox(height: 40),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Products()),
                          );
                        },
                      ),
                      // seperator
                      const SizedBox(width: 100),
                      ProjectButton.primary(
                          semanticsLabel: 'Delete',
                          label: 'Delete',
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.green),
                          ),
                          onPressed: () async {
                            final snackBar = SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Row(
                                children: const <Widget>[
                                  CircularProgressIndicator(),
                                  Text(" Deleting ...")
                                ],
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            await deleteProduct(widget.productId);
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Products()),
                                (Route<dynamic> route) => true,
                              );
                            });
                          })
                    ],
                  ),
                ])));
  }
}
