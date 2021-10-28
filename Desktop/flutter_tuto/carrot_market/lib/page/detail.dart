import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manorTempWidget.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, String> data;

  const DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size size;
  late List<Map<String, String>> imgList;
  late int _current;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _makeSliderImage(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCekk(),
        ],
      ),
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      height: 55,
      width: size.width,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.share, color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.white)),
          ]),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
