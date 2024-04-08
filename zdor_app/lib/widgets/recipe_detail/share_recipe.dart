//import 'package:accordion/accordion.dart';
//import 'package:accordion/controllers.dart';

import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/recipe_detail/share_buttons.dart';

class ShareRecipe extends StatelessWidget {
  const ShareRecipe({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Condividi"),
          SizedBox(height: 5),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 230, 160, 97),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Inserisci email per condivisione', //Placeholder text
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              ShareButtons(
                imagePath: 'lib/assets/share.png',
                onPressed: () {},
              ),
              ShareButtons(
                imagePath: 'lib/assets/instagram.png',
                onPressed: () {},
              ),
              ShareButtons(
                imagePath: 'lib/assets/facebook.png',
                onPressed: () {},
              ),
              ShareButtons(
                imagePath: 'lib/assets/telegram.png',
                onPressed: () {},
              ),
              ShareButtons(
                imagePath: 'lib/assets/whatsapp.png',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
