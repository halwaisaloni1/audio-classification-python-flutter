import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  int maxVal;
  String maxClass;
  String maxUrl;

  DetailsPage(
    this.maxVal,
    this.maxClass,
    this.maxUrl,
  );

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 310,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  StyledText(
                    text:
                        '<para>Noise is ironically a silent killer.</para>',
                    styles: {
                      'para': TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontFamily: 'Georgia'
                      ),
                    },
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StyledText(
                    text:
                        '<para>A person can face a lot of difficulties if exposed to loud noise for a large amount of time. These effects don\'t usually seem to be much of a problem in the beginning but can be fatal in some cases if ignored for long. It is necessary that we as a human being take a step towards reducing the noise in some way or the other.</para>',
                    styles: {
                      'para': TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'Georgia'
                      ),
                    },
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StyledText(
                    text:
                        '<para>Above graphs indicate that</para>   <bold>$maxClass</bold>   <para>produced the highest amount of noise holding upto $maxVal% of the total outcome.</para>',
                    styles: {
                      'bold': TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                        fontSize: 17,
                        fontFamily: 'Georgia',
                        height: 1.5,
                      ),
                      'para': TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'Georgia'
                      ),
                    },
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Click ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontFamily: 'Georgia',
                          ),
                        ),
                        TextSpan(
                          text: 'here ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontFamily: 'Georgia',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchUrl(maxUrl);
                              print('$maxUrl is called');
                            },
                        ),
                        TextSpan(
                          text:
                              '& take a look at how this affects us and help try to curb this together!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontFamily: 'Georgia',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
