import 'package:flutter/material.dart';

class firstscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Card(
            child: Text(
              "PAGE ONE",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.teal,
              ),
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(200.0),
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/second');
                  },
                  child: Text("PRESS ME TO NAVIGATE NEXT PAGE",
                    style: TextStyle(fontSize: 50,color: Colors.white),
                  )
              ),
            ),
          ),
          //IMAGE INSERTION FROM INTERNET
          Expanded(
          child: Image(height:800,image: NetworkImage( "https://localist-images.azureedge.net/photos/31583518696354/original/0135374d81d3481dd24228d0deea271b904000a5.png"),)

          ),

        ],
      ),
    );

  }
}