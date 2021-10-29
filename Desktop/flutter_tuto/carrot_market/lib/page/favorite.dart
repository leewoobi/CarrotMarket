import 'package:carrot_market/page/detail.dart';
import 'package:carrot_market/repository/con_repository.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyfavoriteCont extends StatefulWidget {
  const MyfavoriteCont({ Key? key }) : super(key: key);

  @override
  _MyfavoriteContState createState() => _MyfavoriteContState();
}

class _MyfavoriteContState extends State<MyfavoriteCont> {
  
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    super.initState();

  contentsRepository   = ContentsRepository() ;
  }


    _makeDataList(dynamic datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DetailContentView(
                  data: datas[index],
                );
              }));
              print(datas[index]["title"]);
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Hero(
                          tag: datas[index]["cid"].toString(),
                          child: Image.asset(
                            datas[index]["image"].toString(),
                            width: 100,
                            height: 100,
                          ),
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
                              DataUtils.calcStringToWon(datas[index]["price"].toString()),
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
                )),
          );
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          );
        },
        itemCount: datas.length );
  }

  Widget _bodyWidget(){
    return FutureBuilder(
        future: _loadMyFavorContentList(),
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
            child: Text('해당지역에 데이터가 없습니다.'),);
        });
  }

  Future<List<dynamic>?> _loadMyFavorContentList()  async  {
    return  await  contentsRepository.loadFavorConts();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('관심목록', style:   TextStyle(fontSize: 15),)),
        body: _bodyWidget(),
  
      
    );
  }
}