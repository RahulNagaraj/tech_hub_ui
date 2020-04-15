import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/event.dart';
import '../styles/colors.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  PaletteGenerator paletteGenerator;

  @override
  void initState() {
    super.initState();
    _updatePaletteColor();
  }

  Future<void> _updatePaletteColor() async {
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(widget.event.image),
      maximumColorCount: 32,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: screenHeight * 0.55,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 28.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              backgroundColor: paletteGenerator != null
                  ? paletteGenerator?.lightMutedColor?.color
                  : backgroundColor,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 28.0,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 78.0),
                    child: Text(
                      widget.event.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                background: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: new AssetImage(
                          widget.event.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 72.0,
                          left: 16.0,
                          child: Text(
                            new DateFormat.MMMEd().format(widget.event.date),
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Text(widget.event.title),
        ),
      ),
    );
  }
}
