import 'package:flutter/material.dart';
import 'package:stock_management/models/sellers.dart';
import 'package:stock_management/services/api.dart';
import 'package:stock_management/services/supplementNotifier.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/models/supplement.dart';

class SellForm extends StatefulWidget {
  @override
  _SellFormState createState() => _SellFormState();
}

class _SellFormState extends State<SellForm> {
  Seller _seller;
  GlobalKey<FormState> _Formkey = GlobalKey<FormState>();


  @override
  void initState(){
    super.initState();
    _seller = Seller();
  }

  _saveForm() async {
    if(!_Formkey.currentState.validate()){
      return;
    }
    _Formkey.currentState.save();

    uploadSeller(_seller);
    Navigator.pop(context);
    Navigator.pop(context);
  }


  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blueAccent,Colors.red],
        ),
      ),
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),

      child: AlertDialog(
        content: Form(
          key: _Formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sold By',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Name Required';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _seller.soldBy = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sold To',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Name Required';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _seller.SoldTo = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Sold In',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Amount Name Required';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _seller.SellingPrice = num.tryParse(value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Supplement Name',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Note Name Required';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _seller.Note = value;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(
                  child: Text(
                    'DueDate',
                  ),
                  onPressed: (){
                    showDatePicker(context: context, initialDate: DateTime.now(),
                        firstDate:DateTime(2001),
                        lastDate:DateTime(2222)
                    ).then((value) {
                      var date = DateTime.parse('$value');
                      var formattedDate = '${date.day}-${date.month}-${date.year}';
                      setState(() {
                        _seller.DueDate = formattedDate.toString();
                      });
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(
                  child: Text("Submit"
                      ),
                  onPressed: () async {
                    _saveForm();

                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(
                  child: Text('Cancel'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

