import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';

class Nodes extends CustomPainter{
  List<double>px,py;
  List<int>cr,cg,cb,edge1,edge2;
  List<String> nameNode,nameEdge;
  Nodes(this.px,this.py,this.cr,this.cg,this.cb,this.edge1,this.edge2,this.nameNode,this.nameEdge);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint()
      ..color=Colors.amber
      ..style=PaintingStyle.fill
      ..strokeWidth=1.1;

    for(int i=0;i<px.length;i++){
      paint.color=Colors.amber;
      canvas.drawCircle(Offset(px[i], py[i]), 45, paint);
      _makeText(canvas, nameNode[i],new Offset(px[i]-10, py[i]-10));
    }
    //Draw Connections
    paint.color = Colors.black54;
    for(int i=0;i<edge1.length;i++){
      //Code to make a connection
      double radius = 40;
      double pcx1,pcy1,pcx2,pcy2;
      //Connection into borders of nodes
      //First Border Calculate the point of border
      double a = (py[edge2[i]]-py[edge1[i]])/(px[edge2[i]]-px[edge1[i]]);
      double b = py[edge1[i]]-(a*px[edge1[i]]);
      double r = (1+(a*a));
      double s = 2*((a*b)-px[edge1[i]]-(a*py[edge1[i]]));
      double t = ((px[edge1[i]]*px[edge1[i]])+(b*b)+(py[edge1[i]]*py[edge1[i]])-(2*b*py[edge1[i]])-(radius*radius));
      double px1 = (-s+sqrt((s*s)-(4*r*t)))/(2*r);
      double px2 = (-s-sqrt((s*s)-(4*r*t)))/(2*r);
      double py1 = a*px1+b;
      double py2 = a*px2+b;
      double dist1 = distance(px1,py1,px[edge2[i]],py[edge2[i]]);
      double dist2 = distance(px2,py2,px[edge2[i]],py[edge2[i]]);
      if(dist1<dist2){
        pcx1 = px1;
        pcy1 = py1;
      }
      else{
        pcx1 = px2;
        pcy1 = py2;
      }
      //Second border, calculate the point of second border
      a = (py[edge2[i]]-py[edge1[i]])/(px[edge2[i]]-px[edge1[i]]);
      b = py[edge1[i]]-(a*px[edge1[i]]);
      r = (1+(a*a));
      s = 2*((a*b)-px[edge2[i]]-(a*py[edge2[i]]));
      t = ((px[edge2[i]]*px[edge2[i]])+(b*b)+(py[edge2[i]]*py[edge2[i]])-(2*b*py[edge2[i]])-(radius*radius));
      px1 = (-s+sqrt((s*s)-(4*r*t)))/(2*r);
      px2 = (-s-sqrt((s*s)-(4*r*t)))/(2*r);
      py1 = a*px1+b;
      py2 = a*px2+b;
      dist1 = distance(px1,py1,px[edge1[i]],py[edge1[i]]);
      dist2 = distance(px2,py2,px[edge1[i]],py[edge1[i]]);
      if(dist1<dist2){
        pcx2 = px1;
        pcy2 = py1;
      }
      else{
        pcx2 = px2;
        pcy2 = py2;
      }
      Path path;
      Paint paint = Paint()
        ..color = Colors.black54
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = 1.5;
      path = Path();

      if(edge1[i] == edge2[i]){
        path.moveTo(px[edge1[i]],py[edge1[i]]-radius);
        path.quadraticBezierTo(px[edge1[i]]-50,py[edge1[i]] - 50,px[edge1[i]]-30, py[edge1[i]]);
        path = ArrowPath.make(path: path);
        canvas.drawPath(path, paint..color = Colors.black);
        _makeText(canvas,nameEdge[i],new Offset(px[edge1[i]]-50,py[edge1[i]] - 50));
      }
      else{
        path.moveTo(pcx1, pcy1);
        double mid1=(pcx1+pcx2)/2;
        double mid2=(pcy1+pcy2)/2;
        //Code for a previous conection between two nodes
        bool result = false;
        for(int j=0;j<i;j++){
          //Check for invert edge
          if(edge1[j]==edge2[i] && edge1[i]==edge2[j]){
            result = true;
          }
        }
        double dx=(pcx2-pcx1).abs();
        double dy=(pcy2-pcy1).abs();
        if(result){
          if(dx>=dy) {
            path.quadraticBezierTo(mid1, mid2 - 50, pcx2, pcy2);
            _makeText(canvas,nameEdge[i],new Offset(mid1,mid2-50));
          }
          else{
            path.quadraticBezierTo(mid1-50, mid2, pcx2, pcy2);
            _makeText(canvas,nameEdge[i],new Offset(mid1-50,mid2));
          }
        }
        else{
          if(dx>=dy){
            path.quadraticBezierTo(mid1,mid2+50,pcx2,pcy2);
            _makeText(canvas,nameEdge[i],new Offset(mid1,mid2+50));
          }
          else{
            path.quadraticBezierTo(mid1+50,mid2,pcx2,pcy2);
            _makeText(canvas,nameEdge[i],new Offset(mid1+50,mid2));
          }

        }
        path = ArrowPath.make(path: path);
        canvas.drawPath(path, paint..color = Colors.black);

      }
    }
  }
  void _makeText(Canvas canvas, String text, Offset position){
    TextSpan span = new TextSpan(style: new TextStyle(color: Colors.black, fontSize: 25.0), text: text);
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, position);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  double distance(double x1,double y1,double x2,double y2){
    double dist = sqrt(((x1-x2)*(x1-x2))+((y1-y2)-(y1-y2)));
    return dist;
  }
}
