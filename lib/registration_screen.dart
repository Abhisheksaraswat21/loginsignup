import 'package:demo/home_screen.dart';
import 'package:demo/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  //form key
  final _formkey = GlobalKey<FormState>();

//text box se text lene ke liye
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
//FOR FIRSTNAME ----

    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
// The type of keyboard to use for editing the text.
// Defaults to TextInputType.text if maxLines is one and TextInputType.multiline otherwise.

//validator: {} (),
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        //ye check krega ki atleat 3characters to ho

        if (value!.isEmpty) {
          return ("First Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Name (Min. 3 characters)");
          //min 6 characters are required for firebase to cereate an account with email and
          //password
        }
        return null;
      },

      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.next,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//FOR SECOND NAME ---

    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
// The type of keyboard to use for editing the text.
// Defaults to TextInputType.text if maxLines is one and TextInputType.multiline otherwise.

//validator: {} (),
      validator: (value) {
        if (value!.isEmpty) {
          return ("First Name cannot be empty");
        }
      },

      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.next,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//EMAIL FIELD

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.next,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//PASSWORD ----

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,

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
        passwordEditingController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.next,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//CONFIRM PASSWORD FIELD ---

    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
// The type of keyboard to use for editing the text.
// Defaults to TextInputType.text if maxLines is one and TextInputType.multiline otherwise.

//validator: {} (),
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            confirmPasswordEditingController.text ) {
          //incase password 6 se chota hai and match ni krra value se

          return "Password don't match";
        }
        return null;
      },

      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
//this willl be saving a value whenever a user is tapp ing in the field
//An optional method to call with the final value when the form is saved via FormState.save.

      textInputAction: TextInputAction.done,
      //whenever we will be cilcking the email input field , we will be getitng a next button on the
      //low right bottom  of the screen..ye keyboard ke right bottom me aata hai

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final signUpButton = Material(
        elevation: 5,
//dnt know

        borderRadius: BorderRadius.circular(30),
        color: Colors.redAccent,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            //now its width will be equal to our column ..ye samjh ni aaya clearly
            onPressed: () {
              signUp(
                  emailEditingController.text, passwordEditingController.text);
            },
            child: Text(
              "SignUp",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    return Scaffold(
//scsaffold return hora hai yhya pe..iske properties pdo aur ye samajh aajayega easy hai

      backgroundColor: Colors.white,

      appBar: AppBar(

//appbar is basically top bar of scaffold and here we are creating a back button

          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.red),
              onPressed: () {
                //this will take back to the root screen
                ////mtlb ki login page pe wapas bhej dega
                Navigator.of(context).pop();
              })),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    key: _formkey,
                    //this is validation of form key
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //for column main is vertical line
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //for column cross is horizontal line

                        children: <Widget>[
                          SizedBox(
                              height: 180,
                              child: Image.asset(
                                "assets/logo.png",
                                fit: BoxFit.contain,
                              )),
                          SizedBox(height: 45),
//ye bas humne icon email box aur password is sbke beech me spacing dene ke liye
//create kia hua hai
                          firstNameField,
                          SizedBox(height: 20),

                          secondNameField,
                          SizedBox(height: 30),

                          emailField,
                          SizedBox(height: 20),

                          passwordField,
                          SizedBox(height: 20),

                          confirmPasswordField,
                          SizedBox(height: 25),

                          signUpButton,
                          SizedBox(
                            height: 15,
                          )
                        ])),
              )),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
//if validation of formkey is successful, then we have to wait for authentication

      await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => 
                //we created a funtion to store details on firestore
               {postDetailsToFirestore()})
              
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

 postDetailsToFirestore() async {
//calling our firestore
//calling our user models
//sending these values

//calling our firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    //this will be our current user

    //calling our user models

    UserModel userModel = UserModel();
   // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;







//here user is current user and we are setting values in the database

     await firebaseFirestore
        .collection("users")
//this will create a collection of users
        .doc(user.uid)
        //it will so in the uid of users
        //it will go to this document id

         .set(userModel.toMap());
    //isse sara data store hojayega jo bhi upar specify kia hai humne
    //ye tomap se data store krra hai

  Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
       MaterialPageRoute(builder: (context) => const HomeScreen()),
        //ye hume homescreen pe bhejega
         (route) => false);
  }
}

