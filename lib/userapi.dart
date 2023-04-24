import 'dart:convert';

import 'package:api_integration/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class UserApi extends StatefulWidget {
  const UserApi({super.key});

  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  List<UserModel> userModel = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Api'),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                itemCount: userModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 300,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getText(index, 'ID: ', userModel[index].id.toString()),
                        getText(
                            index, 'Name: ', userModel[index].name.toString()),
                        getText(index, 'Username:',
                            userModel[index].username.toString()),
                        getText(index, 'Email: ',
                            userModel[index].email.toString()),
                        getText(index, 'Phone: ',
                            userModel[index].phone.toString()),
                        getText(index, 'Website: ',
                            userModel[index].website.toString()),
                        getText(index, 'Company Name: ',
                            userModel[index].company.name.toString()),
                        getText(index, 'Company Type: ',
                            userModel[index].company.catchPhrase.toString()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Addres: ', style: TextStyle(fontSize: 16)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${userModel[index].address.street}, ${userModel[index].address.suite},',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                                Text(
                                    '${userModel[index].address.city} - ${userModel[index].address.zipcode}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Data Not Found!'),
              );
            }
          }),
    );
  }

  Text getText(int index, String fieldName, String content) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: fieldName, style: TextStyle(fontSize: 16)),
        TextSpan(
            text: content,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
      ]),
    );
  }

  Future<List<UserModel>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userModel.add(UserModel.fromJson(index));
      }
      return userModel;
    }
    return userModel;
  }
}
