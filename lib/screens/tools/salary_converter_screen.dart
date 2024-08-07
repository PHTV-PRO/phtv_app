import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:phtv_app/modals/login_request.dart';
import 'package:phtv_app/screens/my_cv/my_cv_screen.dart';

class SalaryConverterScreen extends StatefulWidget{
  const SalaryConverterScreen({super.key});

  @override
  State<SalaryConverterScreen> createState() => _SalaryConverterScreenState();
}

class _SalaryConverterScreenState extends State<SalaryConverterScreen> {
  final _formKeySalary = GlobalKey<FormState>();
  final TextEditingController _salaryCtlr = TextEditingController();
  final TextEditingController _insPreimunCtrl = TextEditingController();
  String _salary = '';
  String _noDepdent = '';
  String _insPreimun = '';
  String _region = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _region = '1';
    });
  }

  @override
  void dispose() {
    _salaryCtlr.dispose();
    _insPreimunCtrl.dispose();
    super.dispose();
  }

  calGrossToNet() {
    final isValid = _formKeySalary.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeySalary.currentState!.save();
    // FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              salGrossNetResult(_salary, _noDepdent, _insPreimun, _region),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Close'),
              ),
              const SizedBox(height: 12)
            ],
          );
        }
    );
    FocusScope.of(context).requestFocus(FocusNode());
  }

  calNetToGross() {
    final isValid = _formKeySalary.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeySalary.currentState!.save();
    // FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (BuildContext context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              salNetGrossResult(_salary, _noDepdent, _insPreimun, _region),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Close'),
              ),
              const SizedBox(height: 12)
            ],
          );
        }
    );
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Salary Converter', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKeySalary,
            child: Column(
              children: [
                TextFormField(
                  decoration: salFormField('Salary', const Icon(Icons.monetization_on_outlined)),
                  controller: _salaryCtlr,
                  autocorrect: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please fill in your salary';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (string) {
                    string = formNum(
                      string.replaceAll(',', ''),
                    );
                    _salaryCtlr.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(
                        offset: string.length,
                      ),
                    );
                  },
                  onSaved: (value) {
                    _salary = value!;
                  },
                ),
                const SizedBox(height: 26),
                TextFormField(
                  decoration: salFormField('Number of dependents', const Icon(Icons.people_alt_outlined)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please fill in number of dependents';
                    }
                    if(int.tryParse(value)! < 0 || int.tryParse(value)! > 10){
                      return 'Number of dependents must between 0-10';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _noDepdent = value!;
                  },
                ),
                const SizedBox(height: 26),
                TextFormField(
                  controller: _insPreimunCtrl,
                  decoration: salFormField('Insurance premiums', const Icon(Icons.monetization_on_outlined)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please fill in insurance premiums';
                    }
                    return null;
                  },
                  onChanged: (string) {
                    string = formNum(
                      string.replaceAll(',', ''),
                    );
                    _insPreimunCtrl.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(
                        offset: string.length,
                      ),
                    );
                  },
                  onSaved: (value) {
                    _insPreimun = value!;
                  },
                ),
                const SizedBox(height: 32),
                const Row(
                  children: [
                    Text('Region', textAlign: TextAlign.start,),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text('I'),
                        horizontalTitleGap: 0,
                        contentPadding: const EdgeInsets.all(0),

                        leading: Radio(
                          value: '1',
                          groupValue: _region,
                          onChanged: (value) {
                            setState(() {
                              _region = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('II'),
                        horizontalTitleGap: 0,
                        contentPadding: const EdgeInsets.all(0),
                        leading: Radio(
                          value: '2',
                          groupValue: _region,
                          onChanged: (value) {
                            setState(() {
                              _region = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('III'),
                        horizontalTitleGap: 0,
                        contentPadding: const EdgeInsets.all(0),
                        leading: Radio(
                          value: '3',
                          groupValue: _region,
                          onChanged: (value) {
                            setState(() {
                              _region = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('IV'),
                        horizontalTitleGap: 0,
                        contentPadding: const EdgeInsets.all(0),
                        leading: Radio(
                          value: '4',
                          groupValue: _region,
                          onChanged: (value) {
                            setState(() {
                              _region = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: calGrossToNet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Gross -> Net'),
                    ),
                    const SizedBox(width: 32),
                    ElevatedButton(
                      onPressed: calNetToGross,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Net -> Gross'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration salFormField (String text, Icon icon){
  return InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
        const Text('*', style: TextStyle(color: Colors.red)),
      ],
    ),
    suffixIcon: icon,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    filled: true,
    fillColor: Colors.white,
    errorStyle: const TextStyle(color: Colors.red),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  );
}

roundToIntThousand (double num){
  return (num/1000).toInt() * 1000;
}

calPersonalTaxGrossNet(int num){
  double calNum = num/1000000;
  double rs = 0;
  if(calNum <= 5){
    rs = calNum * 0.05;
  }else if(calNum <= 10){
    rs = (calNum - 5) * 0.1 + 0.25;
  }else if(calNum <= 18){
    rs = (calNum - 10) * 0.15 + 0.75;
  }else if(calNum <= 32){
    rs = (calNum - 18) * 0.20 + 1.95;
  }else if(calNum <= 52){
    rs = (calNum - 32) * 0.25 + 4.75;
  }else if(calNum <= 80){
    rs = (calNum - 52) * 0.30 + 9.75;
  }else{
    rs = (calNum - 80) * 0.35 + 18.15;
  }
  return (rs*1000000).toInt();
}

calUi(int zone){
  if(zone == 1){
    return 992000;
  }else if(zone == 2){
    return 882000;
  }else if(zone == 3){
    return 772000;
  }else if(zone == 4){
    return 690000;
  }
}

Container salGrossNetResult (String sal, String dpDedct, String insPre, String region) {
  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );
  int salary = roundToIntThousand(double.tryParse(sal.replaceAll(',', ''))!);
  int dptDeduct = int.tryParse(dpDedct)!;
  int insurPremium = roundToIntThousand(double.tryParse(insPre.replaceAll(',', ''))!);
  int regionZone = int.tryParse(region)!;

  int salSi = roundToIntThousand(insurPremium > 46800000 ? 46800000 * 0.08 : insurPremium * 0.08);
  int salHi = roundToIntThousand(insurPremium > 46800000 ? 46800000 * 0.015 : insurPremium * 0.015);
  int salUi = calUi(regionZone);
  int incomeBefTax = salary - (salSi + salHi + salUi);
  int indiDeduct = 11000000;
  int depentDeduct = dptDeduct * 4400000;
  int taxableIncome = incomeBefTax - (indiDeduct + depentDeduct);
  int personalTax = calPersonalTaxGrossNet(taxableIncome);
  int netIncome = incomeBefTax - personalTax;

  Padding fieldName (String text){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(text),
    );
  }

  Padding value (String text){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(text, textAlign: TextAlign.end),
    );
  }
  return Container(
      width: double.infinity,
      height: 550,
      padding: const EdgeInsets.all(20),
      child: Table(
        border: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Colors.black54),
        columnWidths: const {
          0: FlexColumnWidth(5),
          1: FlexColumnWidth(3),
        },
        children: [
          const TableRow(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Gross income', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Value (vnd)', textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold),),
                ),
          ]),
          TableRow( children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Gross income', style: TextStyle(color: Colors.red),),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(formatter.format(salary), textAlign: TextAlign.end, style: const TextStyle(color: Colors.red),),
            ),
          ]),
          TableRow( children: [
            fieldName('SI (8%)'),
            value('- ${formatter.format(salSi)}')
          ]),
          TableRow( children: [
            fieldName('HI (1.5%)'),
            value('- ${formatter.format(salHi)}')
          ]),
          TableRow( children: [
            fieldName('UI (1%)'),
            value('- ${formatter.format(salUi)}')
          ]),
          TableRow( children: [
            fieldName('Zone'),
            value(regionZone.toString())
          ]),
          TableRow( children: [
            fieldName('Income before tax'),
            value(formatter.format(incomeBefTax))
          ]),
          TableRow( children: [
            fieldName('Individual deduction'),
            value('- ${formatter.format(indiDeduct)}')
          ]),
          TableRow( children: [
            fieldName('Dependents deduction'),
            value('- ${formatter.format(depentDeduct)}')
          ]),
          TableRow( children: [
            fieldName('Taxable income'),
            value(formatter.format(taxableIncome))
          ]),
          TableRow( children: [
            fieldName('Personal income tax'),
            value('- ${formatter.format(personalTax)}')
          ]),
          TableRow( children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Net income', style: TextStyle(color: Colors.red),),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(formatter.format(netIncome), textAlign: TextAlign.end, style: const TextStyle(color: Colors.red),),
            ),
          ]),
        ],
      ),
  );
}

calGrossTemp(int num){
  double rs = 0;
  if(num > 61850000){
    rs = (num-9850000)/0.65;
  }else if(num > 42250000){
    rs = (num-5850000)/0.7;
  }else if(num > 27250000){
    rs = (num-3250000)/0.75;
  }else if(num > 16050000){
    rs = (num-1650000)/0.8;
  }else if(num > 9250000){
    rs = (num-750000)/0.85;
  }else if(num > 4750000){
    rs = (num-250000)/0.9;
  }else{
    rs = (num)/0.95;
  }
  return rs.toInt();
}

calPersonalTaxNetGross(int num){
  double rs = 0;
  if(num > 80000000){
    rs = num*0.35 - 9850000;
  }else if(num > 52000000){
    rs = num*0.30 - 5850000;
  }else if(num > 32000000){
    rs = num*0.25 - 3250000;
  }else if(num > 18000000){
    rs = num*0.20 - 1650000;
  }else if(num > 10000000){
    rs = num*0.15 - 750000;
  }else if(num > 5000000){
    rs = num*0.1 - 250000;
  }else{
    rs = num*0.05;
  }
  return rs.toInt();
}

Container salNetGrossResult (String sal, String dpDedct, String insPre, String region) {
  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );
  int salary = roundToIntThousand(double.tryParse(sal.replaceAll(',', ''))!);
  int dptDeduct = int.tryParse(dpDedct)!;
  int insurPremium = roundToIntThousand(double.tryParse(insPre.replaceAll(',', ''))!);
  int regionZone = int.tryParse(region)!;

  int salSi = roundToIntThousand(insurPremium > 46800000 ? 46800000 * 0.08 : insurPremium * 0.08);
  int salHi = roundToIntThousand(insurPremium > 46800000 ? 46800000 * 0.015 : insurPremium * 0.015);
  int salUi = calUi(regionZone);
  int indiDeduct = 11000000;
  int depentDeduct = dptDeduct * 4400000;
  int taxableIncome = salary - indiDeduct - depentDeduct;
  int taxableIncomeTemp = calGrossTemp(taxableIncome);
  int personalTax = calPersonalTaxNetGross(taxableIncomeTemp);
  int netIncome = salary;
  int incomeBefTax = taxableIncomeTemp + indiDeduct + depentDeduct;
  int grossIncome = incomeBefTax + salSi + salHi + salUi;

  Padding fieldName (String text){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(text),
    );
  }

  Padding value (String text){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(text, textAlign: TextAlign.end),
    );
  }
  return Container(
    width: double.infinity,
    height: 550,
    padding: const EdgeInsets.all(20),
    child: Table(
      border: TableBorder.all(borderRadius: BorderRadius.circular(10), color: Colors.black54),
      columnWidths: const {
        0: FlexColumnWidth(5),
        1: FlexColumnWidth(3),
      },
      children: [
        const TableRow(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Gross income', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Value (vnd)', textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ]),
        TableRow( children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Gross income', style: TextStyle(color: Colors.red),),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(formatter.format(grossIncome), textAlign: TextAlign.end, style: const TextStyle(color: Colors.red),),
          ),
        ]),
        TableRow( children: [
          fieldName('SI (8%)'),
          value('- ${formatter.format(salSi)}')
        ]),
        TableRow( children: [
          fieldName('HI (1.5%)'),
          value('- ${formatter.format(salHi)}')
        ]),
        TableRow( children: [
          fieldName('UI (1%)'),
          value('- ${formatter.format(salUi)}')
        ]),
        TableRow( children: [
          fieldName('Zone'),
          value(regionZone.toString())
        ]),
        TableRow( children: [
          fieldName('Income before tax'),
          value(formatter.format(incomeBefTax))
        ]),
        TableRow( children: [
          fieldName('Individual deduction'),
          value('- ${formatter.format(indiDeduct)}')
        ]),
        TableRow( children: [
          fieldName('Dependents deduction'),
          value('- ${formatter.format(depentDeduct)}')
        ]),
        TableRow( children: [
          fieldName('Taxable income'),
          value(formatter.format(taxableIncomeTemp))
        ]),
        TableRow( children: [
          fieldName('Personal income tax'),
          value('- ${formatter.format(personalTax)}')
        ]),
        TableRow( children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text('Net income', style: TextStyle(color: Colors.red),),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(formatter.format(netIncome), textAlign: TextAlign.end, style: const TextStyle(color: Colors.red),),
          ),
        ]),
      ],
    ),
  );
}