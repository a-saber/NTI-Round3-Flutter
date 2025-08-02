import 'package:flutter/material.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.red,
          size: 30,
        ),
        title: Text('Home',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 35,
            fontWeight: FontWeight.w100,
          ),
        ),
        actions: 
        [
          Text('Add'),
          // SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: Icon(Icons.person),
          ),


        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children:
          [
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemBuilder: ( BuildContext context, int index)=> ProductHorizontalItem(),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 50,),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (context, index)=> ProductVerticalItemBuilder())
          ],
        ),
      )
    );
  }
}

class ProductHorizontalItem extends StatelessWidget {
  const ProductHorizontalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children:
        [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://septemberfarmcheese.b-cdn.net/wp-content/uploads/Blogs/Homemade-Pizza/homemade-pizza-monterey-jack-cheese.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(height: 5,),
          Row(
            children:
            [
              Text('Product Name'),
              SizedBox(width: 5,),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}


class ProductVerticalItemBuilder extends StatelessWidget {
  const ProductVerticalItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(100),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children:
        [
          Container(
            height: 100, width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('https://septemberfarmcheese.b-cdn.net/wp-content/uploads/Blogs/Homemade-Pizza/homemade-pizza-monterey-jack-cheese.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Expanded(child: Text('Product Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17
                    ),)),
                    Text('50\$', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      color: Colors.red
                    ),),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Description',  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class DefaultRow extends StatelessWidget {
  const DefaultRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
      [

        for(int i=0;i<3;i++)
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              // borderRadius: BorderRadius.circular(10),
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                  top: BorderSide(
                  color: Colors.blue,
                  width: 2,
                )
              )
              // shape: BoxShape.circle
            ),
          ),

      ],
    );
  }
}


