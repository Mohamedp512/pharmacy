import 'package:flutter/material.dart';
import 'package:safwat_pharmacy/size_config.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(1.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: color != null ? color: Colors.red,
            ),
            constraints: BoxConstraints(
              minWidth: SizeConfig.defaultSize*1.7,
              minHeight: SizeConfig.defaultSize*1.5,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    );
  }
}
