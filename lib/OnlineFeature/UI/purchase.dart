
import 'package:MusicApp/Custom/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/OnlineFeature/httpService.dart';
import 'package:MusicApp/BloC/userBloC.dart';

class Purchase extends StatelessWidget {

  final UserBloC userBloC;
  final String type;
  final BuildContext parentContext;

  Purchase({@required this.userBloC, this.type,@required this.parentContext});


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: ColorCustom.grey,
      height: 500,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: text("Payment Method", size: 21, color: Colors.white, font: FontWeight.w700),
            )
          ),
          SizedBox(height: 20/640*SizeConfig.screenHeight,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 38, right: 38),
              child: paymentMethod(context),
            ),
          )
        ],
      )
    );
  }


  Widget text(String str, {Color color = Colors.white, double size = 20.0, FontWeight font = FontWeight.w700}) {
    return Text(
      str,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: 'Lato',
        fontWeight: font,
      ),
    );
  }

  Widget paymentMethod(BuildContext context) {
    return ListView(
      children: <Widget>[
        bankInfo(Image.asset('images/momo.png', fit: BoxFit.cover, width: 50.0,
          height: 50.0,), 'MoMo E-Wallet', context),
        bankInfo(Image.asset('images/visa.png', fit: BoxFit.cover, width: 50.0,
          height: 50.0,), 'Visa', context),
        bankInfo(Image.asset('images/ocb.png', fit: BoxFit.cover, width: 50.0,
          height: 50.0,), 'OCB Banking', context)
      ],
    );
  }

  Widget bankInfo(Image image, String bankName, BuildContext context) {
    return Container(
      height: 75,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0,),
        leading: image,
        title: text(bankName, color: Colors.amber),
        onTap: (){
          Navigator.pop(context);
          if (type == "status") createBankDialog(context, bankName); // send to database
          else if (type == "buycoin") popUpCoin(context);
        },
      ),
    );
  }

  final TextEditingController customController = TextEditingController();
  final TextEditingController coinController = TextEditingController();

  Future<String> createBankDialog(BuildContext context, String bankName){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: ColorCustom.grey,
          title: text("You are purchase using $bankName. \nEnter your password:", color: Colors.amber),
          content: TextField(
            obscureText: true,
            controller: customController,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              color: Colors.amber,
            ),
            cursorColor: Colors.amber,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              )
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: text('Cancel',size: 20, color: Colors.amber),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              elevation: 5.0,
                child: text('Confirm buy',size: 20 ,color: Colors.amber),
              onPressed: () async{
                
                int result = await buyVipAndSong(userBloC,customController.text.toString() ,type, 100000);
                if (result == 0){
                  customController.text = "";
                  Navigator.pop(context);
                  createAlertDialog("You are VIP", context);
                }
                else if (result == 1) createAlertDialog("Not enough coin!", context);
                else if (result == 2) createAlertDialog("Wrong password", context);
                else createAlertDialog("There is problems", context);



              },
            )
          ],
        );
      }
    );
  }

  Future<String> popUpCoin(BuildContext context){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: ColorCustom.grey,
          title: text("Enter your coin: ", color: Colors.amber),
          content: TextField(
            controller: coinController,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              color: Colors.amber,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              )
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: text('Cancel',size: 20, color: Colors.amber),
              onPressed: () async{
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              elevation: 5.0,
                child: text('Confirm buy',size: 20 ,color: Colors.amber),
              onPressed: () async{
                if (coinController.text.contains(RegExp(r'[a-z]'))){
                  coinController.text = "";
                  createAlertDialog("Input only number", context);
                } else {
                  int coin = int.parse(coinController.text);
                  int result = await transactionForCoin(userBloC, coin);

                  if (result == 0) {
                    Navigator.pop(context);
                    createAlertDialog("Successful Transaction", context);
                  }
                  else createAlertDialog("Fail Transaction \n(Coin > 20000)", context);
                }
              },
            )
          ],
        );
      }
    );
  }


}
