import 'dart:ui';

import 'package:app/Business/house_bloc.dart';
import 'package:app/Model/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController bhk_controller = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _sqftController = TextEditingController();

  int counter = 0;
  int _resale = -1;

  Future<List<Location>> init(String val) async {
    // TODO: implement initState
    print("Hi");
    List<Location> locations = await locationFromAddress(val);
    print("Hi1");
    print(locations);
    return locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("House Prediction"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Predict House Price", style: TextStyle(
                          fontSize: 27, fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Column(
                    children: [

                      TextFormField(
                        controller: _sqftController,
                        decoration: InputDecoration(
                          labelText: '600',
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.red, width: 1.0)
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.blue, width: 1.0)
                          ),
                          hintText: 'Enter Square foot',

                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter some text";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 35,
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 100,
                                  child: TextFormField(
                                    controller: bhk_controller,
                                    decoration: InputDecoration(
                                      labelText: 'BHK',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 1.0)
                                      ),
                                      hintText: '2',
                                    ),
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  height: 30,
                                  minWidth: 10,
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (counter < 20) {
                                        counter++;
                                        bhk_controller.text = counter.toString();
                                      }
                                    });
                                  },

                                ),

                                MaterialButton(
                                  height: 30,
                                  minWidth: 10,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      if (counter > 0) {
                                        counter--;
                                        bhk_controller.text = counter.toString();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(

                                    height: 170,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Resale"),
                                        ListTile(
                                          title: const Text('yes'),
                                          leading: Radio(
                                            value: 1,
                                            groupValue: _resale,
                                            onChanged: (value) {
                                              setState(() {
                                                _resale = 1;
                                              });
                                            },),),
                                        ListTile(
                                          title: const Text('No'),
                                          leading: Radio(
                                            value: 0,
                                            groupValue: _resale,
                                            onChanged: (value) {
                                              setState(() {
                                                _resale = 0;
                                              });
                                            },),),
                                      ],),
                                  ),
                                ),
                              ],
                            )
                          ]

                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: _address,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.blue,
                                    width: 1.0)
                            ),
                            hintText: 'Gronausestraat 710, Enschede',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: ()async{

                  Data data;
                  List<Location> list = await init(_address.text);
                  setState(() {
                    if (_address.text.isNotEmpty &&
                        _sqftController.text.isNotEmpty && counter != 0 &&
                        _resale != -1) {


                      Data data = Data(
                          bhk: int.parse(bhk_controller.text),
                          resale: _resale,
                          sqft: int.parse(_sqftController.text),
                          lat: list[0].latitude,
                          long: list[0].longitude);
                      print("Hii122");
                      BlocProvider.of<HouseBloc>(context)
                          .add(HouseRequested(data: data));
                    }
                  });
                },
                    child: Text("Submit")),
                BlocBuilder<HouseBloc, HouseState>(
                  builder: (context, state) {
                    if(state is HouseLoading)  {
                      return CircularProgressIndicator();
                    }
                    else if(state is HouseSuccess){
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0,40,0,0),
                        child: Column(
                          children: [
                            Text("Predicted Price:", style: TextStyle(fontSize: 20,),),
                             Text("${state.predicted.toString()} Lacs",
                               style: TextStyle(fontSize: 50,),)
                          ],
                        ),
                      );
                    }
                    else if(state is HouseInitial){
                      return Text("");
                    }
                    else{
                      return Text("Error occured");
                    }
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}
// ,