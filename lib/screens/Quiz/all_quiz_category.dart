import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/model/free_wallet.dart';
import 'package:omshribhakti/model/main_wallet.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/quiz_service.dart';
import 'package:omshribhakti/services/wallet_service.dart';
import 'package:omshribhakti/widgets/QuizCategory.dart';

class QuizCategory extends ConsumerWidget {
   QuizCategory({super.key});

  FreeWallet? _freeWallet;
  MainWallet? _mainWallet;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user=ref.watch(customUserProvider);
    final QuizService service=QuizService();
    final WalletService walletService = WalletService();
    walletService.getFreeWalletAmount(id: user!.apiData!["userId"], token: user.apiData!["token"]).then(
        (freeWallet)=>_freeWallet=freeWallet
    );
    walletService.getMainWalletAmount(id: user.apiData!["userId"], token: user.apiData!["token"]).then(
        (mainWallet)=>_mainWallet=mainWallet
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("QUIZ"),
      ),
      body:FutureBuilder(
          future: service.fetchQuizCategory(user.apiData!["token"]),
          builder: (context,snapshot){
            if(snapshot.connectionState ==ConnectionState.done && !snapshot.hasError){
              return GridView.builder(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          try{
                            if(_freeWallet!.amount=="0" && _mainWallet!.amount=="0"){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Insufficient balance free watch ads to get free coin."),
                              ));
                            }
                            GoRouter.of(context).pushNamed("QuizPage",
                                pathParameters: {
                                  "categoryId":snapshot.data![index].id.toString()
                                }
                            );
                          }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Insufficient balance free watch ads to get free coin."),
                            ));
                          }
                        },
                        child: quizCategory(snapshot.data![index].title, snapshot.data![index].image)
                    );
                  }
              );
            }
            return GridView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                itemBuilder: (context,index){
                  return quizCategory("Loading", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png");
                }
            );
          }
      ),
    );
  }
}
