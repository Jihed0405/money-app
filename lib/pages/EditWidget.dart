import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_app/data/transaction.dart';
import 'package:flutter_money_app/extensions/date_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/data_state_notifier.dart';
import '../types/model.dart';
import '../utils/constants.dart';
import '../widget/custom_toggle.dart';
import 'dart:async';
import 'dart:developer' as developer;

const List<String> listCategory = <String>[
  'Fashion',
  'Grocery',
  'Transport',
  'Entertainment',
  'Travel',
  'Home Rent',
  'Pet',
  'Extra'
];
List<String> list = listCategory;
const List<String> listIncome = <String>[
  'Payments',
  'Salary',
  'Commission',
  'Interest',
  "Selling something you create or own",
  "Investments",
  "Gifts",
  "Government Payments"
];
const List<String> listRecurrence = <String>[
  'None',
  'Daily',
  'weekly',
  'monthly',
  'yearly'
];

class EditWidget extends ConsumerStatefulWidget {
  EditWidget({Key? key}) : super(key: key);
  @override
  ConsumerState<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends ConsumerState<EditWidget> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  String dropdownValueExpenses = listCategory.first;
  String dropdownValueIncome = listIncome.first;
  String dropdownValueRecurrence = listRecurrence.first;
  late List<bool> isSelected;

  late bool _expenses;
  bool _canSubmit = true;
  DateTime _selectedDate = DateTime.now();

  late String _itemCategory;

  late TransactionType _transactionType;
  late Transaction transaction;
  @override
  void initState() {
    // _amountController = TextEditingController();

    _amountController = TextEditingController(
        text: '${ref.read(currentTransactionToEdit).amount}');

    _noteController = TextEditingController(
        text: ref.read(currentTransactionToEdit).itemName);
    _nameController = TextEditingController(
        text: ref.read(currentTransactionToEdit).itemCategoryName);
    _dateController = TextEditingController(
        text: '${ref.read(currentTransactionToEdit).date.formattedDate}');

    _canSubmit =
        _dateController.text.isNotEmpty && _amountController.text.isNotEmpty;

    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = picked.formattedDate;
        ref.watch(currentTransactionToEdit).date=picked;
      });
    }
  }

  void submitExpense() {
    final mymodel = MyModel();
    switch (_expenses) {
      case true:
        setState(() {
          _transactionType = TransactionType.outflow;
          _itemCategory = dropdownValueExpenses;
        });

        break;
      case false:
        setState(() {
          _transactionType = TransactionType.inflow;
          _itemCategory = dropdownValueIncome;
        });
    }
    transaction = Transaction(
        20,
        _itemCategory,
        _transactionType,
        _nameController.value.text,
        _noteController.value.text,
        double.parse(_amountController.value.text),
        _selectedDate);
    
    /*mymodel.editData(transaction, ref);
    //dataStateNotifier.addTransaction(transaction);

    ref.read(amountController.notifier).state.clear();
    ref.read(dropdownValueRecurrence.notifier).state = listRecurrence.first;
    ref.read(dateController.notifier).state.clear();
    ref.read(noteController.notifier).state.clear();
    ref.read(nameController.notifier).state.clear();
    ref.read(dropdownValueExpenses.notifier).state = listCategory.first;
    ref.read(dropdownValueIncome.notifier).state = listIncome.first;
   */
  }

  @override
  Widget build(BuildContext context) {
    double defaultWidth = MediaQuery.of(context).size.width;
    double defaultHeight = MediaQuery.of(context).size.height;
    _amountController = TextEditingController(
        text: '${ref.watch(currentTransactionToEdit).amount}');
    _noteController = TextEditingController(
        text: ref.watch(currentTransactionToEdit).itemName);
    _nameController = TextEditingController(
        text: ref.watch(currentTransactionToEdit).itemCategoryName);
    _dateController = TextEditingController(
        text: '${ref.watch(currentTransactionToEdit).date.formattedDate}');
    if (ref.watch(currentTransactionToEdit).transactionType ==
        TransactionType.outflow) {
      isSelected = <bool>[false, true];
      _expenses = true;
      if (listCategory
          .contains(ref.read(currentTransactionToEdit).categoryType)) {
        dropdownValueExpenses = ref.read(currentTransactionToEdit).categoryType;
      } else {
        dropdownValueExpenses = listCategory.first;
      }
    } else {
      isSelected = <bool>[true, false];
      _expenses = false;
      if (listIncome
          .contains(ref.read(currentTransactionToEdit).categoryType)) {
        dropdownValueIncome = ref.read(currentTransactionToEdit).categoryType;
      } else {
        dropdownValueIncome = listIncome.first;
      }
    }
    
    return SingleChildScrollView(
      child: SafeArea(
        top: true,
        child: Column(
          children: [
            AppBar(
              centerTitle: true,
              title: Text(
                " Edit Expenses",
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
              height: defaultSpacing,
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
                        if (index == 1) {
                          ref.read(currentTransactionToEdit).transactionType =
                              TransactionType.outflow;
                          _expenses = true;
                        } else {
                          ref.read(currentTransactionToEdit).transactionType =
                              TransactionType.inflow;
                         
                          _expenses = false;
                        }
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
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: defaultWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Amount',
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.green[200],
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: InputBorder.none,
                        ),
                        keyboardType:
                            defaultTargetPlatform == TargetPlatform.iOS
                                ? const TextInputType.numberWithOptions(
                                    decimal: true, signed: true)
                                : const TextInputType.numberWithOptions(
                                    decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _amountController,
                        onSubmitted: (String value) async {
                          setState(() {if(value==""){
                            ref.read(currentTransactionToEdit).amount=0;
                          }
                          else{
                            developer.log("${double.parse(value)}");
                          ref.read(currentTransactionToEdit).amount=double.parse(value);
                        }
                          _canSubmit =
                              _dateController.text.isNotEmpty &&value!="";});
                                developer.log("${ref.read(currentTransactionToEdit).amount}");
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: defaultWidth,
                      height: defaultHeight / 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(defaultRadius)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultSpacing, top: defaultSpacing / 2),
                            child: Text("Recurrence",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: fontSubHeading)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultSpacing / 30),
                            child: DropdownButtonFormField<String>(
                              value: dropdownValueRecurrence,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: fontSubHeading,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0))),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(defaultRadius)),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? recurrenceValue) {
                                // This is called when the user selects an item.

                                setState(() {
                                  dropdownValueRecurrence = recurrenceValue!;
                                });
                              },
                              items: listRecurrence
                                  .map<DropdownMenuItem<String>>(
                                      (String recurrenceValue) {
                                if (recurrenceValue ==
                                    dropdownValueRecurrence) {
                                  return DropdownMenuItem<String>(
                                    value: recurrenceValue,
                                    child: Text(recurrenceValue,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  );
                                } else {
                                  return DropdownMenuItem<String>(
                                    value: recurrenceValue,
                                    child: Text(recurrenceValue),
                                  );
                                }
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.date_range_sharp,
                              color: Colors.blue[300],
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Date',
                                enabled: false,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 0.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0)),
                                border: InputBorder.none,
                              ),
                              controller: _dateController,
                              onSubmitted: (String value) async {
                                setState(() => _canSubmit = value!="" &&
                                    _amountController.text.isNotEmpty);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          prefixIcon: _expenses
                              ? Icon(
                                  Icons.trending_down_rounded,
                                  color: Colors.amber[200],
                                )
                              : Icon(
                                  Icons.trending_up_rounded,
                                  color: Colors.amber[200],
                                ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: InputBorder.none,
                        ),
                        controller: _nameController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          hintText: 'Note',
                          prefixIcon: Icon(
                            Icons.note_rounded,
                            color: Colors.red[200],
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: InputBorder.none,
                        ),
                        controller: _noteController,
                        onSubmitted: (String value) async {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: defaultWidth,
                      height: defaultHeight / 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(defaultRadius)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: defaultSpacing, top: defaultSpacing / 2),
                            child: Text("Category",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: fontSubHeading)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultSpacing / 30),
                            child: DropdownButtonFormField<String>(
                                value: _expenses
                                    ? dropdownValueExpenses
                                    : dropdownValueIncome,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: fontSubHeading,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1.0))),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(defaultRadius)),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.

                                  setState(() {
                                    if (_expenses) {
                                      dropdownValueExpenses = value!;
                                    } else {
                                      dropdownValueIncome = value!;
                                    }
                                  });
                                },
                                items: _expenses
                                    ? listCategory.map((String value) {
                                        if (value == dropdownValueExpenses) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          );
                                        } else {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }
                                      }).toList()
                                    : listIncome.map((String value) {
                                        if (value == dropdownValueIncome) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          );
                                        } else {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }
                                      }).toList()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: defaultWidth,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.15,
                                0.4,
                                0.8,
                              ],
                              colors: [
                                Color(0xFF35a6e5),
                                Color(0xFF42a0e8),
                                Color(0xFFd676db),
                                Color(0xFFf88568)
                              ]),
                          border: Border.all(
                            //color: const Color.fromARGB(255, 18, 32, 47),
                            color: Colors.transparent,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(defaultRadius),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () {
                            _canSubmit ? submitExpense() : null;
                          },
                          child: Text(
                            'Update',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: _canSubmit
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(
                                            100, 255, 255, 255),
                                    fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
