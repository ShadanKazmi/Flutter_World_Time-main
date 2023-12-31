import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{

  String location; //location name
  String? time; //current time
  String flag; //url asset
  String url; // location url endpoint
  bool? isDaytime; //time check

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try{
      //  Make a request
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map<String,dynamic> data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datetime);
      // print(offset);

      //  Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour < 6 && now.hour > 19 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('Error found : $e');
      time = 'Could Not Fetch Time Data';
    }

  }
}

