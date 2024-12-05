import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  Actiivity current=acts[0];
  String unit="ml";
  double totalWater = double.parse(acts[0].getWater());
  double x=0 ,r=0;
  void updateweight(kg){

    x=double.parse(kg);


  }

  void Updateresult() {
    setState(() {
      if (x == 0) {
        r = 0;
      }
      if (x != 0 && unit == 'mL') {
        r = totalWater + (x * 35);
      }
      else if (x != 0 && unit == 'L') {
        r = (totalWater + (x * 35)) / 1000;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:

        Image.asset(
          'images/l.png',
          width: 400,
          height: 110,
        ),
      ),

      body:Container(
        color: Colors.lightBlue[50],
        child:   Center(
          child: Column( children: [
            SizedBox(height: 30,),
            Text('Child Water  Calculator',  style: TextStyle( fontSize: 20 ,fontWeight:FontWeight.bold,
                color:Colors.teal)),
            SizedBox(height: 20,),
            SizedBox(width: 300,
              height: 100,
              child:textfeild(f: updateweight, hint:  'Enter child weight(kg)',)
              ,
            ),

            Text(" Add activity level",
                style: TextStyle( fontSize: 20 ,fontWeight:FontWeight.bold,
                    color:Colors.teal)
            ),
            SizedBox(height: 10),

            dropdownmenue(updateact: (k){
              this.current=k;
              totalWater=double.parse(k.getWater());
            },

            ),
            SizedBox(height: 20),




            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Unit: '),
                Radio<String>(
                  value: 'mL',
                  groupValue: unit,
                  onChanged: (value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                ),
                Text('milliter'),
                Radio<String>(
                  value: 'L',
                  groupValue: unit,
                  onChanged: (value) {
                    setState(() {
                      unit = value!;
                    });
                  },
                ),
                Text('Liter'),
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(width:160,
              child:    ElevatedButton(onPressed:(){Updateresult();  }, child:
              Icon(Icons.water_drop,  size: 30),

              ),),


            SizedBox(height: 13),
            Text('the child need drink $r $unit',style: TextStyle(fontSize: 20 ,fontWeight:FontWeight.bold,
                color:Colors.teal),
            ),

            SizedBox(height: 13),
            Text("A Baby Start Drinkig water at 6 months",style: TextStyle(fontSize: 17 ,fontWeight:FontWeight.bold,
                color:Colors.green),
            ),
          ],
          ),
        ),


      ),
    );
  }
}






class textfeild extends StatelessWidget {
  String hint;
  Function (String) f;
  textfeild({required this.f,required this.hint, super.key});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      keyboardType: TextInputType.number,
      decoration:
      InputDecoration(border: OutlineInputBorder(),hintText: hint),
      onChanged:(t){ f(t);
      },
    );
  }
}




class dropdownmenue extends StatefulWidget {
  final Function(Actiivity) updateact;



  const dropdownmenue({super.key , required this.updateact});

  @override
  State<dropdownmenue> createState() => _dropdownmenueState();
}

class _dropdownmenueState extends State<dropdownmenue> {




  @override
  Widget build(BuildContext context) {
    return DropdownMenu(


      width: 300,

      dropdownMenuEntries: acts.map((e)=>
          DropdownMenuEntry(value: e, label: e.toString())).toList(),
      initialSelection: acts[0],
      onSelected: (abc){
        widget.updateact(abc as Actiivity);
      },

    );
  }
}


class Actiivity{

  String level;
  double r=0;
  Actiivity(this.level);
  @override
  String toString() {
    return '$level';
  }

  String getWater(){
    if(level=='Active'){
      r=300;
    }
    else if(level=='Moderate'){
      r=100;
    }
    else{
      r+=0;
    }
    return r.toString();
  }
}
List<Actiivity>acts=[
  Actiivity('Active'),
  Actiivity('Moderate'),
  Actiivity('Low'),
];

