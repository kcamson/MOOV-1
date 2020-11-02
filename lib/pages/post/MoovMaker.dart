// import 'dart:io';

import 'package:MOOV/models/post_model.dart';
import 'package:MOOV/pages/home/HomePage.dart';
// import 'package:MOOV/pages/google_sign_in.dart';
import 'package:MOOV/services/database.dart';
// import 'package:MOOV/widgets/date_picker.dart';
// import 'package:MOOV/widgets/dateform.dart';
// import 'package:MOOV/widgets/image_picker.dart';
// import 'package:MOOV/widgets/time_picker.dart';
// import 'package:MOOV/widgets/time_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:MOOV/utils/themes_styles.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:MOOV/widgets/inherited_widgets/inherited_post_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class MoovMaker extends StatefulWidget {
  final PostModel postModel;

  MoovMaker({Key key, @required this.postModel}) : super(key: key);
  @override
  _MoovMakerState createState() => _MoovMakerState();
}

class _MoovMakerState extends State<MoovMaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        backgroundColor: TextThemes.ndBlue,
        //pinned: true,

        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/moovheader.png',
                fit: BoxFit.cover,
                height: 45.0,
              ),
              Image.asset(
                'lib/assets/ndlogo.png',
                fit: BoxFit.cover,
                height: 25,
              )
            ],
          ),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("The MOOV Maker", style: TextThemes.headline1),
              ),
              MoovMakerForm(),
            ]),
      )),
    );
  }
}

class MoovMakerForm extends StatefulWidget {
  MoovMakerForm({Key key}) : super(key: key);

  @override
  _MoovMakerFormState createState() => _MoovMakerFormState();
}

class _MoovMakerFormState extends State<MoovMakerForm> {
  // File _image;
  final picker = ImagePicker();

  Future handleTakePhoto() async {
    Navigator.pop(context);
    // final file = await picker.getImage(
    //   source: ImageSource.camera,
    //   maxHeight: 675,
    //   maxWidth: 960,
    // );
    // setState(() {
    //   if (_image != null) {
    //     _image = File(file.path);
    //   }
    // });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    // final file = await picker.getImage(
    //   source: ImageSource.gallery,
    //   maxHeight: 675,
    //   maxWidth: 960,
    // );
    // setState(() {
    //   _image = File(file.path);
    // });
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create Post"),
          children: <Widget>[
            SimpleDialogOption(
                child: Text("Photo with Camera"), onPressed: handleTakePhoto),
            SimpleDialogOption(
                child: Text("Image from Gallery"),
                onPressed: handleChooseFromGallery),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  final listOfTypes = [
    "Food & Drinks",
    "Party & Hangouts",
    "Sport",
    "Show",
    "Study",
    "Gov",
    "Mass",
    "Volunteer",
    "Charity",
    "Tailgate",
    "Game",
    "Other"
  ];
  final listOfLocations = [
    "Off-Campus",
    "Alumni Hall",
    "Badin Hall",
    "Baumer Hall",
    "Breen-Phillips Hall",
    "Carroll Hall",
    "Cavanaugh Hall",
    "Dillon Hall",
    "Duncan Hall",
    "Dunne Hall",
    "Farley Hall",
    "Fisher Hall",
    "Flaherty Hall",
    "Howard Hall",
    "Keenan Hall",
    "Keough Hall",
    "Knott Hall",
    "Lewis Hall",
    "Lyons Hall",
    "McGlinn Hall",
    "MORRISSEY MANOR",
    "O'Neill Hall",
    "Pangborn Hall",
    "Pasquerilla East Hall",
    "Pasquerilla West Hall",
    "Ryan Hall",
    "St. Edwards's Hall",
    "Siegfried Hall",
    "Sorin Hall",
    "Stanford Hall",
    "Walsh Hall",
    "Welsh Family Hall",
    "Zahm Hall"
  ];

  DateTime currentValue = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(minutes: 120));
  String typeDropdownValue = 'Party';
  String locationDropdownValue = 'Off-Campus';
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = DatePicker().startDate1;
  final format = DateFormat("EEE, MMM d,' at' h:mm a");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.create,
                  color: TextThemes.ndGold,
                ),
                labelText: "Enter Event Title",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Event Title';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DropdownButtonFormField(
              value: typeDropdownValue,
              icon: Icon(Icons.arrow_downward, color: TextThemes.ndGold),
              decoration: InputDecoration(
                labelText: "Select Event Type",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfTypes.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  typeDropdownValue = newValue;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'What are we doing?';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.description,
                  color: TextThemes.ndGold,
                ),
                labelText: "Describe your MOOV",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return "What's going down?";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DropdownButtonFormField(
              value: locationDropdownValue,
              icon: Icon(Icons.arrow_downward, color: TextThemes.ndGold),
              decoration: InputDecoration(
                labelText: "Select Location",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: listOfLocations.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  locationDropdownValue = newValue;
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Select Event Type';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                icon: Icon(Icons.place, color: TextThemes.ndGold),
                labelText: "Enter Address or Room Number",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return "Where's it at though?";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DateTimeField(
              format: format,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_downward,
                    color: TextThemes.ndGold,
                  ),
                  labelText: 'Enter Start Time',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
              onChanged: (DateTime newValue) {
                setState(() {
                  currentValue = newValue;
                });
              },
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: TextThemes.ndGold,
                        accentColor: TextThemes.ndGold,
                        colorScheme:
                            ColorScheme.light(primary: TextThemes.ndBlue),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: TextThemes.ndGold,
                          accentColor: TextThemes.ndGold,
                          colorScheme:
                              ColorScheme.light(primary: TextThemes.ndBlue),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue.add(Duration(days: 18250));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DateTimeField(
              format: format,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_downward,
                    color: TextThemes.ndGold,
                  ),
                  labelText: 'Enter End Time',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
              onChanged: (DateTime et) {
                setState(() {
                  endTime = et;
                });
              },
              onShowPicker: (context, endTime) async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: endTime ?? DateTime.now(),
                  lastDate: DateTime(2100),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: TextThemes.ndGold,
                        accentColor: TextThemes.ndGold,
                        colorScheme:
                            ColorScheme.light(primary: TextThemes.ndBlue),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    );
                  },
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(endTime ?? DateTime.now()),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: TextThemes.ndGold,
                          accentColor: TextThemes.ndGold,
                          colorScheme:
                              ColorScheme.light(primary: TextThemes.ndBlue),
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child,
                      );
                    },
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return endTime.add(Duration(days: 18250));
                }
              },
            ),
          ),
          // RaisedButton(
          //     color: TextThemes.ndBlue,
          //     child: Text('Upload an image',
          //         style: TextStyle(color: Colors.white, fontSize: 22)),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0)),
          //     onPressed: () => selectImage(context)),
          // Container(
          //   height: 220,
          //   width: MediaQuery.of(context).size.width * .8,
          //   child: Center(
          //     child: AspectRatio(
          //       aspectRatio: 16 / 9,
          //       child: Container(
          //         decoration: BoxDecoration(
          //             image: DecorationImage(
          //                 fit: BoxFit.cover, image: FileImage(_image))),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.amber[300],
                      child: Text('Post!'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Database().createPost(
                              title: titleController.text,
                              type: typeDropdownValue,
                              description: descriptionController.text,
                              location: locationDropdownValue,
                              address: addressController.text,
                              startDate: currentValue,
                              endDate: endTime);
                          Navigator.pop(context);
                        }
                      }
                      // if (_formKey.currentState.validate() &&
                      //     typeDropdownValue == 'Party') {
                      //   Database().createPost(
                      //       title: titleController.text,
                      //       type: typeDropdownValue,
                      //       description: descriptionController.text,
                      //       location: locationDropdownValue,
                      //       address: addressController.text,
                      //       startDate: currentValue,
                      //       endDate: endTime);
                      // }

                      // if (_formKey.currentState.validate() &&
                      //     typeDropdownValue == 'Sport') {
                      //   Database().createPost(
                      //       title: titleController.text,
                      //       type: typeDropdownValue,
                      //       description: descriptionController.text,
                      //       location: locationDropdownValue,
                      //       address: addressController.text,
                      //       startDate: currentValue,
                      //       endDate: endTime);
                      // }

                      // if (_formKey.currentState.validate() &&
                      //     typeDropdownValue == 'Show') {
                      //   Database().createPost(
                      //       title: titleController.text,
                      //       type: typeDropdownValue,
                      //       description: descriptionController.text,
                      //       location: locationDropdownValue,
                      //       address: addressController.text,
                      //       startDate: currentValue,
                      //       endDate: endTime);

                      // dbRef.push().set({
                      //   "title": titleController.text,
                      //   "type": typeDropdownValue,
                      //   "description": descriptionController.text,
                      //   "location": locationDropdownValue,
                      //   "address": addressController.text,
                      // }).then((_) {
                      //   Scaffold.of(context).showSnackBar(
                      //       SnackBar(content: Text('Successfully Added')));
                      //   addressController.clear();
                      //   titleController.clear();
                      // }).catchError((onError) {
                      //   Scaffold.of(context)
                      //       .showSnackBar(SnackBar(content: Text(onError)));
                      // });

                      // if (_formKey.currentState.validate() &&
                      //     typeDropdownValue == 'Sport') {
                      //   Database().createSportPost(
                      //     title: titleController.text,
                      //     type: typeDropdownValue,
                      //     description: descriptionController.text,
                      //     location: locationDropdownValue,
                      //     address: addressController.text,
                      //     startDate: currentValue,
                      //     endDate: endTime,
                      //   );

                      // dbRef.push().set({
                      //   "title": titleController.text,
                      //   "type": typeDropdownValue,
                      //   "description": descriptionController.text,
                      //   "location": locationDropdownValue,
                      //   "address": addressController.text,
                      // }).then((_) {
                      //   Scaffold.of(context).showSnackBar(
                      //       SnackBar(content: Text('Successfully Added')));
                      //   addressController.clear();
                      //   titleController.clear();
                      // }).catchError((onError) {
                      //   Scaffold.of(context)
                      //       .showSnackBar(SnackBar(content: Text(onError)));
                      // });
                      ),
                ],
              )),
        ])));
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}

class DatePicker extends StatefulWidget {
  DatePicker({this.startDate1});
  DateTime startDate1 = DateTime.now();
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime startDate1 = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: startDate1,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year),
        lastDate: new DateTime(DateTime.now().year + 10));
    if (picked != null && picked.length == 2) {
      setState(() {
        startDate1 = picked[0];
        _endDate = picked[1];
      });
    } else if (picked.length == 1) {
      setState(() {
        startDate1 = picked[0];
        _endDate = picked[0];
      });
    }
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text("Location ${widget.postModel.title}"),
        RaisedButton(
          color: Colors.amber[300],
          child: Text("Select Dates"),
          onPressed: () async {
            await displayDateRangePicker(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "Start Date: ${DateFormat('EEE, MM/dd').format(startDate1).toString()}"),
                Text(
                    "End Date: ${DateFormat('EEE, MM/dd').format(_endDate).toString()}"),
              ],
            ),
          ),
        ),
        // RaisedButton(
        //   child: Text("Continue"),
        //   onPressed: () {
        //     widget.postModel.startDate = _startDate;
        //     widget.postModel.endDate = _endDate;
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               DatePicker(postModel: widget.postModel)),
        //     );
        //   },
        // ),
      ],
    );
  }
}
