import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalc(),
    );
  }
  
}
class SimpleCalc extends StatefulWidget {
  @override
  _SimpleCalcState createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationsize = 38.0;
  double resultFontsize = 48.0;
  buttonPressed(String buttonText) {
setState(() {

  if (buttonText == "c") {  equation = "0"; buttonText = "0";  equationsize = 38.0; result = "0" ;
 resultFontsize = 48.0;}
 else if (buttonText == "del") {   equation = equation.substring(0,equation.length -1); equationsize = 48.0;
   resultFontsize = 38.0; }
  else if (buttonText == "=") {  equationsize = 38.0;
  resultFontsize = 48.0;
  expression = equation ;
  expression = expression.replaceAll("×" , "*");
  expression = expression.replaceAll("÷" , "/");
  try {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm= ContextModel();
    result ='${exp.evaluate(EvaluationType.REAL, cm)}';
  }catch(e){
    result = "error" ;
  }

  }
  else { equationsize = 48.0;
  resultFontsize = 38.0;
    if(equation == "0") { equation = buttonText;  }
    else
  equation =  equation +   buttonText ;
  }
});
  }
  // ignore: non_constant_identifier_names
  Widget BuildButton(String buttontext,double buttonHeight, Color buttonColor) {
    return Padding(
       padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
borderRadius: BorderRadius.circular(14),
        child: Container(

          width: MediaQuery.of(context).size.width*0.1,
          height : MediaQuery.of(context).size.height * 0.1 * buttonHeight ,
          color: buttonColor,
          child: FlatButton(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  side : BorderSide(
                    color: Colors.white,
                    width: 0.6,

                  )
              ),
              padding: EdgeInsets.all(16),
              onPressed: () => buttonPressed(buttontext),
              child: Text(
                buttontext,style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
              ),
              )
          ),

        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body:

      Column(children: [
        SafeArea(
          child: Container(

            alignment: Alignment.centerRight  ,
            padding: EdgeInsets.fromLTRB(10,20,10,0),
            child: Text(equation,style: TextStyle(fontSize: equationsize ,color: Colors.white) ,),
          ),
        ),
        Container(

          alignment: Alignment.centerRight  ,
          padding: EdgeInsets.fromLTRB(10,20,10,0),
          child: Text(result,style: TextStyle(fontSize: resultFontsize, color: Colors.white  ),),
        ),
        Expanded(child: Divider(

        ),),
       Row(

         mainAxisAlignment: MainAxisAlignment.start,
         children: [
       Padding(
         padding: const EdgeInsets.only(bottom: 20),
         child: Container(
           width: MediaQuery.of(context).size.width*1,
           child: Table(
             children: [
               TableRow(
                 children: [
                   BuildButton("c", 1, Color(0xff272f3c)),

                   BuildButton("del", 1, Color(0xff272f3c)),
                   BuildButton("%", 1,Color(0xff272f3c)),
                   BuildButton("*",1, Color(0xff272f3c)),
                 ]


               ),
               TableRow(
                   children: [
                     BuildButton("9", 1, Color(0xff323a4d)),
                     BuildButton("8", 1, Color(0xff323a4d)),
                     BuildButton("7", 1,Color(0xff323a4d)),
                     BuildButton("-",1, Color(0xff272f3c)),
                   ]


               ),
               TableRow(
                   children: [
                     BuildButton("6", 1, Color(0xff323a4d)),
                     BuildButton("5", 1, Color(0xff323a4d)),
                     BuildButton("4", 1,Color(0xff323a4d)),
                     BuildButton("+",1, Color(0xff272f3c)),
                   ]


               ),
               TableRow(
                   children: [
                     BuildButton("3", 1, Color(0xff323a4d)),
                     BuildButton("2", 1, Color(0xff323a4d)),
                     BuildButton("1", 1,Color(0xff323a4d)),
                     BuildButton("/",1, Color(0xff272f3c))
                   ]


               ),
               TableRow(
                   children: [
                     BuildButton("0", 1, Color(0xff323a4d)),
                     BuildButton(".", 1, Color(0xff323a4d)),
                     BuildButton("ans", 1,Color(0xff323a4d)),
                     BuildButton("=",1, Color(0xff53b369))
                   ]


               ),
             ],

           ),
         ),
       ),


       ],)
      ],),
      backgroundColor: Color(0xff101010),
    );
  }
}

