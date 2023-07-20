import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/views/common_widgets/custom_quantity_controller.dart';
import 'package:grocery_app/views/common_widgets/custom_text_widget.dart';

class CustomQuantityWidget extends StatefulWidget {
  const CustomQuantityWidget({Key? key, required this.color, required this.size}) : super(key: key);

  final Color color ;
  final Size size ;


  @override
  State<CustomQuantityWidget> createState() => _CustomQuantityWidgetState();
}

class _CustomQuantityWidgetState extends State<CustomQuantityWidget> {
  final _quantityTextController = TextEditingController() ;
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: 'Title',
          color: widget.color,
          textSize: 20,
          isTitle: true,
        ),
        const SizedBox(
          height: 16.0,
        ),
        SizedBox(
          width: widget.size.width * 0.3,
          child: Row(
            children: [
              _quantityController(
                fun: () {
                  if (_quantityTextController.text == '1') {
                    return;
                  } else {
                    setState(() {
                      _quantityTextController.text =
                          (int.parse(_quantityTextController.text) - 1)
                              .toString();
                    });
                  }
                },
                color: Colors.red,
                icon: CupertinoIcons.minus,
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _quantityTextController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  onChanged: (v) {
                    setState(() {
                      if (v.isEmpty) {
                        _quantityTextController.text = '1';
                      }
                    });
                  },
                ),
              ),
              _quantityController(
                fun: () {
                  setState(() {
                    _quantityTextController.text = (int.parse( _quantityTextController.text) + 1).toString() ;
                  });

                },
                color: Colors.green,
                icon: CupertinoIcons.plus,
              )
            ],
          ),
        ),
      ],
    );
  }
  Widget _quantityController({
    required Function fun,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fun();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
