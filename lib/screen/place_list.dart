import 'package:flutter/material.dart';
import 'package:gtplace/provider/place_provider.dart';
import 'package:gtplace/screen/add_place.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greate Place'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false)
            .fetchAndSetData(),
        builder: (ctx, dataSnapshot) =>
            dataSnapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Consumer<PlaceProvider>(
                    builder: (context, place, chiild) {
                      return ListView.builder(
                          itemCount: place.places.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(place.places[index].image),
                              ),
                              title: Text(place.places[index].title),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await place.deleteData(
                                              place.places[index].id);
                                        }),
                                    IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {}),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
      ),
    );
  }
}
