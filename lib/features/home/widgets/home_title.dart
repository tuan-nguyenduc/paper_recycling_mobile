import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String? title;
  const HomeTitle({
    super.key,
    this.title,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.flash_on,
                size: 30,
                color: Colors.deepOrange,
              ),
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_right_alt,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}