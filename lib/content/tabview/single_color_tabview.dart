import 'package:carsix/widget/btn/favorite_color_btn.dart';
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
            FavoriteColorBtn(),
            SelectedFavoriteCard(title: "title", content: "content")
          ],
        ),
      ),
    );
  }
}
