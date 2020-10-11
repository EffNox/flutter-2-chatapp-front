import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String url;
  final String title;
  final String subtitle;

  const Labels({@required this.url, this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, url);
            },
            child: Text(subtitle,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          Text(
            'Terminos y condiciones de uso',
            style: TextStyle(fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }
}
