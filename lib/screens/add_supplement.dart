import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/models/supplement.dart';
import 'package:stock_management/services/supplementNotifier.dart';
import 'package:stock_management/services/api.dart';

class AddSupplement extends StatefulWidget {
  @override
  _AddSupplementState createState() => _AddSupplementState();
}

class _AddSupplementState extends State<AddSupplement> {
  Supplement _currentSupplement;
  @override
  void initState() {

    super.initState();
    SupplementNotifier supplementNotifier = Provider.of<SupplementNotifier>(context,listen: false);

    _currentSupplement = Supplement();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildName(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "BrandName",
        labelStyle: TextStyle(
            color: Colors.blue
        ),
      ),
      cursorColor: Colors.white,
      validator: (String value){
        if(value.isEmpty){
          return 'Display Name Required';
        }
        return null;
      },
      onSaved: (String value){
        _currentSupplement.BrandName = value;
      },
    );
  }

  Widget _BuildCategory(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Category",
        labelStyle: TextStyle(
            color: Colors.blue
        ),
      ),
      cursorColor: Colors.white,
      validator: (String value){
        if(value.isEmpty){
          return 'Category Required';
        }
        return null;
      },
      onSaved: (String value){
        _currentSupplement.category = value;
      },
    );
  }

  Widget _BuildQuantity(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Quantity",
        labelStyle: TextStyle(
            color: Colors.blue
        ),
      ),
      cursorColor: Colors.white,
      validator: (String value){
        if(value.isEmpty){
          return 'Quantity Name Required';
        }
        return null;
      },
      onSaved: (String value){
        _currentSupplement.Quantity = num.tryParse(value);
      },
    );
  }

  Widget _BuildAmount(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Cost Price",
        labelStyle: TextStyle(
            color: Colors.blue
        ),
      ),
      cursorColor: Colors.white,
      validator: (String value){
        if(value.isEmpty){
          return 'Amount Name Required';
        }
        return null;
      },
      onSaved: (String value){
        _currentSupplement.Amount = value;
      },
    );
  }


  Widget _BuildExpDate(){
    return RaisedButton(
      child: Text(
        'ExpDate',
      ),
      onPressed: (){
        showDatePicker(context: context, initialDate: DateTime.now(),
            firstDate:DateTime(2001),
            lastDate:DateTime(2222)
        ).then((value) {
          var date = DateTime.parse('$value');
          var formattedDate = '${date.day}-${date.month}-${date.year}';
          setState(() {
            _currentSupplement.ExpDate = formattedDate.toString();
          });
        });
      },
    );
  }

  _onSupplementUploaded(Supplement supplement)  {
    SupplementNotifier supplementNotifier = Provider.of<SupplementNotifier>(context,listen: false);
    Navigator.pop(context);
    supplementNotifier.addSupplement(supplement);

  }

  _saveSupplement()  {

    if(!_formkey.currentState.validate()){
      return;
    }


    _formkey.currentState.save();
    print('form was saved');

    print(_currentSupplement.BrandName);

    print(_currentSupplement.category);
    print(_currentSupplement.ExpDate);

    uploadSupplements(_currentSupplement,_onSupplementUploaded);

    return Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'AddStock',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          autovalidate: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 20),
            child: Column(
              children: <Widget>[
                _buildName(),
                _BuildCategory(),
                _BuildQuantity(),
                _BuildAmount(),
                _BuildExpDate(),
                SizedBox(height: 20,),
             RaisedButton(
               child: Text(
                 'Save',
               ),
               onPressed: () async {
                 _saveSupplement();
               },
             ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
