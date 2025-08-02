import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      debugShowCheckedModeBanner: false,
      home: TestView(),
    );
  }
}

class TestView extends StatelessWidget {
  TestView({super.key});

  Map<String, String> countriesCodes = {
    'Egypt': '+20',
    'KSA': '+966',
    'UAE': '+971'
  };

  // List<String> countries = [
  //   'Egypt',
  //   'KSA',
  //   'UAE'
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Image.asset('assets/test.jpg'),
          Text(
            'Hello World',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hello World',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold
                // fontFamily: 'Cairo'
                ),
          ),
          TextFormField(
            // initialValue: 'ahmed',
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.green),
            // obscureText: true,
            // obscuringCharacter: '*',
            onTap: () {
              print('field pressed');
              // showTimePicker(
              //   context: context,
              //   initialTime: TimeOfDay. now()
              // );
            },
            onChanged: (String value) {
              print(value);
            },
            // enabled: false,
            // readOnly: true,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.title),
              // prefix: Icon(Icons.title),
              suffixIcon: IconButton(
                  onPressed: () {
                    print('icon pressed');
                  },
                  icon: Icon(Icons.lock)),
              // suffix: Icon(Icons.lock),
              // suffix: ,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: BorderSide(color: Colors.black)),
              // focusedBorder: UnderlineInputBorder(),
              labelText: 'Date',
              hintText: 'Enter Your Name',
            ),
          ),
          DropdownButtonFormField(
            items: countriesCodes
                .map((String countryName, countryCode) =>
                  MapEntry(
                    countryName,
                    DropdownMenuItem(
                      value: countryCode,
                      child: Row(
                        children: [
                          Icon(Icons.flag),
                          Text('hi'),
                          Text(countryName),
                          Text(countryCode),
                        ],
                      ),
                    )
                  )
                )
                .values
                .toList(),
            onChanged: (value) {
              print(value);
            },
          )
        ],
      ),
    ));
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
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 35,
              fontWeight: FontWeight.w100,
            ),
          ),
          actions: [
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      ProductHorizontalItem(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 50,
            )),
            SliverList.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ProductVerticalItemBuilder()),
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //       (context, index)=> ProductVerticalItemBuilder()
            //   )
            // )
          ],
        ));
  }
}

class ProductHorizontalItem extends StatelessWidget {
  const ProductHorizontalItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://septemberfarmcheese.b-cdn.net/wp-content/uploads/Blogs/Homemade-Pizza/homemade-pizza-monterey-jack-cheese.jpg'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text('Product Name'),
              SizedBox(
                width: 5,
              ),
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
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://septemberfarmcheese.b-cdn.net/wp-content/uploads/Blogs/Homemade-Pizza/homemade-pizza-monterey-jack-cheese.jpg'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      'Product Name',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                    )),
                    Text(
                      '50\$',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
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
      children: [
        for (int i = 0; i < 3; i++)
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
                    ))
                // shape: BoxShape.circle
                ),
          ),
      ],
    );
  }
}
