import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/models/user.dart';
import 'package:stock_management/services/api.dart';
import 'package:stock_management/services/firebase_auth.dart';


enum AuthMode {Signup,Login}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override

  void initState(){
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen: false);
   initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm(){
    if(!_formkey.currentState.validate()){
      return;
    }

    _formkey.currentState.save();

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context,listen: false);

    if(_authMode==AuthMode.Login){
      login(_user,authNotifier);
    }else{
      signup(_user,authNotifier);
    }
  }

  Widget _buildDisplayNameField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        labelText: "Display Name",
        labelStyle: TextStyle(
          color: Colors.white
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
        _user.name = value;
      },
    );
  }

  Widget _buildEmailField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        labelText: "Email",
        labelStyle: TextStyle(
            color: Colors.white
        ),
      ),
      cursorColor: Colors.white,
      validator: (String value){
        if(value.isEmpty){
          return 'Email Required';
        }
        return null;
      },
      onSaved: (String value){
        _user.mail = value;
      },
    );
  }

  Widget _buildPasswordField(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        labelText: "password",
        labelStyle: TextStyle(
            color: Colors.white
        ),
      ),
      cursorColor: Colors.white,
      controller: _passwordController,
      validator: (String value){
        if(value.isEmpty){
          return 'Password Required';
        }
        if(value.length <5 || value.length > 12){
          return 'Password must be between 5 and 12 characters';
        }
        return null;
      },
      onSaved: (String value){
        _user.password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override

  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      body: Container(
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
        //decoration: BoxDecoration(color: Colors.white),
        child: Form(
          autovalidate: true,
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
                child: Column(
                    children: <Widget>[
                      //Image.asset('assets/images.png'),
                      Text(
                        "Please Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 36, color: Colors.white),
                      ),
                      SizedBox(height: 32),
                      _authMode == AuthMode.Signup ? _buildDisplayNameField() : Container(),
                      _buildEmailField(),
                      _buildPasswordField(),
                      _authMode == AuthMode.Signup ? _buildConfirmPasswordField() : Container(),
                      SizedBox(height: 32),
                      ButtonTheme(
                        minWidth: 200,
                        child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _authMode =
                              _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      ButtonTheme(
                        minWidth: 200,
                        child: RaisedButton(
                          padding: EdgeInsets.all(10.0),
                          onPressed: () => _submitForm(),
                          child: Text(
                            _authMode == AuthMode.Login ? 'Login' : 'Signup',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),


            ),
          ),
        ),
      ),
    );
  }
}

