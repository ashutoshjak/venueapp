import 'package:flutter/material.dart';
import 'package:venue/models/ipaddress.dart';
import 'package:venue/pages/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:venue/models/design.dart';


class InquiryForm extends StatefulWidget {


  @override
  _InquiryFormState createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {

  //user_name email contact venue_name request_description


  final _user_name = TextEditingController();
  final _email = TextEditingController();
  final _contact = TextEditingController();
  final _venue_name = TextEditingController();
  final _request_description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },),

          title: Text('Inquiry Form',style: TextStyle(
            fontSize: 25.0, fontFamily: "Ropa",
          ),),
          centerTitle: true,
          backgroundColor: custom_color,
        ),
        backgroundColor: custom_color,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40)
                  ),
                ),

                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextField(

                          controller: _user_name,
                          decoration: textInputDecoration.copyWith(hintText: 'User Name' ),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _email,
                          decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _contact,
                          decoration: textInputDecoration.copyWith(hintText: 'Contact'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _venue_name,
                          decoration: textInputDecoration.copyWith(hintText: 'Venu Name'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _request_description,
                          decoration: textInputDecoration.copyWith(hintText: 'Description'),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: addData,
                            color: custom_color,
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white,fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  void addData() async {
//    String url = "";
    String url = "http://${Server.ipAddress}/inquiry/";
    await http
        .post(url,
        headers: {'Accept': 'application/json'},
        body: ({
          "user_name": _user_name.text,
          "email": _email.text,
          "contact": _contact.text,
          "venue_name": _venue_name.text,
          "request_description": _request_description.text,
        }))
        .then((response) {
      if (response.statusCode == 201) {
        success();
      } else {
        failed();
      }
    });
  }

  void success() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Submitted Sucessfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void failed() {
//    var context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not add "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
