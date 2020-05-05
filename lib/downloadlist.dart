import 'package:MusicApp/color.dart';
import 'package:MusicApp/customIcons.dart';
import 'sizeConfig.dart';
import 'package:flutter/material.dart';
// import 'main.dart';

// var song = {"Beautiful In White", "Happy Together"};
// var singer = {"Westlife", "The Turtles"};

class Downloadlist extends StatefulWidget {
  Downloadlist({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DownloadlistState createState() => _DownloadlistState();
}

class _DownloadlistState extends State<Downloadlist> {

  @override
  void initState() {
    super.initState();
    // getMusicList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            searchBar(),
            SizedBox(height: SizeConfig.screenHeight*12/640),
            shuffleButton(),
            SizedBox(height: SizeConfig.screenHeight*12/640),
            musicList(),
          ],
        ),
      ),
    );
  }

  Widget appBar(){
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: BackButton(
        color: Colors.white,
        onPressed: () {
          print("Back Button in Downloaded Song");
        },
      ),

      title: Text(
        "Downloaded Songs",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      actions: <Widget>[
        IconButton(icon: Icon(IconCustom.settings_1), onPressed: (){}),
      ],
    );
  }

  Widget shuffleButton(){
    return ButtonTheme(
      height: 31,
      minWidth: 158,
      buttonColor: ColorCustom.orange,
      child: RaisedButton(
        onPressed: ((){
          print("Shuffle Butoon");
        }),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black)
        ),
        child: Text(
          "Shuffle Play",
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget searchBar(){
    return Padding(
      padding: EdgeInsets.only(left: 32,right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
          color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          children: <Widget>[
// Search Icon
            SizedBox(width: 9.0),
            Icon(
              Icons.search,
              color: ColorCustom.orange,
              size: 25,
            ),
//-----------------------------------------------------------
            SizedBox(width: 20),
// Text Input Field
            Expanded(
              child: TextField(
                onChanged: (String str){
                  print(str);
                },
                decoration: InputDecoration(
                  hintText: ' Songs, albums, artists',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                    letterSpacing: 0,
                  ),
                border: InputBorder.none,
                ),
              showCursor: true,
              cursorColor: Colors.black,
              )
            ),
            SizedBox(width: 49),
//-----------------------------------------------------------
          ],
        ),
      ),
    );
  }

  Widget musicList(){
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){                      
          return ListTile(
              leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: ColorCustom.orange,
                  border: Border.all(
                  color: Colors.black,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Icon(
                Icons.music_note,
                color: Colors.black,
                size: 40,
                  ),
              ),
              title: Text(
                "Song $index",
                // musicLst[index]['Song'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Singer $index",
                // musicLst[index]['Singer'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 30.0,
              ),
              onTap: () {
                print("Choose Song $index");
                // Music.song = "Song $index"; // musicLst[index]['Song'];
                // Music.singer = "Singer $index"; // musicLst[index]['Singer'];
                // Navigator.pushNamed(context, '/musicplayer');
              },
            );
          },
        itemCount: 5 // musicLst.length
      )
    );
  }

}