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


  final _venue_Name = TextEditingController();
  final _address = TextEditingController();
  final _district = TextEditingController();
  final _email = TextEditingController();
  final _contact = TextEditingController();
  final _desctription = TextEditingController();

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
            Flexible(
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
                          controller: _venue_Name,
                          decoration: textInputDecoration.copyWith(hintText: 'Venue Name'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _address,
                          decoration: textInputDecoration.copyWith(hintText: 'Address'),
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _district,
                          decoration: textInputDecoration.copyWith(hintText: 'District'),
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
                          controller: _desctription,
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
          "venueName": _venue_Name.text,
          "address": _address.text,
          "district": _district.text,
          "email": _email.text,
          "contact": _contact.text,
          "description": _desctription.text,
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
