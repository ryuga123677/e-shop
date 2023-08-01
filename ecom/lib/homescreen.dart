import 'dart:convert';

import 'package:ecom/models/fetchproducts.dart';
import 'package:ecom/remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}


class _homescreenState extends State<homescreen>
{var x=true;
firebaseremote remote =firebaseremote();
String temp='';
void initState()
   {super.initState();
     check();

}
void check()
async{
  x=await firebaseremote().initializeconfig();

}



  Future<Fetchproducts> getapi()async
  {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    var data =jsonDecode(response.body.toString());
    if(response.statusCode == 200)
    {
    return Fetchproducts.fromJson(data);
    }
    else
    {
      return Fetchproducts.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('e-Shop',style: TextStyle(color: Colors.white),),
         backgroundColor: Color(0xff0C54BE),
       ),
       backgroundColor: Color(0xffF5F9FD),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Fetchproducts>(
                future: getapi(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else

                      {
                    return GridView.builder(

                        itemCount: snapshot.data!.products!.length,
                        scrollDirection: Axis.vertical,
                        //shrinkWrap: true,


                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          childAspectRatio: .7
                        ), itemBuilder: (context, index) {
                         final dis_per= snapshot.data!.products![index].discountPercentage;
                         final org_pri= snapshot.data!.products![index].price;
                       final st=(org_pri!-(org_pri!*dis_per!)/100).toInt();


                       temp =st.toString();



                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(


                            child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection:  Axis.horizontal,
                                        itemCount: snapshot.data!.products![index]
                                            .images!.length,
                                        itemBuilder: (context, position) {
                                          return  Container(
                                              height: MediaQuery.of(context).size.height*.2,
                                              width: MediaQuery.of(context).size.height*.21,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data!
                                                              .products![index]
                                                              .images![position]
                                                              .toString()),
                                                      fit: BoxFit.fill
                                                  )
                                              ),


                                          );
                                        }),
                                  ),

                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.products![index].title
                                            .toString(),
                                          style: TextStyle(fontFamily: 'Bold'),),
                                        Text(snapshot.data!.products![index]
                                            .description.toString(),style: TextStyle(fontFamily: 'Regular'),),


                                      ],
                                    ),
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      x! ?  Text('\$'+snapshot.data!.products![index].price.toString(),style: TextStyle(decoration: TextDecoration.lineThrough,color: Color(0xffCED3DC),fontSize: 12),) : Text('\$'+snapshot.data!.products![index]
                                          .price.toString(),style: TextStyle(fontFamily: 'Italic',fontSize: 12),),
                                      x!? Text("\$"+temp.toString(),style: TextStyle(color: Color(0xff303F60),fontFamily: 'Italic',fontSize: 12),):Text('') ,
                                      x!?Text(snapshot.data!.products![index]
                                          .discountPercentage.toString()+'off',style: TextStyle(fontFamily: 'Italic', color: Colors.greenAccent,fontSize: 12),):Text('')
                                   //here above if x=true then it will show original price+ discount price + discount percentage

                                    ],
                                  )
                                  
                                ])
                        ),
                      );
                    }
                    );
                  }
                }
     ))],
                           ),











    );
  }

}
