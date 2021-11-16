
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'products.dart';

void main() => runApp(const HomeScreen());

// ignore: constant_identifier_names

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
    Widget build(BuildContext context){
    return  MaterialApp(
      routes: {
          '/products' :(context) => ProductScreen(),
      },
      title: 'Boose Me',
      home:   Scaffold(
        body:
        SafeArea(child: Center(
        child: HomeScreenWidget(),
      ),

    ),
    ),
    );
  }

}

  class HomeScreenWidget extends StatelessWidget{

  const HomeScreenWidget({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context)
  {

   return Scaffold(
       resizeToAvoidBottomInset: false,
     drawer: Drawer(

       child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(16.0),
            child:  Text(
              'Header',

            ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading :   Icon(Icons.home),
              title   :   Text('Home'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.shop),
              title   :   Text('Products'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.shopping_bag),
              title   :   Text('Order history'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.category),
              title   :   Text('Browse Categories'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.favorite_sharp),
              title   :   Text('Favorites'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.local_drink),
              title   :   Text('Cocktail ideas'),
              //onTap   : (goTo(0)),
            ),
            ListTile(
              leading :   Icon(Icons.settings),
              title   :   Text('Settings'),
              //onTap   : (goTo(0)),
            )
            ]
            ),
           ),

     appBar: AppBar(

       title: const Text('Boose Me!', style: TextStyle(color: Colors.deepOrange)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepOrange),
       actions: <Widget>[

         IconButton(onPressed: (){
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('This is a snackbar')));
          },icon: const Icon(Icons.shopping_cart),color: Colors.deepOrange,)
       ],
     ),

     body:  Center(
       child: Column(
       children:<Widget> [
          _buildSearch(),
         Categories()
         ]
     ),
     )


   );
  }
  }

  @override
  Widget _buildSearch()
  {
    return Column(
      children: <Widget>[

        Container(
         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
               border: OutlineInputBorder(),
                  hintText: 'Thirsty! Look for a boose here',
                  contentPadding: EdgeInsets.only(left: 100.0),
                  //suffix :  IconButton(icon:Icon(Icons.search),onPressed: () {},)

            ),

          ),
        ),

      ],
    );
    }
  @override
 class Categories extends StatelessWidget {
    const Categories({Key? key}) : super(key: key);
    Widget build(BuildContext context) {
      final shopBy = [
        "Our special",
        "Name it! We have it",
        "Get it delivered",
        "Boose of the month"];


      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('What are you digging?'),
            Container(
                child:
                GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children:
                    List<Widget>.generate(shopBy.length, (index) =>

                    GestureDetector(
                      onTap: () {_showlist(context,index);},
                        child:
                          Stack(
                            children:<Widget> [

                            Container(
                              alignment: Alignment.bottomCenter,
                              child:Card(
                                 color  : Colors.deepOrange,
                                 child:
                                 SizedBox(
                                  width   : 250,
                                  height  : 300,
                                  child:
                                  Align(
                                      alignment: Alignment.center,
                                      child:Text(shopBy[index])
                                )
                                ),

                            )
                            )
                          ],)



                    )
                    )

              )
            )
          ]);
    }
  }

void _showlist (BuildContext context, index)
{
  print(index);
  showCupertinoModalPopup<void>(context: context,
          builder: (BuildContext context) =>
          (
              CupertinoActionSheet(
                  //title: Text("Category"),
                  message: Text("Shop by Category",

                  ),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pushNamed(context, '/products');
                        
                      },
                      child: Text("Whisky"),

                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {},
                      child: Text("Beer"),

                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {},
                      child: Text("Cider"),

                    )
                  ]
              )
          ));
    }