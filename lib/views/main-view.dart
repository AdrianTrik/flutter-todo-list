import 'package:carrefour/model/loading-flag.dart';
import 'package:carrefour/service/item-service.dart';
import 'package:carrefour/service/util-service.dart';
import 'package:carrefour/widgets/actions-widget.dart';
import 'package:carrefour/widgets/item-list-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'add-item-view.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    addItem(String product, String quantity) async {
      Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

      Navigator.of(context).pop();

      await ItemService().addItem(product, quantity);

      Provider.of<LoadingFlag>(context, listen: false).toggleSaving();

      UtilService.getFlushBar(context, 'Se agrego un producto');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueCarrefour,
        title: Text('Lista de compras'),
        leading: Padding(
          padding: EdgeInsets.only(left: 15.0, bottom: 5.0, top: 7.0),
          child: CircleAvatar(
            child: Icon(
              Icons.shopping_cart,
              color: kBlueCarrefour,
            ),
            backgroundColor: Colors.white,
          ),
        ),
        actions: <Widget>[
          ActionsWidget(),
        ],
      ),
      body: Container(
        child: ItemListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlueCarrefour,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddItemView(
                  onAddItem: (String product, String quantity) {
                    addItem(product, quantity);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
