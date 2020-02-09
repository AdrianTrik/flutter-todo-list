import 'package:carrefour/constants.dart';
import 'package:carrefour/service/item-service.dart';
import 'package:flutter/material.dart';

class AddItemView extends StatefulWidget {
  AddItemView({this.onAddItem});

  final Function onAddItem;

  @override
  _AddItemViewState createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  FocusNode _focusNodeProduct = FocusNode();
  FocusNode _focusNodeQuantity = FocusNode();
  TextStyle labelProductTextStyle, labelQuantityTextStyle;

  String product, quantity;
  ItemService itemService = new ItemService();

  @override
  void initState() {
    super.initState();

    _focusNodeProduct.addListener(() {
      setState(() {
        labelProductTextStyle =
            _focusNodeProduct.hasFocus ? kLabelStyleOnFocus : null;
      });
    });

    _focusNodeQuantity.addListener(() {
      setState(() {
        labelQuantityTextStyle =
            _focusNodeQuantity.hasFocus ? kLabelStyleOnFocus : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            onChanged: (value) {
              product = value;
            },
            focusNode: _focusNodeProduct,
            autocorrect: true,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Producto',
              labelStyle: labelProductTextStyle,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kBlueCarrefour,
                  width: 2.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            onChanged: (value) {
              quantity = value;
            },
            focusNode: _focusNodeQuantity,
            autocorrect: true,
            decoration: InputDecoration(
              labelText: 'Detalle',
              labelStyle: labelQuantityTextStyle,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kBlueCarrefour,
                  width: 2.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          FlatButton(
            textColor: Colors.white,
            color: kBlueCarrefour,
            child: Text('Agregar'),
            onPressed: () {
              widget.onAddItem(product, quantity);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeQuantity.dispose();
    _focusNodeProduct.dispose();

    super.dispose();
  }
}
