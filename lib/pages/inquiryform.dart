import 'package:flutter/material.dart';
import 'package:venue/pages/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:venue/models/design.dart';


class InquiryForm extends StatefulWidget {
  @override
  _InquiryFormState createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {


//  final _book_name = TextEditingController();
//  final _author_name = TextEditingController();
//  final _book_publication = TextEditingController();
//  final _book_edition = TextEditingController();

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
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.red,
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
                    height: MediaQuery.of(context).size.height*0.9,
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        TextField(
//                          controller: _book_name,
                          decoration: textInputDecoration.copyWith(hintText: 'Form1'),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
//                          controller: _author_name,
                          decoration: textInputDecoration.copyWith(hintText: 'Form2'),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
//                          controller: _book_publication,
                          decoration: textInputDecoration.copyWith(hintText: 'Form3'),
                        ),
                        SizedBox(height: 30.0),
                        TextField(
//                          controller: _book_edition,
                          decoration: textInputDecoration.copyWith(hintText: 'Form4'),
                        ),
                        SizedBox(height: 30.0),
                        SizedBox(
                          width: 100.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: addData,
                            color: Colors.red,
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
    String url = "";
//    String url = "http://${Server.ipAddress}/public/api/requestbook";
    await http
        .post(url,
        headers: {'Accept': 'application/json'},
        body: ({
//          "book_name": _book_name.text,
//          "author_name": _author_name.text,
//          "book_publication": _book_publication.text,
//          "book_edition": _book_edition.text,
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
