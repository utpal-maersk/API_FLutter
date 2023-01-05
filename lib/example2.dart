import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

String ?stringResponse;
Map?mapResponse;
Map?mapData;
List?listResponse;

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  State<Example2> createState() => _Example2State();
}


class _Example2State extends State<Example2> {

  Future apiCall ()async{
    http.Response response;
    response= await http.get(Uri.parse('https://reqres.in/api/users?page=2')) ;
    if(response.statusCode==200){
      setState(() {
        //stringResponse=response.body;
        mapResponse=jsonDecode(response.body);
        //mapData=mapResponse!['data'];
        listResponse=mapResponse!['data'];
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Demo 2'),
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context,index){
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(listResponse![index]['avatar']),
                  Text('Id  : '+listResponse![index]['id'].toString(),style:
                  TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Text('First Name : '+listResponse![index]['first_name'].toString()),
                  Text('Last Name : '+listResponse![index]['last_name'].toString()),
                  Text('Email : '+listResponse![index]['email'].toString()),


                ],
              ),
            ),

          );
        },
          itemCount: listResponse==null?0:listResponse?.length,
        )
      ),
    );
  }
}
