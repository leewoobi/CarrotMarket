
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manorTempWidget.dart';
import 'package:carrot_market/repository/con_repository.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, String> data;

  const DetailContentView({Key? key, required this.data}) : super(key: key);
  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> with SingleTickerProviderStateMixin {
  late ContentsRepository contentsRepository;
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  late Size size;
  late List<Map<String, String>> imgList;
  late int _current;
  late double scrollpositionToAplaha = 0;
  late ScrollController _controller = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;
  late bool  isMyFavorCon = false;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
        contentsRepository = ContentsRepository();
     isMyFavorCon = false;
    _animationController = AnimationController(vsync: this);
    _colorTween =ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _controller.addListener(() {
      // print(_controller.offset);

      setState(() {
        if (_controller.offset> 255){
               scrollpositionToAplaha = 255;
        }else{
             scrollpositionToAplaha = _controller.offset;
        }

        _animationController.value = scrollpositionToAplaha / 255;
      });
    });
    _loadMyFavorContState();
  }

_loadMyFavorContState()  async {

bool ck = await contentsRepository.isMyFavorItemCon(widget.data["cid"].toString());
setState(() {
  isMyFavorCon = ck;
});
print(ck);


}
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    imgList = [
      {"id": "1", "url": widget.data["image"].toString()},
      {"id": "2", "url": widget.data["image"].toString()},
      {"id": "3", "url": widget.data["image"].toString()},
      {"id": "4", "url": widget.data["image"].toString()},
      {"id": "5", "url": widget.data["image"].toString()},
    ];
  }

  Widget _makeSliderImage() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"].toString(),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    print(index);
                  }),
              items: imgList.map((map) {
                return Image.asset(
                  map["url"].toString(),
                  width: size.width,
                  fit: BoxFit.fill,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white.withOpacity(0.4))
                          .withOpacity(
                              _current == int.parse(map["id"].toString())
                                  ? 0.9
                                  : 0.4)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     child: Image.asset("assets/images/user.png"),
          //   ),
          // )
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          SizedBox(
            width: 10,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("개발하는남자",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(
              "제주시 도담동 ",
            )
          ]),
          Expanded(child: ManorTem(manorTemp: 37.5))
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 1,
        color: Colors.grey.withOpacity(0.3));
  }

  Widget _contentDetail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            widget.data["title"].toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "가구/인테리어 ∙ 7시간 전",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "생활기스 좀 있는거 빼고 얼마 사용하지 않아서 상태 괜찮습니다노이즈 캔슬링 문제 없고 연결 잘 돼요 초기화 시켜둠요 시간 조정 가능하고 근처로 와주실 분만 급처입니다",
            style: TextStyle(height: 1.5, fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            " 관심 10 ∙ 채팅 7 ∙ 조회 277",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _otherCekk() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '판매자님의 판매 상품',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            '모두보기',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(controller: _controller,
      slivers:[
        SliverList(delegate: SliverChildListDelegate([
          _makeSliderImage(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCekk(),
        ],
        ),
        ),
        SliverPadding(padding: EdgeInsets.symmetric(horizontal: 15)
        ,sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing:10 ,crossAxisSpacing: 10),
          delegate:SliverChildListDelegate(List.generate(20, (index) {

          return Container(
           child:  Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
             
             ClipRRect(
               borderRadius: BorderRadius.circular(10) ,
               child: Container(color: Colors.grey, height: 120,))
             ,Text("상품 제목",style:  TextStyle(fontSize: 14),),
             Text("금액",style:  TextStyle(fontSize: 14, fontWeight:  FontWeight.bold),),
             
           ],),
          );

        }).toList()
        ), ),
        ),
        
      
     


      ]);
  }

  Widget _bottomBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: size.width,
      color: Colors.white,
      child: Row(children: [
        GestureDetector(
          onTap: ()async{
     print(isMyFavorCon);
            if (isMyFavorCon)  {
              //제거
                  await contentsRepository.deleteMyFavoriteContent(widget.data["cid"].toString());
            }else{
                  await  contentsRepository.addMyFavoriteContent(widget.data);
            } 
            setState(() {
                       isMyFavorCon = !isMyFavorCon;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:  Text( isMyFavorCon ?  "관심목록에 추가됐습니니다."  : "관심목록에서 제거됐습니다."),
      duration: Duration(seconds: 1),
    ),);
        
          },
          child: SvgPicture.asset( isMyFavorCon ? "assets/svg/heart_on.svg" :"assets/svg/heart_off.svg"  ,width: 25,height: 25,
          color: Color(0xfff08f4f),)
          ),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 10),
            width:1, height: 40 ,
            color:  Colors.black.withOpacity(0.3),
          ),
          Column(children: [
            Text( DataUtils.calcStringToWon(widget.data["price"].toString()),
                 style:TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.bold,)),
                   Text("가격제안 불가",style:TextStyle( fontSize: 14, color: Colors.grey))
          ],)
,Expanded(child: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
        Container( 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xfff08f4f)
          ),
          padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Text("채팅으로 거래하기 ", style: TextStyle(color:Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),),
  ],
))
      ],),
    );
  }

 Widget _makeIcon(IconData icon){
   return  AnimatedBuilder(
                
                animation: _colorTween,
                builder: (context, child) =>  Icon(icon, color: _colorTween.value));
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.white.withAlpha(scrollpositionToAplaha.toInt()),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon:_makeIcon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () {}, icon: _makeIcon(Icons.share)),
            IconButton(
                onPressed: () {},
                icon: _makeIcon(Icons.more_vert)),
          ]),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
