import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../models/boredModel.dart';

class BoredService {
  Future<BoredModel> getBoredModel() async {
    try {
      final response =
      await get(Uri.parse('https://www.boredapi.com/api/activity'));
      final model = boredModelFromJson(response.body);
      return model;
    }
    catch(e){
      return BoredModel(activity: '', type: '', participants: 1, price: 0.0, link: '', key: '', accessibility: 0.1);
    }

  }
}
