import 'package:MusicApp/Custom/color.dart';
import 'package:MusicApp/Custom/customIcons.dart';
import 'package:MusicApp/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:MusicApp/OfflineFeature/mp3Access.dart';
import 'package:MusicApp/ParentWidget.dart';
// import 'main.dart';

// var song = {"Beautiful In White", "Happy Together"};
// var singer = {"Westlife", "The Turtles"};

class Downloadlist extends StatefulWidget {
  final Mp3Access fileData;

  Downloadlist(this.fileData);

  @override
  _DownloadlistState createState() => _DownloadlistState();
}

class _DownloadlistState extends State<Downloadlist> {

  List<dynamic> filterList = List();
  List<dynamic> songList = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      songList = widget.fileData.songs;
      filterList = songList;
    });
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
            SizedBox(height: SizeConfig.screenHeight*7/640),
            shuffleButton(),
            SizedBox(height: SizeConfig.screenHeight*7/640),
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
            SizedBox(width: 9.0),
// Search Icon
            Icon(
              Icons.search,
              color: ColorCustom.orange,
              size: 25,
            ),

            SizedBox(width: 20),
// Text Input Field
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18),
//Hint text for textfield
                decoration: InputDecoration(
                  hintText: 'Songs, albums, artists',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                    letterSpacing: 0,
                  ),
                border: InputBorder.none,
                ),
//Function for textfield
              onChanged: (string){
                setState(() {
                  filterList = songList.where((element) => 
                  (element.title.toLowerCase().contains(string.toLowerCase()) || 
                  element.artist.toLowerCase().contains(string.toLowerCase())))
                  .toList();
                });
              },
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
          var song = filterList[index];

          return ListTile(
              leading: musicIcon(),
              title: Text(
                //"Song $index",
                song.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                //"Singer $index",
                song.artist,
                style: TextStyle(
                  color: ColorCustom.grey1,
                  fontSize: 14.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: moreSetting(),

//Function for song cards
              onTap: () {
                print("Choose Song $index");
                // Music.song = "Song $index"; // musicLst[index]['Song'];
                // Music.singer = "Singer $index"; // musicLst[index]['Singer'];
                Navigator.pushNamed(context, '/musicplayer');
              },
//-----------------------------------------------------------
            );
          },
        itemCount: filterList.length // musicLst.length
      )
    );
  }

  Widget musicIcon(){
    return Container(
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
    );
  }

  Widget moreSetting(){
    return PopupMenuButton<int>(
      color: ColorCustom.grey,
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
        size: 30.0,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text(
            "Upload",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text(
            "Add to playlist",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            )
          ),
        )
      ],
//Function for Upload and Add to playlist
      onSelected: (val){
        if (val == 1)
          print("Upload");
        else print("Add to playlist");
      },
//-----------------------------------------------------------
    );
  }

}