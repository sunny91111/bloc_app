import 'package:http/http.dart';
import '../models/boredModel.dart';

class BoredService {
  Future<BoredModel> getBoredActivity() async {
    final response =
        await get(Uri.parse('https://www.boredapi.com/api/activity/'));
    final activity = boredActivityFromJson(response.body);
    return activity;
  }
}
