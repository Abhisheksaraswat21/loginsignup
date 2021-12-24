import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/home_screen.dart';
import 'package:demo/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// form key
//useful for validation of email and password when login krra hoga user

  final _formKey = GlobalKey<FormState>();
//ye vaildation ke liye hota hai..ye ese hi hota hai
//isse hume errors mil jayegnege in case koi password ya username me gadbad hoogi to

  //editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  ///ye text box se data store krne ke liye hote hai

//FIREBASE ---
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
//email field ----

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
// The type of keyboard to use for editing the text.
// Defaults to TextInputType.text if maxLines is one and TextInputType.multiline otherwise.

//validator: {} (),

      validator: (value) {
        //validator is having a value like onsave is having
        if (value!.isEmpty) {
          return ("Please enter your email");
        }

        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },

      onSaved: (value) {
        emailController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.next,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//password field ---

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      //whenever user is entering password..it is not displayed diredctly..it will
      //be in dots

//validator: {} (),

      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Characters)");
          //min 6 characters are required for firebase to cereate an account with email and
          //password
        }
      },

      onSaved: (value) {
        passwordController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.done,

      //whenever we will be cilcking the password input field , we will be getitng a done button on the
      //low right bottom  of the screen...ye keyboard me right left me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginButton = Material(
        elevation: 5,
//dnt know

        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            //now its width will be equal to our column ..ye samjh ni aaya clearly



            onPressed: () {signIn(emailController.text, passwordController.text);},
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    return Scaffold(
//scsaffold return hora hai yhya pe..iske properties pdo aur ye samajh aajayega easy hai

        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    //this is validation of form key
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //for column main is vertical line
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //for column cross is horizontal line

                        children: <Widget>[
                          SizedBox(
                              height: 200,
                              child: Image.asset(
                                "assets/logo.png",
                                fit: BoxFit.contain,
                              )),
                          SizedBox(height: 45),
//ye bas humne icon email box aur password is sbke beech me spacing dene ke liye
//create kia hua hai
                          emailField,
                          SizedBox(height: 25),

                          passwordField,
                          SizedBox(height: 35),

                          loginButton,
                          SizedBox(height: 15),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Dont Have an account?"),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationScreen()));
                                    //onclicking it will take to the registration page
                                  },
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ),
                              ])
                        ]),
                  )),
            ),
          ),
        ));
  }

//LOGIN FUNCTION

  void signIn(String email, String password) async
//we will have an email and password here

  {
    if (_formKey.currentState!.validate())
    //if validation is okay then we will execute this

    {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
//when login is succsss we will call navigator
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())),
                //successful login hote hi it is passed to homescreen

                //auth abhi texteditingcontroller ke niche banaya tha firebase se connect krte time
                //.then means tha if login is successful we wll pass thus uid (userid)
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        //ye message show hoga uncase of error
      });
    }
  }
}
