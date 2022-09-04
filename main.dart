import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: BillSplitter(),
    )
  );
}

// class tipapp extends StatefulWidget {
//   const tipapp({Key? key}) : super(key: key);
//
//   @override
//   State<tipapp> createState() => _tipappState();
// }
//
// class _tipappState extends State<tipapp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container (
//         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
//         alignment: Alignment.center,
//         child:ListView(
//           children: [
//             Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  // PROPERTIES
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

 /* Color _purple = HexColor("#6908D6");*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,

        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[

            // TOP CONTAINER
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple, //Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.black),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "\$${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                            fontSize: 34.9,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // BOTTOM CONTAINER
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),

              child: Column(
                children: <Widget>[

                  // TEXTFIELD
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),

                  // SPLIT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.purple),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),


                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),

                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color:Colors.black,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),


                  //Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          " \$${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style: TextStyle(
                              color:Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      )
                    ],
                  ),


                  //Slider
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          //optional
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }


// METHODS
  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
      // no go!

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }

    return totalTip;
  }
}