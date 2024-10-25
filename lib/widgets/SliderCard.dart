import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/utils/format.dart';

class SlicerCard extends StatelessWidget {
  const SlicerCard({super.key, required this.title,
    // required this.seats,
    required this.fromState,required this.toState,required this.date,required this.image});


  final String date;
  final String image;
  // final int seats;
  final String toState;
  final String fromState;
  final String title;






  @override
  Widget build(BuildContext context) {



    DateTime currentDate = DateTime.now();
    DateTime tripDate = DateTime.parse(date);

    // Calculate the difference in days
    int daysLeft = tripDate.difference(currentDate).inDays;

    String displayText;
    if (daysLeft > 0) {
      displayText = "$daysLeft days left";
    } else if (daysLeft == 0) {
      displayText = "Today is the day!";
    } else {
      displayText = "${daysLeft.abs()} days ago";
    }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fitHeight),
              color: Colors.grey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Container(
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(5)
                //   ),
                //   child: Column(
                //     children: [
                //       Text(seats.toString(),
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 22,
                //           color: AppTheme.primary
                //         ),
                //       ),
                //       Text("Total Seats",
                //         style: TextStyle(
                //           fontWeight: FontWeight.w100,
                //           fontSize: 6
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 4,
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(

                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              color: AppTheme.primary,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on,color: Colors.white,size: 10,),
                                  Text(toState,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                              margin: EdgeInsets.symmetric(vertical: 0,horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Text(displayText,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          // child: Row(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Expanded(
                              //   flex:6,
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text("Going on ${formatDate(date)}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black38,
                                                  overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),


                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              // ),
                              // Container(
                              //   height: MediaQuery.sizeOf(context).height *0.04,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       left: BorderSide(
                              //         color: Colors.black38,
                              //         width: 1
                              //       )
                              //     )
                              //   ),
                              // ),
                              // Expanded(
                              //   flex:4,
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("From",
                                        style: TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                      Text("${fromState} to ${ toState}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}