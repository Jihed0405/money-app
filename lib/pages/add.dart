import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import '../widget/custom_toggle.dart';

const List<String> list = <String>['CatOne', 'Two', 'Three', 'Four'];
const List<String> list2 = <String>['ReccurrenceDaily', 'weekly', 'monthly', 'yearly'];
const List<Widget> typeOfADD = <Widget>[
  Text('Income'),
  Text('Expenses'),
];

class AddWidget extends StatefulWidget {
  const AddWidget({super.key});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  
  List<bool> isSelected = <bool>[true, false];
  bool vertical = false;
  late TextEditingController _controller;
    late TextEditingController _controller2;
  String dropdownValue = list.first;
  String dropdownValue2 = list2.first;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   double defaultWidth = MediaQuery.of(context).size.width; 
   double defaultHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text(
                " Add Expenses",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              elevation: 0,
              backgroundColor: background,
              leading: const Icon(
                Icons.arrow_back_ios,
                color: fontDark,
              ),
            ),
            const SizedBox(
              height: defaultSpacing * 4,
            ),
            Column(children: [
              Center(
                child: ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        isSelected[buttonIndex] = buttonIndex == index;
                      }
                    });
                  },
                  isSelected: isSelected,
                  selectedColor: Colors.white,
                  renderBorder: false,
                  fillColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  children: [
                    CustomToggle(
                      text: "Income",
                      isSelected: isSelected[0],
                      bgColor: background,
                    ),
                    CustomToggle(
                      text: "Expenses",
                      isSelected: isSelected[1],
                      bgColor: background,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultSpacing * 2,
              ),
            ]),
            Container(
          child: TextField(
                  decoration: const InputDecoration(
                  focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0
                      )
                    ),
                                border: InputBorder.none,
                                hintText: 'Amount',
                                                 ),
                                                 keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                                  ? const TextInputType.numberWithOptions(
                                      decimal: true, signed: true)
                                  : const TextInputType.numberWithOptions(decimal: true),
                                                 inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'))
                                                 ],
                                                 controller: _controller,
                                                 onSubmitted: (String value) async {},
                                               ),
            ),
                
             
             Row(
              children: [
              Padding(
                padding: const EdgeInsets.all(defaultSpacing),
                child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
              ),]
  ,),  
        Row(
              children: [
              Expanded(child: DropdownButton<String>(
      value: dropdownValue2,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value2) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue2 = value2!;
        });
      },
      items: list2.map<DropdownMenuItem<String>>((String value2) {
        return DropdownMenuItem<String>(
          value: value2,
          child: Text(value2),
        );
      }).toList(),
    ),),]
  ,), Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note',
                    ),
                 
                    controller: _controller2,
                    onSubmitted: (String value) async {},
                  ),
                ),
              ],
            ),
             ],
            ),
          
            ),
          
        );
      
    
  }
}
