import 'package:flutter/material.dart';

class ColorNoteList extends StatefulWidget {
  const ColorNoteList({super.key});

  @override
  State<ColorNoteList> createState() => _ColorNoteListState();
}

class _ColorNoteListState extends State<ColorNoteList> {
  int colorCode = 0xff62B6CB;

  final List<int> _colors = const [
    0xff62B6CB,
    0xffFF0000,
    0xffFF0080,
    0xff00FF00,
    0xffFFFF00,
    0xff0000FF,
    0xffFFA500,
    0xff800080,
    0xffFFC0CB,
    0xff00FFFF,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                if (colorCode != _colors[index]) {
                  colorCode = _colors[index];
                  setState(() {});
                }
              },

              child: ColorNoteItem(
                colorCode: colorCode,
                indexColor: _colors[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorNoteItem extends StatelessWidget {
  const ColorNoteItem({
    super.key,
    required this.colorCode,
    required this.indexColor,
  });
  final int colorCode;
  final int indexColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: indexColor == colorCode
            ? Border.all(width: 2, color: Colors.white)
            : null,
        color: Color(indexColor),
      ),
      child: indexColor == colorCode
          ? Icon(Icons.done, color: Colors.black)
          : null,
    );
  }
}
