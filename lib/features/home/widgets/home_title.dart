import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String? title;
  final Icon? icon;
  const HomeTitle({
    super.key,
    this.title,
    this.icon,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon!,
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
                Icons.arrow_right_alt,
                size: 30,
              ),
          ),
        ],
      ),
    );
  }
}