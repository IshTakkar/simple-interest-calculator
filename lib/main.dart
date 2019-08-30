import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  final _minimumPadding = 5.0;
  var _currentValueSelected = 'Rupees';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  String displayResult = '';
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  validator: (String val){
                  if(val.isEmpty)
                  return 'Please enter Term';},
                  controller: principalController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0
                    ),
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "Enter principal amount e.g. 12000",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  validator: (String val) {
                    if(val.isEmpty)
                      return 'Please enter Rate of Interest!';
                  },
                  controller: roiController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                      ),
                      labelText: "Rate of Interest",
                      labelStyle: textStyle,
                      hintText: "In percent",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                          validator: (String val){
                            if(val.isEmpty)
                              return 'Please enter Term!';
                          },
                      controller: termController,
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          labelText: "Term",
                          labelStyle: textStyle,
                          hintText: "Time in Years",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(width: _minimumPadding * 5),
                    Expanded(
                        child: DropdownButton<String>(
                      items: <String>['Rupees', 'Dollars', 'Pounds', 'Other']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentValueSelected,
                      onChanged: (String newValueSelected) {
                        _onNewValueSelected(newValueSelected);
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                          this.displayResult = _calculateTotalReturns();
                        }  },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      height: 125.0,
      width: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onNewValueSelected(String newValueSelected) {
    setState(() {
      this._currentValueSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your total amount payable is: $totalAmountPayable $_currentValueSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentValueSelected = 'Rupees';
  }
}
