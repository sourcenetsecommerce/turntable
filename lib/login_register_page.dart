import 'package:flutter/material.dart';
import 'authentication.dart';
import 'dialogbox.dart';

class LoginRegisterPage extends StatefulWidget
{
  LoginRegisterPage
  ({
    this.auth,
    this.onSignedIn,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState()
  {
    return _LoginRegisterState();
  }

}

enum FormType
{
  login,
  register
}

class _LoginRegisterState extends State<LoginRegisterPage>
{
  DialogBox dialogBox = new DialogBox();

  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";


  // Methods 
  bool validateAndSave()
  {
    final form = formKey.currentState;

    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }

  }

  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
        {
          String userID = await widget.auth.signIn(_email, _password);
          // dialogBox.information(context, "Congratulations", "Your have lgged in successfully.");
          print("login userId" +userID);
        }
        else
        {
          String userID = await widget.auth.signUp(_email, _password);
          // dialogBox.information(context, "Congratulations", "Your account has been created successfully.");
          print("Register userId" + userID);

        }

        widget.onSignedIn();

      }
      catch(e)
      {
        dialogBox.information(context, "Error = ", e.toString());
        print("Error = " + e.toString() );

      }
    }


  }

  void moveToRegister()
  {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });

  }

    void moveToLogin()
  {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });

  }
  // Design
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      resizeToAvoidBottomPadding: true,
      appBar: new AppBar
      (
        title: new Text(""),
      ),

      body: new Container
      (
        margin: EdgeInsets.all(15.0),

        child: new Form
        (
         key: formKey,
         child: new ListView
         (
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
           children: createInputs() + createButtons(),

           ),
         ),
      ),
      
    );
    
  }

  List<Widget> createInputs()
  {
    return 
    [
      SizedBox(height:10.0,),
      logo(),
      SizedBox(height:20.0,),

      new TextFormField
      (
        decoration: new InputDecoration(labelText:'Email Address'),
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        
        validator: (value)
        {
          return value.isEmpty ? 'Please enter email address...': null;
        },
        onSaved: (value)
        {
          return _email = value;
        },
      ),

      SizedBox(height:10.0,),

      new TextFormField
      (
        decoration: new InputDecoration(labelText:'Password'),
        obscureText: true,

          validator: (value)
        {
          return value.isEmpty ? 'Please enter your password...': null;
        },
        onSaved: (value)
        {
          return _password = value;
        },
      ),

      SizedBox(height:20.0,),

    ];
  }

  Widget logo()
  {
    return new Hero
    (
      tag: 'hero',
      child: new CircleAvatar
      (
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('assets/app_logo.png'),
      ),
    );
  }
    List<Widget> createButtons()
  {
    if(_formType == FormType.login)
    {
              return 
            [
              new RaisedButton
              (
                child: Text('Sign In', style: new TextStyle(fontSize: 20.0),),
                textColor: Colors.white,
                color: Colors.black,
                onPressed: validateAndSubmit,
              ),
              new FlatButton
              (
                child: Text('New User? Create account', style: new TextStyle(fontSize: 14.0),),
                textColor: Colors.red,
                onPressed: moveToRegister,
              ),
            ];
    }
    else
    {
                return 
              [
                new RaisedButton
                (
                  child: Text('Register', style: new TextStyle(fontSize: 20.0),),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: validateAndSubmit,
                ),
                new FlatButton
                (
                  child: Text('Already have an account? login now', style: new TextStyle(fontSize: 14.0),),
                  textColor: Colors.red,
                  onPressed: moveToLogin,
                ),
              ];
    }
  }
}