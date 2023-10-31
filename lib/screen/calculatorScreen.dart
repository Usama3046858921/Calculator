import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20.5),
        children: [
          Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              margin: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1),
              decoration: BoxDecoration(
                color: const Color(0xff6908D6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Per Person',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff6908D6),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '\$ ${calculateTotalPerPerson(
                          _billAmount, _personCounter, _tipPercentage)}',
                      style: TextStyle(
                        color: Color(0xff6908D6),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.blueGrey.shade100,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    color: const Color(0xff6908D6),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                      prefixText: 'Bill Amount: ',
                      prefixIcon: Icon(Icons.attach_money)),
                  onChanged: (value) {
                    try {
                      _billAmount = double.parse(value);
                    } catch (e) {
                      _billAmount = 0.0;
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Split',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_personCounter > 1) {
                                _personCounter--;
                              } else {}
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xff6908D6).withOpacity(0.1),
                            ),
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    color: Color(0xff6908D6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '$_personCounter',
                          style: const TextStyle(
                            color: Color(0xff6908D6),
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _personCounter++;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xff6908D6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    color: Color(0xff6908D6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tip',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "\$ ${(calculateTotalTip(
                            _billAmount, _personCounter, _tipPercentage))
                            .toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(0xff6908D6),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '$_tipPercentage %',
                      style: const TextStyle(
                        color: Color(0xff6908D6),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                        min: 0,
                        max: 100,
                        divisions: 10,
                        activeColor: const Color(0xff6908D6),
                        inactiveColor: Colors.grey,
                        value: _tipPercentage.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _tipPercentage = value.round();
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson = (calculateTotalTip(
        billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount
        .toString()
        .isEmpty || billAmount == null) {} else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
