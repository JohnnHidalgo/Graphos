import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'widgets/Canvas.dart';
import '../Matrix/Matrix.dart';
class DrawGraphos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _DrawGraphos();
  }
}
class _DrawGraphos extends State<DrawGraphos>{
  int indexTap = 0;
  static int size = 0;
  static List<int> edge1 = List<int>();
  static List<int> edge2 = List<int>();
  static List<String> nameNode = List<String>();
  static List<String> nameEdge = List<String>();
  static Canvas drawPage = Canvas();

  static Matrix matrix = Matrix(edge1, edge2, size,nameNode,nameEdge);

  final List<Widget> widgetsChildren = [drawPage,matrix];
  void onTapTapped(int index){
    setState(() {
      indexTap = index;
      edge1 = drawPage.edge1;
      edge2 = drawPage.edge2;
      size = drawPage.px.length;
      nameNode = drawPage.nameNode;
      nameEdge = drawPage.nameEdge;
      matrix.setSize(size);
      matrix.setEdge1(edge1);
      matrix.setEdge2(edge2);
      matrix.setNameEdge(nameEdge);
      matrix.setNameNode(nameNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle : Text('Home'),
      ),
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.blue
        ),
        child: BottomNavigationBar(
            onTap: onTapTapped,
            currentIndex: indexTap,
            items:[
          BottomNavigationBarItem(
            icon: Icon(prefix0.CupertinoIcons.create),
            title: Text("Draw Graphos")
          ),
          BottomNavigationBarItem(
              icon: Icon(prefix0.CupertinoIcons.fullscreen),
              title: Text("Generate Matrix")
          ),
        ]),
      ),
    );
  }

}