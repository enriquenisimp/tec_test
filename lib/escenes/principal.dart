import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:tec_test/objects/family.dart';
import 'package:tec_test/useful/hexcolor.dart';
import 'package:tec_test/useful/network.dart';

class Principal extends StatefulWidget {
  Principal({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  var url = 'https://haven-tech-test.s3-eu-west-1.amazonaws.com/tech+test+json.json';
  Future<FamilyList> data;
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network = Network(url);
    data = network.loadPost();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Material(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100
          ),
          child:  FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<FamilyList> snapshot){
                List<Family> allPost;
                if(snapshot.hasData){
                  allPost = snapshot.data.familys;
                  return createListView(allPost, context);
                }else{
                  return CircularProgressIndicator();
                }

              }
          ),
        ),
      ),

    );
  }
  Widget card_family(Family family, BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18.0),
                  ),),
              elevation: 3.0,

                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:12.0, right: 20.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.blueGrey
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.child_friendly, size: 40, color: Colors.white, ),
                          )),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only( top: 8.0),
                            child: Text(
                              "Family Id: ${family.familyid}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Text(" Caravan: ${
                                      family.caravan}",

                                    ),
                                  ),
                                  Icon(Icons.directions_car, color: Colors.blueGrey,size: 18,),
                                ],
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Text(" Group Size: ${
                                        family.groupsize}",
                                    ),
                                  ),
                                  Icon(Icons.control_point_duplicate, color: Colors.blueGrey,size: 18,),
                                ],
                              )
                          )
                        ]),
                  ],
                ),

            ),

        onTap: () =>{}
        );
  }
 Widget createListView(List<Family> data, BuildContext context)
  {
    return Container(
      child: ListView.builder(

          itemCount: data.length,
          itemBuilder: (context, int index){
            return Column(
              children: <Widget>[
                Divider(height: 5.0, color: HexColor("#00000000"),),
                card_family(data[index], context)
              ],
            );
          }),
    );
  }

}
