import 'package:flutter/material.dart';

class LikeIcon extends StatelessWidget {
  Future<int> tempFuture() async {
    // Delay for 1 second and then return 0
    await Future.delayed(Duration(seconds: 1));
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: tempFuture(),
        builder: (context, snapshot) =>
            snapshot.connectionState != ConnectionState.done
                ? Icon(Icons.favorite, size: 110, color: Colors.red,)
                : SizedBox(),
      ),
    );
  }
}
