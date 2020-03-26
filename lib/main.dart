import 'package:flutter/material.dart';

void main() => runApp(CalcMain());

class CalcMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  dynamic text ='0';
  double firstnum = 0;
  double secondnum = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic operator = '';
  dynamic preoperator = '';



  Widget btn(btnText) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
              ),
            ) ,
            onPressed: (){
              calclogic(btnText);
            },
            color: Colors.grey[300],
            padding: EdgeInsets.all(22.0),
            shape: CircleBorder()

        )
    );
  }
  Widget btn1(btnText) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          width:165,
          child: RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
              ),
            ) ,
            onPressed: (){
              calclogic(btnText);
            },
            color:Colors.deepPurple,
            padding: EdgeInsets.all(27.0),
            shape: StadiumBorder(),

          ),
        )
    );
  }

  Widget build(BuildContext buildCx) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text(text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 60.0,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              )
            ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('AC'),
                btn('!'),
                btn('%'),
                btn('/'),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('7'),
                btn('8'),
                btn('9'),
                btn('*'),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('4'),
                btn('5'),
                btn('6'),
                btn('-'),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('1'),
                btn('2'),
                btn('3'),
                btn('+'),
              ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('0'),
                btn('.'),
                btn1('='),
              ],),
          ],
        ),
      ),
    );
  }
  void calclogic(btnText) {
    if(btnText  == 'AC') {
      text ='0';
      firstnum = 0;
      secondnum = 0;
      result = '';
      finalResult = '';
      operator = '';
      preoperator = '';

    }
    else if( operator == '=' && btnText == '=') {
      if(preoperator == '+') {
        finalResult = add();
      } else if( preoperator == '-') {
        finalResult = sub();
      } else if( preoperator == '*') {
        finalResult = mul();
      } else if( preoperator == '/') {
        finalResult = div();
      }else if( preoperator == '%') {
        finalResult = mod();
      }else if( preoperator == '!') {
        finalResult = fact();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/' || btnText == '=') {

      if(firstnum == 0) {
        firstnum = double.parse(result);
      } else {
        secondnum = double.parse(result);
      }

      if(operator == '+') {
        finalResult = add();
      } else if( operator == '-') {
        finalResult = sub();
      } else if( operator == '*') {
        finalResult = mul();
      } else if( operator == '/') {
        finalResult = div();
      }
      preoperator = operator;
      operator = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = firstnum / 100;
      finalResult = doesContainDecimal(result);
    }
    else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    else if(btnText == '!') {
      result = fact();
      finalResult = doesContainDecimal(result);
    }


    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (firstnum + secondnum).toString();
    firstnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (firstnum - secondnum).toString();
    firstnum = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (firstnum * secondnum).toString();
    firstnum = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (firstnum / secondnum).toString();
    firstnum = double.parse(result);
    return doesContainDecimal(result);
  }
  String mod() {
    firstnum = (firstnum / 100);
    return doesContainDecimal(firstnum);
  }
  String fact() {
    dynamic factorial(firstnum){
      if(firstnum<2)
        result = ('1').toString();
      else
        result =(firstnum*factorial(firstnum-1)).toString();}
    firstnum = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}

