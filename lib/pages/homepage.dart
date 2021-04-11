import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:venue/models/venue.dart';
import 'dart:convert';

import 'package:venue/search/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading=false;

//  String url = "http://10.0.2.2:8000/venues/?format=json";

  String url = "http://192.168.1.69:8000/venues";

  Future<List<Venue>> fetchVenue() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Venue> venue = parseRequestVenues(response.body);
        return venue;
      } else {
        failed();
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void failed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not load "),
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


  List<Venue> parseRequestVenues(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed
          .map<Venue>((json) => Venue.fromJson(json))
          .toList();
    }
  }

  List<Venue> venue = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchVenue().then((venuesFromServer) {
      setState(() {
        isLoading = false;
        venue = venuesFromServer;
      });
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchVenue();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),onPressed: (){

              showSearch(context: context, delegate: SearchVenue(venue));

            })
          ],

          title: Text('Venue',style: TextStyle(
            fontSize: 25.0,fontFamily: "Ropa",
          ),),
          centerTitle: true,
          backgroundColor: Color(0XFFF59C16),
        ) ,
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: _getData,
          child: venue.isEmpty ? Center(child: Text("No venue found")) : ListView.builder (
            itemCount: venue == null ? 0 : venue.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: ListTile(
                      title: Text("${venue[index].venueName}"),
                      subtitle: Text("${venue[index].address}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      VenueDetailPage(venue[index])));
                        }


                    ),
                  ),
                ],
              );
            },
          ),
        )
    );
  }
}

