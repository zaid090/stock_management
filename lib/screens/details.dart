import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/models/supplement.dart';
import 'package:stock_management/services/supplementNotifier.dart';
import 'package:stock_management/services/api.dart';
import 'package:stock_management/screens/SellForm.dart';


class SupplementDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    SupplementNotifier supplementNotifier = Provider.of<SupplementNotifier>(context);

    _onSupplementSold(Supplement supplement)  {
            supplementNotifier.supplementSold(supplement,supplementNotifier.currentSupplement.Quantity);
    }

    _onSupplementDeleted(Supplement supplement){

      supplementNotifier.deleteSupplement(supplement);
    }





    return Scaffold(
      appBar: AppBar(
        title: Text(
          supplementNotifier.currentSupplement.BrandName.toString(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
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
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.4)
                ),
                child: Text('What is it :  ${supplementNotifier.currentSupplement.category.toString()}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Text('Stock Available : ${supplementNotifier.currentSupplement.Quantity.toString()}',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Text('Cost Price : ${supplementNotifier.currentSupplement.Amount.toString()}',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              RaisedButton(
                child: Text(
                    'Sell'
                ),
                onPressed:() async {

                  await  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return SellForm();
                  }));
                 supplementNotifier.currentSupplement.Quantity == 0 ? sellSupplement(supplementNotifier.currentSupplement,_onSupplementDeleted,_onSupplementSold) : sellSupplement(supplementNotifier.currentSupplement,_onSupplementDeleted,_onSupplementSold);

                // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
