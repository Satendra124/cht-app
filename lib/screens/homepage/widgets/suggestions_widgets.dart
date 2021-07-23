import 'package:cht/models/report.dart';
import 'package:cht/util/colorConstants.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionWidget extends StatelessWidget {
  final Suggestion suggestion;

  const SuggestionWidget({Key key, this.suggestion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 50,
      height: 150,
      decoration: BoxDecoration(
        color: ColorLight.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              suggestion.title,
              style: TextStyle(
                color: ColorLight.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  //height: 100,
                  child: ClipRRect(
                    child: Image.network(
                      suggestion.imageUrl,
                      width: 100,
                      //height: 100,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    child: Text(
                      suggestion.discription,
                      style: TextStyle(
                        color: ColorLight.black,
                        fontFamily: "OpenSans",
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (await canLaunch(suggestion.url))
                          await launch(suggestion.url);
                      },
                      child: Text("Go"))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
