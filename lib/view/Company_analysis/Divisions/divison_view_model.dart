
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/division_type_model.dart';
import '../../../respository/division_type_repository.dart';

class Division_view_model with ChangeNotifier {
  List<division_type_model> team = [];
   bool _isloading =false;
  bool get isLoading =>_isloading;
  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  num totalcompany = 0;
  bool showDateContainers = false;
  bool company = false;
  DateTime? startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? endDate=DateTime.now();
  final formatter=NumberFormat('#,###');
  String formattedTotals='';

  final List<Map<String, dynamic>> divisions = [
    {"name": "All", "sales": "\$1000", "image": "assets/p-solid.png", "color": Colors.blueAccent},
    {"name": "Pharma", "sales": "\$500", "image": "assets/c-solid.png", "color": Color(0xFF2FC89A)},
    {"name": "Consumer", "sales": "\$800", "image": "assets/f-solid.png", "color": Color(0xFFFAB718)},
    {"name": "FMCG", "sales": "\$1200", "image": "assets/p-solid.png", "color": Color(0xFFFD5E60)},
    {"name": "PCP", "sales": "\$700", "image": "assets/cart-shopping-solid.png", "color": Color(0xFF32AFFF)},
  ];



  Future<void> executeApiCall(String start, String end) async {

    setLoading( true);



    try {
      String startDateFormatted = DateFormat('yyyy,MM,dd').format(startDate!);
      String endDateFormatted = DateFormat('yyyy,MM,dd').format(endDate!);
      final result = await division_type_Repository().team_company_fetchData(startDateFormatted,endDateFormatted);

      // Process the result as needed
      print('API Result: $result');


        team = result;

        totalcompany = 0; // Reset total company sales
        for (int i = 0; i < team.length; i++) {
          totalcompany += team[i].sales;
        }
        formattedTotals = formatter.format(totalcompany); // Update formattedTotals here




    } catch (e) {
      setLoading(false);
      // Handle errors
      // setState(() {
      //   isLoading = false;
      //   showDateContainers=true;
      //   company=true;
      // });
      print('Error: $e');
    } finally {
      setLoading( false);
    }
  }

}