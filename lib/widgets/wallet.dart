import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';

Widget wallet(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Expanded(child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Icon(Icons.account_balance_wallet,
              size: 26,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Main Coins",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.textGray
                      ),
                    ),
                    Text("45",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(topRight:const Radius.circular(50),bottomRight:const Radius.circular(50) )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Free Coins",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.textGray
                      ),
                    ),
                    Text("45",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          )),
        ],
      ),
    ),
  );
}