import 'dart:io';
import 'package:beauty_habit_tracker/products/operation_on_product_method.dart';
import 'package:beauty_habit_tracker/products/product_display_style.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/products.dart';
import 'package:beauty_habit_tracker/navigation_related/sidebar.dart';
import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/button_factory.dart';
import 'package:image_picker/image_picker.dart';

const topEdgeSize = 85.0;
const titleFontSize = 28.0;
const bodyFontSize = 20.0;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() {
    return _AddProductState();
  }
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late String _brand;
  late String _type;
  late String _name;
  late String _note;
  late String _selectedStatus;
  late int _selectedPAO;
  late Timestamp _selectedDate;
  late String _image;
  File? showImage;

  @override
  void initState() {
    super.initState();
    _brand = 'Acqua di Parma';
    _type = 'Cleansers';
    _name = 'customize your name';
    _note = 'optional note';
    _selectedStatus = 'Sealed';
    _selectedPAO = 36;
    _selectedDate = defaultMaxTime;
    _image = defualtImageLink;
  }

  Future pickImage() async {
    try {
      final imagePicked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 50,
      );
      if (imagePicked == null) return;
      final imageTemp = File(imagePicked.path);
      setState(() {
        showImage = imageTemp;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future takePhoto() async {
    try {
      final imagePicked = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 90,
        maxHeight: 90,
        imageQuality: 60,
      );
      if (imagePicked == null) return;
      final imageTemp = File(imagePicked.path);
      setState(() => showImage = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideBar(),
        // appBar: AppBar(
        //     title: const Text('Add Product',
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        key: scaffoldKey,
        body: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 60, right: 60, bottom: 10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 231, 148, 176),
                      border: Border.symmetric(),
                      shape: BoxShape.rectangle,
                    ),
                    height: 150,
                    width: 120,
                    child: showImage != null
                        ? Image.file(showImage!)
                        : const Text('! No Preview Image Now'),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () async {
                              pickImage();
                            },
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.amber,
                              size: 30,
                            )),
                        IconButton(
                          onPressed: () async {
                            takePhoto();
                          },
                          icon: const Icon(Icons.photo_camera),
                          color: Colors.green,
                          iconSize: 30,
                        ),
                        TextButton(
                          child: const Text('click to upload'),
                          onPressed: () async {
                            if (showImage == null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text('No Image selected'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Continue'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              var url = await uploadImage(showImage!);
                              if (url == null) {
                                debugPrint('can not get the url');
                              } else {
                                setState(() {
                                  _image = url.toString();
                                });
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Done'),
                                        content: const Text('Add Success'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Continue'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                        ),
                      ]),
                ],
              ),
              DropdownButtonFormField(
                  decoration: (const InputDecoration(
                    labelText: 'select the brand',
                  )),
                  icon: const Icon(
                    Icons.pageview_rounded,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                  value: _brand,
                  items: brandList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    _brand = value as String;
                  }),
              DropdownButtonFormField(
                  isExpanded: false,
                  decoration: (const InputDecoration(
                    labelText: 'select the type',
                  )),
                  icon: const Icon(
                    Icons.pageview_rounded,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                  value: _type,
                  items: typeList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    _type = value as String;
                  }),
              TextFormField(
                textDirection: TextDirection.ltr,
                maxLength: 30,
                decoration: const InputDecoration(
                    hintText: 'collection/color ',
                    labelText: 'Name',
                    suffixIcon: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.blue,
                    )),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              DropdownButtonFormField(
                  decoration: (const InputDecoration(
                    labelText: 'select the status',
                  )),
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                  value: _selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value as String;
                    });
                  }),
              DropdownButtonFormField(
                  decoration: (const InputDecoration(
                    labelText: 'select the PAO (months)',
                  )),
                  icon: const Icon(
                    Icons.timer,
                    color: Colors.blue,
                  ),
                  iconSize: 30,
                  value: _selectedPAO,
                  items: paoList
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.toString())))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPAO = value as int;
                    });
                  }),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    const Text(
                      'Set the open date:   ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                        child: Text(
                      displayTime(_selectedDate),
                      style: productInfoStyle,
                    )),
                    IconButton(
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        size: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _selectedStatus == 'Opened'
                            ? showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2019),
                                    lastDate: DateTime.now())
                                .then((value) {
                                setState(() {
                                  _selectedDate = Timestamp.fromDate(value!);
                                });
                              })
                            : null;
                      },
                    ),
                  ]),
              TextField(
                maxLength: 200,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'add any cutomized note for this product ',
                  labelText: 'Notes',
                ),
                textAlign: TextAlign.left,
                onChanged: (value) {
                  setState(() {
                    _note = value;
                  });
                },
              ),
              //const SizedBox(height: 20, width: 200),
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
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Products()),
                      );
                    },
                  ),
                  // seperator
                  ProjectButton.primary(
                      semanticsLabel: 'Add',
                      label: 'Add',
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
                              Text("  Adding ...")
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        var newProduct = ProductModel.generateNewProduct(
                            _brand,
                            _type,
                            _name,
                            _selectedStatus,
                            _image,
                            _selectedPAO,
                            _selectedDate,
                            _note);
                        await addProduct(newProduct);
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
            ],
          ),
        ));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green;
    }
    return Colors.black;
  }
}
