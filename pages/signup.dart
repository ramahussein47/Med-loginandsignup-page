import'package:flutter/material.dart';
import 'package:medicine/Json%20Models/users.dart';
import'package:medicine/pages/Login.dart';
import 'package:medicine/pages/SqLite.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey=GlobalKey<FormState>();
  final userName=TextEditingController();
  final password=TextEditingController();
  final confirmpassword=TextEditingController();
  bool _visible=false;
   bool _visibleconfirm=false;


  @override
  Widget build(BuildContext context) {
   return Scaffold(

      body: Center(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                         const  ListTile(
                                  title: Text("Register  New Account",
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),),
                          ),
                    const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:  TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter your Name';
                          }
                          return null;

                        },


                          controller:userName,

                                              decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'userName',
                          icon: Icon(Icons.person_2_rounded),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),

                      ),
                      child:  TextFormField(

                         validator: (value){
                          if(value!.isEmpty){
                            return 'Please Enter your password';
                          }
                          return null;

                        },
                        obscureText: _visible,
                        controller: password,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Password',

                          icon: const Icon(Icons.lock_outline),
                          suffix: IconButton(onPressed: (){
                            setState((){
                              _visible=!_visible;

                            });
                          }, icon: Icon( _visible? Icons.visibility:Icons.visibility_off),),


                        ),
                      ),

                    ),


                  ),
                  const  SizedBox(height: 16.0),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),

                      ),
                      child:  TextFormField(
                         validator: (value){
                          if(value!.isEmpty){
                            return 'Password Does not match!';
                          }

                          else if (password.text!=confirmpassword.text){
                              return 'Password does not Match!';

                          }
                          return null;

                        },
                        obscureText: _visibleconfirm,
                        controller: confirmpassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Confirm Password',

                          icon: const Icon(Icons.lock_outline),
                          suffix: IconButton(onPressed: (){
                            setState((){
                              _visibleconfirm=!_visibleconfirm;

                            });
                          }, icon: Icon( _visibleconfirm? Icons.visibility:Icons.visibility_off),),


                        ),
                      ),

                    ),


                  ),
                 const  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(8) ,

                          color: Colors.black.withBlue(40),


                    ),
                    child: TextButton(
  onPressed: () {
    if (formkey.currentState!.validate()) {
      final db = DatabaseHelper();
      db.signup(User(userName: userName.text, password: password.text))
          .then((result) {
        // 'result' is the value returned by db.signup (the inserted row id)
        print('User signed up with ID: $result');
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const  Login()));
      })
          .catchError((error) {
        // Handle errors here
        print('Error during signup: $error');
        // You might want to show an error message to the user
      });
    }
  },
  child:const  Text(
    "Create Account",
    style: TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.white,
    ),
  ),
),



                  ),
                 const  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [


                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));


                      }, child:const  Center(child: Text('Back to LoginPage?')),),

                    ],
                  )
                ],
              ),
            ),


          ),

        ),
      ),
    );
  }
}
