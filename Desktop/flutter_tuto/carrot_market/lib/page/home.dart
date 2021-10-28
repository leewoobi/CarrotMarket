import 'package:carrot_market/repository/con_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentLocation;
  late ContentsRepository contentsRepository;
  final Map<String, String> locationTypeToString = {
    "ara": "아라동",
    "bora": "보라동",
    "donam": "도남동"
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocation = "ara";
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  final oCcy = new NumberFormat("#,###", "ko_kr");
  String calcStringToWon(String priceString) {
    if (priceString == "무료나눔") return priceString;
    return "${oCcy.format(int.parse(priceString))}원";
  }

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(dynamic datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        datas[index]["image"].toString(),
                        width: 100,
                        height: 100,
                      )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            datas[index]["title"].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            datas[index]["location"].toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 12),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            calcStringToWon(datas[index]["price"].toString()),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/heart_off.svg",
                                    width: 13,
                                    height: 13,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(datas[index]["likes"].toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          );
        },
        itemCount: datas?.length ?? 0);
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: _loadContents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('데이터 오류'));
          }
          if (snapshot.hasData) {
            return _makeDataList(snapshot.data);
          }

          return Center(
            child: Text('해당지역에 데이터가 없습니다.'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            print('click');
          },
          child: PopupMenuButton<String>(
            offset: Offset(0, 25),
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                1),
            onSelected: (String where) {
              print(where);
              setState(() {
                currentLocation = where;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "ara",
                  child: Text("아라동"),
                ),
                PopupMenuItem(
                  value: "bora",
                  child: Text("보라동"),
                ),
                PopupMenuItem(
                  value: "donam",
                  child: Text("도남동"),
                ),
              ];
            },
            child: Row(
              children: [
                Text(locationTypeToString[currentLocation].toString()),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        elevation: 1,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svg/bell.svg",
                width: 22,
              )),
        ],
      ),
      body: _bodyWidget(),
    );
  }
}
