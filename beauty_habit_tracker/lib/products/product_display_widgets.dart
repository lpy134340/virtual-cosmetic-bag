import 'package:beauty_habit_tracker/products/product_display_style.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:flutter/material.dart';

import 'operation_on_product_method.dart';
import '../utils/product_info/products_static_info.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 231, 148, 176),
        border: Border.symmetric(),
        shape: BoxShape.rectangle,
      ),
      height: 100,
      width: 100,
      child: Image.network(
        _productModel.image,
      ),
    );
  }
}

class ProductOpenDate extends StatelessWidget {
  const ProductOpenDate({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
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
          const Icon(
            Icons.calendar_today_rounded,
            size: 30,
            textDirection: TextDirection.rtl,
          ),
        ]);
  }
}

class ProductBrand extends StatelessWidget {
  const ProductBrand({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
            flex: 2,
            child: Text('Brand',
                style: subtitleStyle, textDirection: TextDirection.ltr)),
        Expanded(
            child: Text(_productModel.brand,
                style: productInfoStyle, textDirection: TextDirection.rtl))
      ],
    );
  }
}

class ProductNote extends StatelessWidget {
  const ProductNote({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 300,
      child: TextField(
        textDirection: TextDirection.ltr,
        readOnly: true,
        controller: TextEditingController(text: _productModel.note!),
        maxLength: 200,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: 'Your note'),
      ),
    );
  }
}

class ProductArchiveDate extends StatelessWidget {
  const ProductArchiveDate({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          child: Text(
            'Archive date',
            style: subtitleStyle,
            textDirection: TextDirection.ltr,
          ),
        ),
        Expanded(
            child: Text(displayTime(_productModel.archivedOn),
                style: productInfoStyle, textDirection: TextDirection.ltr)),
        const Icon(
          Icons.calendar_today_rounded,
          size: 30,
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}

class ProductFinishDate extends StatelessWidget {
  const ProductFinishDate({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          child: Text(
            'Finish date',
            style: subtitleStyle,
            textDirection: TextDirection.ltr,
          ),
        ),
        Expanded(
            child: Text(displayTime(_productModel.finishedOn),
                style: productInfoStyle, textDirection: TextDirection.ltr)),
        const Icon(
          Icons.calendar_today_rounded,
          size: 30,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}

class ProductEXD extends StatelessWidget {
  const ProductEXD({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          child: Text(
            'Estimated EXD',
            style: subtitleStyle,
            textDirection: TextDirection.ltr,
          ),
        ),
        Expanded(
            child: Text(displayTime(_productModel.eXD),
                style: productInfoStyle, textDirection: TextDirection.ltr)),
        const Icon(
          Icons.calendar_today_rounded,
          size: 30,
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}

class ProductAddDate extends StatelessWidget {
  const ProductAddDate({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            child: Text(
              'Add date',
              style: subtitleStyle,
              textDirection: TextDirection.ltr,
            ),
          ),
          Expanded(
              child: Text(displayTime(_productModel.addOn),
                  textAlign: TextAlign.left,
                  style: productInfoStyle,
                  textDirection: TextDirection.ltr)),
          const Icon(
            Icons.calendar_today_rounded,
            size: 30,
            textDirection: TextDirection.rtl,
          ),
        ]);
  }
}

class Space extends StatelessWidget {
  const Space({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}

class ProductStatus extends StatelessWidget {
  const ProductStatus({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
            flex: 2,
            child: Text('Status',
                style: subtitleStyle, textDirection: TextDirection.ltr)),
        Expanded(
            child: Text(_productModel.status,
                textAlign: TextAlign.right,
                style: productInfoStyle,
                textDirection: TextDirection.rtl)),
      ],
    );
  }
}

class ProductName extends StatelessWidget {
  const ProductName({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
            flex: 2,
            child: Text(
              'Name',
              style: subtitleStyle,
              textDirection: TextDirection.ltr,
            )),
        Expanded(
            child: Text(_productModel.name,
                textAlign: TextAlign.right,
                style: productInfoStyle,
                textDirection: TextDirection.ltr)),
      ],
    );
  }
}

class ProductType extends StatelessWidget {
  const ProductType({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
            child: Text(
          'Type',
          style: subtitleStyle,
          textDirection: TextDirection.ltr,
        )),
        Expanded(
            child: Text(
          _productModel.type,
          style: productInfoStyle,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr,
        )),
      ],
    );
  }
}

class ProductPAO extends StatelessWidget {
  const ProductPAO({
    Key? key,
    required ProductModel productModel,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Expanded(
          flex: 3,
          child: Text(
            'Estimated PAO',
            style: subtitleStyle,
            textDirection: TextDirection.ltr,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${_productModel.pAO.toString()} months',
            style: productInfoStyle,
            textAlign: TextAlign.right,
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }
}

class UpdateReminder extends StatelessWidget {
  const UpdateReminder({
    Key? key,
    required ProductModel productModel,
    required this.productId,
  })  : _productModel = productModel,
        super(key: key);

  final ProductModel _productModel;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title:
            const Text('Review the Updated Information', style: subtitleStyle),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'status:${_productModel.status}',
              textAlign: TextAlign.left,
            ),
            Text('open date:${displayTime(_productModel.openOn)}',
                textAlign: TextAlign.left),
            Text('PAO:${_productModel.pAO} months', textAlign: TextAlign.left),
            Text('Estimated EXD:${displayTime(_productModel.eXD)}',
                textAlign: TextAlign.left),
            Text('Customized Note:${_productModel.note}',
                textAlign: TextAlign.left),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('No, go back'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Yes, confirm to update'),
            onPressed: () async {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                content: Row(
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text(" Updating ...")
                  ],
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              await updateProduct(productId, _productModel);
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Products()),
                    (Route<dynamic> route) => true);
              });
            },
          ),
        ]);
  }
}
