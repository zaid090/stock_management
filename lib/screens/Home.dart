

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/screens/add_supplement.dart';
import 'package:stock_management/screens/details.dart';
import 'package:stock_management/services/api.dart';
import 'package:stock_management/services/firebase_auth.dart';
import 'package:stock_management/services/supplementNotifier.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    SupplementNotifier supplementNotifier = Provider.of<SupplementNotifier>(context,listen: false);
    getSupplements(supplementNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    SupplementNotifier supplementNotifier = Provider.of<SupplementNotifier>(context);
    Future<void> _refreshList() async {
      getSupplements(supplementNotifier);
    }
    print('building feed');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          authNotifier.user != null ? authNotifier.user.displayName : 'Feed',
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon:Icon( Icons.arrow_back_ios,),
            onPressed: () => signout(authNotifier),
          ),
        ],
      ),

      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueAccent,Colors.red],
          ),
        ),
        child: new RefreshIndicator(
          child: ListView.separated(itemBuilder: (BuildContext context,int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(

                title: Text(supplementNotifier.supplementList[index].BrandName,
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                 subtitle: Text(supplementNotifier.supplementList[index].ExpDate.toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),),
                onTap: () {
                  supplementNotifier.currentSupplement =
                  supplementNotifier.supplementList[index];
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext) {
                        return SupplementDetails();
                      }));
                },

              ),
            );

          },
             itemCount: supplementNotifier.supplementList.length,
              separatorBuilder: (BuildContext context,int index){
              return Divider(color: Colors.black,);
            },
          ),
          onRefresh: _refreshList,
        ),
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: (){supplementNotifier.currentSupplement = null;
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return AddSupplement();
            }));
          },
          child: Icon(Icons.add,),
          ),
    );
  }
}
