import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  final List categories;
  final int activeIndex;
  final Function(int) onTap;

  const CategoryBar({
    Key key,
    @required this.categories,
    @required this.activeIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _kMarginFromSide = 16;
    const double _kTextPaddingFromTop = 16;
    const double _kActiveFontSize = 24;
    const double _kInactiveFontSize = 20;
    const double _kVerticalDividerThickness = 1;
    
    _buildBorderRadius({double value = 16}) => BorderRadius.all(
          Radius.circular(value),
        );

    List<Widget> categoriesWidgets = [];

    for (int i = 0; i < categories.length; i++) {
      categoriesWidgets.add(
        InkWell(
          onTap: () => onTap(i),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: _kTextPaddingFromTop),
            child: Text(
              categories[i],
              style: TextStyle(
                fontSize:
                    i == activeIndex ? _kActiveFontSize : _kInactiveFontSize,
                fontWeight: i == activeIndex ? FontWeight.w700 : null,
              ),
            ),
          ),
        ),
      );
      if (i != categories.length - 1)
        categoriesWidgets.add(
          VerticalDivider(
            color: Theme.of(context).dividerColor,
            thickness: _kVerticalDividerThickness,
          ),
        );
    }
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: _kMarginFromSide),
        decoration: BoxDecoration(
          borderRadius: _buildBorderRadius(),
          color: Theme.of(context).cardColor, // TODO: color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categoriesWidgets,
        ),
      ),
    );
  }
}
