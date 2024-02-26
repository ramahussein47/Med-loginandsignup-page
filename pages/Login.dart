import 'package:flutter/material.dart';
import 'package:medicine/Json%20Models/users.dart';
import 'package:medicine/pages/All_pages.dart';
import 'package:medicine/pages/SqLite.dart';
import 'package:medicine/pages/signup.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _visible=false;
  final userName=TextEditingController();
  final password=TextEditingController();
   final formkey=GlobalKey<FormState>();
   final db=DatabaseHelper();
   bool _Login=false;
   login() async {
      var response=await db.login(User(userName: userName.text, password: password.text));
      if(response==true){

        Navigator.push(context, MaterialPageRoute(builder: (context)=> Allpages()));
        if(!mounted)return;
      }// if the login credentials  are wrong display this message
      else{
         setState(() {
           _Login=true;
         });
      }
   }
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
                    Image.asset("assets/images/therapy.png",
                    width: 250,),
                    const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all()
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
                          labelText: 'Username',
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
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(8) ,

                          color: Colors.black.withBlue(40),


                    ),
                    child: TextButton(onPressed: (){
                      if(formkey.currentState!.validate()){
                         login();

                      }

                    }, child: const Text("Login",
                    style:  TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,

                    ),)),

                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      const Text('Dont have an Account ? ',style: TextStyle(
                        color: Colors.black,
                      ),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>const SignUp() ),);

                      }, child:const  Text('Sign Up'),)
                    ],
                  ),
                 _Login? const Text("Username or Passowrd is incorrect",
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,

                  ),):const SizedBox(height: 20,),



                ],
              ),
            ),


          ),

        ),
      ),
    );
  }
}
