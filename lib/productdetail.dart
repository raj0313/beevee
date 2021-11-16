
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'countermodel.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class ProductDetailScreen extends StatelessWidget{
  @override

  Widget build(BuildContext context)
  {
    return  MaterialApp(

      title: "Product #1",

      home:Scaffold(
        appBar: AppBar( title: const Text('Product #1', style: TextStyle(color: Colors.deepOrange)),
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
            ChangeNotifierProvider<CounterModel>(
              create: (_) => new CounterModel(),
             child:
             SafeArea(child: Center(
            child: _ProductsDetailScreenState()
        ),

        )
        ),
      ),
    );
  }

}



class _ProductsDetailScreenState extends StatelessWidget
{
  //final _qtymodel = CounterModel();

  Future<List> fetchProduct() async{
    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/random.php'));
    final product = json.decode(response.body);
    List  prod = product['drinks'];
    List<Prod> prods = [];
    print(response);
    for(var p in prod){

      Prod product = Prod(idDrink: p["idDrink"],strDrink: p['strDrink'],strDrinkThumb: p['strDrinkThumb'] );
      prods.add(product);


    }
    return prods;

  }
  @override
  Widget build(BuildContext context)
  {
    return
      Container(
          child:FutureBuilder(
              future  : fetchProduct(),
              builder: (BuildContext context, AsyncSnapshot snapshot){

                if(snapshot.data == null)
                {
                  return Container(

                      child:Text("Loading...")
                  );
                }else {
                  return
                Column(
                    children: List<Widget>.generate(snapshot.data.length,(int index) {
                      return (
                            Consumer<CounterModel>(
                            builder: (context, _qtymodel, child) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.network(
                                    snapshot.data[index].strDrinkThumb,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    snapshot.data[index].strDrink.toUpperCase(),
                                    style: TextStyle(color: Colors.black,
                                      fontFamily: "Verdana",
                                      fontSize: 20,
                                    ),

                                  ),
                                  Text('49.00',
                                    style: TextStyle(color: Colors.deepOrange,
                                      fontFamily: "Verdana",
                                      fontSize: 20,
                                    ),

                                  ),

                                  Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[


                                        Expanded(
                                            flex: 2,
                                            child: ElevatedButton(
                                              onPressed:()=> _qtymodel.decreaseQty(),
                                              child: Text('-'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.deepOrange,
                                              ),)

                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: Text('${_qtymodel.getQty}')),
                                        ),

                                        Expanded(
                                            flex: 2,

                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  _qtymodel.incrementQty(), // ,
                                              child: Text('+'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.deepOrange,
                                              ),)

                                        ),
                                      ]
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: <Widget>[
                                        ElevatedButton.icon(
                                          icon: Icon(
                                              Icons.shopping_basket_rounded),
                                          onPressed: () {
                                            cartObject(_qtymodel.getQty,
                                                snapshot.data[index].strDrink.toUpperCase(),49);

                                          },
                                          label: Text('Add to trolley'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.deepOrange,
                                          ),
                                        )
                                      ]
                                  )

                                ],

                              ),
                              )
                            );
                        }
                        )
                    );


                }}

          )

      );

  }
}

List<Cart> cartObject(qty,name,price){

  List cart = [];
  List<Cart> cartobj = [];
  for(var c in cart){
    // ignore: unused_local_variable
    Cart carts = Cart(qty: c[qty],product_name: c[name],price: c[price]);
    cartobj.add(carts);

  }

  return cartobj;
}

class Prod {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;


  Prod({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,

  });

}


