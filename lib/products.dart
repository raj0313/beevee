

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'productdetail.dart';


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/productdetail' :(context) => ProductDetailScreen(),
      },
      title: 'Boose Me',
      home: Scaffold(
        appBar: AppBar( title: const Text('Whisky', style: TextStyle(color: Colors.deepOrange)),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.deepOrange),
            actions: <Widget>[

              IconButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },icon: const Icon(Icons.shopping_cart),color: Colors.deepOrange,)
            ],
            leading: BackButton(color: Colors.deepOrange,
            onPressed: () => Navigator.of(context).pop())
            ),

        body:
        SafeArea(child: Center(
            child: ProductDetails()
        ),

        ),
      ),
    );
  }

}
class ProductDetails extends StatefulWidget{
  const ProductDetails({Key? key}) : super(key: key);
@override
  _ProductDetailState  createState() => _ProductDetailState();
}
class _ProductDetailState extends State<ProductDetails>
{



Future<List> fetchProducts() async{
  final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail#'));
  final productsJson = json.decode(response.body);
  List drinks = productsJson['drinks'];
  List<Product> products = [];

  for(var p in drinks){

  Product product = Product(idDrink: p["idDrink"],strDrink: p['strDrink'], strDrinkThumb: p["strDrinkThumb"] );
  products.add(product);


  }
  return products;


}


  @override
  Widget build(BuildContext context)
  {
    return
    Container(
      child:FutureBuilder(
          future  : fetchProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data == null)
              {
                return Container(

                  child:Text("Loading...")
                );
              }else {
              return
                GridView.count(
                  crossAxisCount: 2,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,

                    children: List<Widget>.generate(snapshot.data.length,(int index) {
                    return (

                        SizedBox(
                           child:
                           GestureDetector(
                               onTap: ()=>{_showIndex(context,index)},

                            child :Stack(
                              children :<Widget>[

                              Container(
                                padding: const EdgeInsets.all(2),
                                  child:  Image.network(snapshot.data[index].strDrinkThumb,
                                  width: 250,
                                  height: 200,
                                  ),
                                ),
                                //),
                              Container(
                              padding: const EdgeInsets.all(4),
                              alignment:  Alignment.bottomLeft,
                              decoration: BoxDecoration(
                              gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                              Colors.deepOrange.withAlpha(0),
                              Colors.white30,
                              Colors.black
                               ],
                              ),
                              ),
                              child: Text(snapshot.data[index].strDrink,
                                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "verdana"))
                              ),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    alignment:  Alignment.bottomRight,
                                  child: Text('0.0',
                                      style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "verdana"))
                                )
                            ],
                         )
                           )
                        //(snapshot.data[index]['strDrink'])
                    ));
                  }
                )
                );


            }}

      )

      );

  }
}
class Product {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;


  Product({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,

  });

// factory Product.fromJson(Map<String, dynamic> json)
// {
//   return Product(strDrink: json['strDrink'], strDrinkThumb: json['strDrinkThumb'],idDrink: json['idDrink']);
// }

}
void _showIndex(BuildContext context, index){
  Navigator.pushNamed(context, '/productdetail');


}