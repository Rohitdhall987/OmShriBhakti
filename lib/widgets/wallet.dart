import 'package:flutter/material.dart';
import 'package:omshribhakti/model/main_wallet.dart';
import 'package:omshribhakti/model/user_model.dart';
import 'package:omshribhakti/services/wallet_service.dart';
import 'package:omshribhakti/utils/Colors.dart';





Widget wallet(CustomUser user){

  WalletService service=WalletService();



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
                    FutureBuilder(
                        future: service.getMainWalletAmount(id: user.apiData!["userId"], token: user.apiData!["token"]),
                        builder: (context,snapshot){
                          if(snapshot.connectionState ==ConnectionState.done && !snapshot.hasError){
                            return  Text((snapshot.data!.amount.split(".")).first,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary
                              ),
                            );
                          }
                          return Text("0",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary
                            ),
                          );
                        }
                    )
                    // mainWallet.when(
                    //     data: (wallet){
                    //       return
                    //     },
                    //     error: (obj,stack){
                    //       return Text("0",
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: AppTheme.primary
                    //         ),
                    //       );
                    //     },
                    //     loading: (){
                    //
                    //     }
                    // )
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
                    FutureBuilder(
                        future: service.getFreeWalletAmount(id: user.apiData!["userId"], token: user.apiData!["token"]),
                        builder: (context,snapshot){
                          if(snapshot.connectionState ==ConnectionState.done && !snapshot.hasError){
                            return  Text((snapshot.data!.amount.split(".")).first,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary
                              ),
                            );
                          }
                          return Text("0",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary
                            ),
                          );
                        }
                    )
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