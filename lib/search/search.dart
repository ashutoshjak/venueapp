import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venue/models/design.dart';
import 'package:venue/models/venue.dart';
import 'package:http/http.dart' as http;
import 'package:venue/pages/homepage.dart';
import 'package:venue/pages/inquiryform.dart';

class SearchVenue extends SearchDelegate {
  List<Venue> ven;

  SearchVenue(this.ven);

  bool isLoading = true;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final suggestionList = query.isEmpty
        ? ven
        : ven
            .where((element) =>
                element.venueName.toString().toLowerCase().startsWith(query) ||
                element.district.toString().toLowerCase().startsWith(query) ||
                element.address.toString().toLowerCase().startsWith(query) ||
                element.price.toString().toLowerCase().startsWith(query))
            .toList();

    return query.isEmpty
        ? Center(
            child: Image.asset("assets/images/venue.png",
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7))
        : suggestionList.isEmpty
            ? Center(child: Text("Venue not Found"))
            : ListView.builder(
                itemCount: suggestionList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  VenueDetailPage(suggestionList[index])));
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "\tVenue Name: ${suggestionList[index].venueName}\n"),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                              "\tDistrict: ${suggestionList[index].district}\n"),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text("\tAddress: ${suggestionList[index].address}\n"),
                        ],
                      ),
//            child: ListTile(
//                title: Text("Venue Name: ${suggestionList[index].venueName}"),
//                subtitle: ListTile(
//                 title:  Text(
//                    "District: ${suggestionList[index].district}",),
//                  subtitle:Text(
//                    "Address: ${suggestionList[index].address}",),
//                ),
//                onTap: () {
//                  Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                          builder: (context) =>
//                              VenueDetailPage(suggestionList[index])));
//                }
//                ),
                    ),
                  );
                });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

//    only added this
    return query.isEmpty
        ? Center(
            child: Image.asset("assets/images/venue.png",
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.height * 1.5))
        : buildResults(context);
  }
}

class VenueDetailPage extends StatelessWidget {
  final Venue venu;

  VenueDetailPage(this.venu);
  String name, district, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: custom_color,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Venue Detail",
                style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Card(
            elevation: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  venu.image,
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 1,
                ),
                SizedBox(
                  height: 5,
                ),
               Card(
                 elevation: 5.0,
                 color: Colors.white70,
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: <Widget>[
                       Row(
                         children: <Widget>[
                           Text(
                             "\t\t\tVenue Name : ",
                             style: TextStyle(
                               fontSize: 19.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Expanded(
                             child: Text(
                               venu.venueName,
                               style: TextStyle(
                                 fontSize: 18.0,
                               ),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(
                         height: 10,
                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "\t\t\tDistrict : ",
//                             style: TextStyle(
//                               fontSize: 19.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             venu.district,
//                             style: TextStyle(
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
                       Row(
                         children: <Widget>[
                           Text(
                             "\t\t\tAddress : ",
                             style: TextStyle(
                               fontSize: 19.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(
                             venu.address,
                             style: TextStyle(
                               fontSize: 18.0,
                             ),
                           ),
                         ],
                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "\t\t\tOpening Time : ",
//                             style: TextStyle(
//                               fontSize: 19.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             venu.openTime.toString(),
//                             style: TextStyle(
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "\t\t\tClosing Time : ",
//                             style: TextStyle(
//                               fontSize: 19.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             venu.closingTime.toString(),
//                             style: TextStyle(
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "\t\t\tPrice : ",
//                             style: TextStyle(
//                               fontSize: 19.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text("NRs" + "\t" +
//                               venu.price.toString(),
//                             style: TextStyle(
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ],
//                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Row(
                         children: <Widget>[
                           Text(
                             "\t\t\tContact : ",
                             style: TextStyle(
                               fontSize: 19.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(
                             venu.contact.toString(),
                             style: TextStyle(
                               fontSize: 18.0,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 5.0,
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: <Widget>[
                       Text(
                         "\t\t\tDescription : ",
                         style: TextStyle(
                           fontSize: 19.0,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       SizedBox(
                         height: 8,
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left: 40),
                         child: Text(
                           venu.description,
                           style: TextStyle(fontSize: 18.0),
                         ),
                       ),
                     ],
                    ),
                  ),
                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  children: <Widget>[
//                    Text(
//                      "\t\t\tWebsite : ",
//                      style: TextStyle(
//                        fontSize: 19.0,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    Expanded(
//                      child: Text(
//                        venu.website.toString(),
//                        style: TextStyle(
//                          fontSize: 18.0,
//                        ),
//                      ),
//                    ),
//
//                  ],
//                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 250.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new InquiryForm()));
                      },
                      color: custom_color,
                      child: Text(
                        'Inquiry Form',
                        style: TextStyle(color: Colors.white ,fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
