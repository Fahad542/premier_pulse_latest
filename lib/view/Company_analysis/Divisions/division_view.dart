import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/model/division_type_model.dart';
import 'package:mvvm/respository/division_type_repository.dart';
import 'package:mvvm/view/Company_analysis/Divisions/divison_view_model.dart';
import 'package:mvvm/view/Company_analysis/compnay_analysis_view.dart';
import 'package:provider/provider.dart';
import '../../../res/components/round_button.dart';
import '../../../respository/measure_repository.dart';
import '../../../utils/Drawer.dart';
import '../../../utils/utils.dart';
import '../../Sales/Date.dart';

class division extends StatefulWidget {
  const division({Key? key}) : super(key: key);

  @override
  State<division> createState() => _DivisionState();
}


class _DivisionState extends State<division> {
 Division_view_model model =Division_view_model();

  @override
  void initState() {
    super.initState();
    final repository = measure_repository();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(

          title: const Text('Company Analysis'),
          backgroundColor: Colors.green[800],
          leading: Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              );
            },

          ),
          actions: [
            Visibility(

              child: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {


                    model.showDateContainers = !model.showDateContainers;
                  model.notifyListeners();

                },
              ),
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body:
    ChangeNotifierProvider<Division_view_model>(
    create: (BuildContext context) => model,
    child: Consumer<Division_view_model>(
    builder: (context, value, _) {

    return

        model.isLoading ? Padding(
          padding: const EdgeInsets.all(8.0),

          child: Center(child: CircularProgressIndicator(color: Colors.green[800],)),
        ) :
        WillPopScope(

          onWillPop: () async {
            return false;
          },
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => company_analysis(name: "Company", startdate: model.startDate, enddate: model.endDate,

                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child:
                              Visibility(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Flexible(
                                      child: DateContainer(
                                        title: "Start Date",
                                        range: "yyyy-MM-dd",
                                        selectedDate: model.startDate,
                                        isVisible: !model.showDateContainers  ,
                                        onDateSelected: (date) {
                                          setState(() {
                                            model.startDate= date;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.02,
                                    ), // Adjust the percentage as needed
                                    Flexible(
                                      child: DateContainer(
                                        title: "End Date",
                                        range: "yyyy-MM-dd",
                                        selectedDate: model.endDate,
                                        isVisible: !model.showDateContainers  ,
                                        onDateSelected: (date) async {
                                          setState(() {
                                            model.endDate = date;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF008000), // Dark Green
                                      Color(0xFF32CD32), // Green 600
                                    ],

                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/total_sales.png", height: 30, width: 30,color: Colors.white,),

                                        SizedBox(height: 20), // Add space at the top
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Text(
                                            "PSPL",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10, right: 10),
                                                child: Text(
                                                  "Total Sales: ${model.formattedTotals}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                ),
                                ),
                            ),




                            SizedBox(height: 20,),
                            Column(
                              children: model.team.map((item) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => company_analysis(
                                          name: item.Product_Class_Name.toString(),
                                          startdate: model.startDate,
                                          enddate: model.endDate,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Reusable(
                                    containerColor: model.divisions[model.team.indexOf(item)]["color"]!,
                                    imagePath: model.divisions[model.team.indexOf(item)]["image"]!,
                                    labelText: item.Product_Class_Name,
                                    labelColor: Colors.black,
                                    valueText: item.sales.toString(),
                                    valueColor: Colors.black,
                                    text: NumberFormat('#,###').format(double.tryParse(item.sales.toString().replaceAll(',', '')) ?? 0),
                                  ),
                                );
                              }).toList(),
                            ),




                            Visibility(
                                visible: !model.showDateContainers && !model.company ,
                                child: RoundButton(title: "Done", onPress: (){
    //                               if (model.startDate!.isBefore(model.endDate!))
    // {
    //   String startDateFormatted = DateFormat('yyyy,MM,dd').format(model.startDate!);
    //   String endDateFormatted = DateFormat('yyyy,MM,dd').format(model.endDate!);
    //   model.executeApiCall(startDateFormatted,endDateFormatted);
    //
    //
    //
    // }else{
    //                                 Utils.flushBarErrorMessage(
    //                                     'Start date should be less than to end date',
    //                                     context);
    //
    //
    //                               }
                               }
                                ))
                          ] ),
            ),

              ),
          ),
    );} ),
        ));
  }
}



class Reusable extends StatefulWidget {
  final Color containerColor;
  final String imagePath;
  final String labelText;
  final Color labelColor;
  final String valueText;
  final Color valueColor;
  final String text;

  const Reusable({
    Key? key,
    required this.containerColor,
    required this.imagePath,
    required this.labelText,
    required this.labelColor,
    required this.valueText,
    required this.valueColor,
    required this.text,
  }) : super(key: key);

  @override
  State<Reusable> createState() => _ReusableState();
}

class _ReusableState extends State<Reusable> {
  Color getShadowColor(Color containerColor) {
    // Calculate the shadow color based on the container color
    // You can customize this logic as per your design requirements
    return containerColor.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 50,
                width: 60,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.containerColor == Colors.white ? Colors.grey[200] : widget.containerColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,
                        height: 30, // Adjust the height of the image
                        width: 30,  // Adjust the width of the image
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 15),

              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: widget.labelText,
                        style: TextStyle(
                          color: widget.labelColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        widget.text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green[800])
                    ),
                  ),

                ],
              ),


            ],
          ),
          Divider()
        ],
      ),
    );
  }
}

