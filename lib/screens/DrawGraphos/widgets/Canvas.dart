import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Nodes.dart';

class Canvas extends StatefulWidget {
  List<double> px=List<double>();
  List<double> py=List<double>();
  List<int> edge1 = List<int>();
  List<int> edge2 = List<int>();
  List<String> nameNode = List<String>();
  List<String> nameEdge = List<String>();
  @override
  State<StatefulWidget> createState(){
    return Canva(px,py,edge1,edge2,nameNode,nameEdge);
  }
}
class Canva extends State<Canvas> {
  int option=-1;
  int selected=-1;
  bool move=false;
  List<double> px=List<double>();
  List<double> py=List<double>();
  List<String> nameNode = List<String>();
  List<String> nameEdge = List<String>();
  List<int> cr=List<int>();
  List<int> cg=List<int>();
  List<int> cb=List<int>();
  List<int> edge1 = List<int>();
  List<int> edge2 = List<int>();
  int conection = -1;
  var gr=Random();
  TextEditingController _textFieldNodeController = TextEditingController();
  TextEditingController _textFieldEdgeController = TextEditingController();
  Canva(this.px,this.py,this.edge1,this.edge2,this.nameNode,this.nameEdge);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (TapDownDetails details) => _onTapDown(details),
        onTapUp: (TapUpDetails details) => _onTapUp(details),
        onPanStart: (DragStartDetails details)=> _onPanStart(details),
        onPanUpdate: (DragUpdateDetails details)=> _onPanUpdate(details),
        onPanDown: (DragDownDetails details)=> _onPanDown(details),
        child: Stack(
          children: <Widget>[
            CustomPaint(painter: Nodes(px,py,cr,cg,cb,edge1,edge2,nameNode,nameEdge),child: Container(),),
          ],
        ),
      ),

    );
  }
  _onPanDown(DragDownDetails details){
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
  }
  _onPanStart(DragStartDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    double xx = double.parse(x.toString());
    double yy = double.parse(y.toString());
    yy -= 80;
    setState(() {
      conection = -1;
      double dist=0;
      for(int i=0;i<px.length;i++){
        double delx=(px[i]-xx);
        double dely=(py[i]-yy);
        dist=sqrt((delx*delx)+(dely*dely));
        if(dist<=30){
          selected=i;
        }
      }

    });
  }
  _onPanUpdate(DragUpdateDetails details){
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print("on pan update "+x.toString()+","+y.toString());
    double xx=double.parse(x.toString());
    double yy=double.parse(y.toString());
    yy-=80;
    setState(() {
      conection = -1;
      px[selected]=xx;
      py[selected]=yy;
    });
  }
  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    double xx=double.parse(x.toString());
    double yy=double.parse(y.toString());
    setState(() {
      int sel = isInCircle(xx, yy-80);
      if(sel!=-1){
        if(conection != -1){
          edge1.add(conection);
          edge2.add(sel);
          _displayDialogEdge(context);
          conection = -1;
        }
        else{
          conection = sel;
        }
      }
      else{
        conection = -1;
        if(conection == -1) {
          px.add(xx);
          py.add(yy - 80);
          selected = px.length - 1;
          cr.add(gr.nextInt(256));
          cg.add(gr.nextInt(256));
          cb.add(gr.nextInt(256));
          _displayDialogNode(context);
        }
      }
    });
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
  }
  int isInCircle(double x,double y){
    int res = -1;
    for(int i=0;i<px.length;i++){
      double dist = sqrt(((px[i]-x)*(px[i]-x))+((py[i]-y)*(py[i]-y)));
      if(dist<=30){
        res = i;
      }
    }
    return res;
  }
  _displayDialogNode(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text('Ingrese Nombre del Nodo'),
            content: CupertinoTextField(
              controller: _textFieldNodeController,
              placeholder: "Enter Node",
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: (){
                  print('The name node is:');
                  print(_textFieldNodeController.text);
                  setState(() {
                    nameNode.add(_textFieldNodeController.text);
                    _textFieldNodeController.clear();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
  _displayDialogEdge(BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text('Add relationship value'),
            content: CupertinoTextField(
              controller: _textFieldEdgeController,
              placeholder: "Value",
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok'),
                onPressed: (){
                  setState(() {
                    nameEdge.add(_textFieldEdgeController.text);
                    _textFieldEdgeController.clear();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }
}

