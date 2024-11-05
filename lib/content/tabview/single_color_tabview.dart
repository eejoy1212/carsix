import 'package:carsix/const/color.dart';
import 'package:carsix/widget/btn/favorite_color_btn.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:carsix/widget/card/selected_favorite_card.dart';
import 'package:flutter/material.dart';

class SingleColorTabView extends StatelessWidget {
  const SingleColorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FavoriteColorBtn(),
            SelectedFavoriteCard(title: "title", content: "content"),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: RedBtn(
                    onPressed: () {},
                    title: Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: CarsixColors.white1,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
