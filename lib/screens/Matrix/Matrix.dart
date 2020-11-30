import 'package:flutter/material.dart';

class Matrix extends StatelessWidget{
   List<int> edge1,edge2;
   List<String> nameNode,nameEdge;
   int size;
   Matrix(this.edge1,this.edge2,this.size,this.nameNode,this.nameEdge);
   @override
   Widget build(BuildContext context) {
     return Scaffold(
         body: _Matrix()
     );
   }
   Widget _Matrix(){
     int gridLength = size+1;
     return Column(
       children: <Widget>[
         AspectRatio(
           aspectRatio: 1.0,
           child: Container(
             padding: const EdgeInsets.all(8.0),
             margin: const EdgeInsets.all(8.0),
             child: GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridLength),
               itemBuilder: _buildGridItems,
               itemCount: gridLength*gridLength,
             ),
           ),
         )
       ],
     );
   }

  void setSize(int size){
    this.size = size;
  }
  void setEdge1(List<int> edge1){
    this.edge1 = edge1;
  }
  void setEdge2(List<int> edge2){
     this.edge2 = edge2;
  }
  void setNameNode(List<String> nameNode){
    this.nameNode = nameNode;
  }
  void setNameEdge(List<String> nameEdge){
    this.nameEdge = nameEdge;
  }
  Widget _buildGridItems(BuildContext context,int index){
    int gridLength = size+1;
    int x,y = 0;
    x = (index / gridLength).floor();
    y = (index % gridLength);
    String conn = '0';
    int a = x-1;
    int b = y-1;
    for(int i=0;i<edge1.length;i++){
      if(a == edge1[i] && b == edge2[i]){
        conn = nameEdge[i];
      }
    }
    for(int i=0;i<edge2.length;i++){
      if(b==edge2[i] && a==edge1[i]){
        conn = nameEdge[i];
      }
    }
    Color color= Colors.black;
    if(x==0 || y==0){
      color = Colors.black;
      if(x==0 && y==0){
        conn = ' ';
      }
      if(x==0 && y!=0){
        conn = nameNode[y-1];
      }
      if(x!=0 && y==0){
        conn = nameNode[x-1];
      }
    }

    return GridTile(
      child: Container(

        child: Center(
          child: Text(conn,style: TextStyle(color: color, fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}

