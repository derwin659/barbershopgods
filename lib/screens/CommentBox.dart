import 'package:barberia/cloud_firestore/all_salon_ref.dart';
import 'package:barberia/model/barber_model.dart';
import 'package:barberia/model/comment_model.dart';
import 'package:barberia/screens/SelectBarberForComment.dart';
import 'package:barberia/state/state_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class TestMe extends StatefulWidget {

  final String name;
  final String foto;
  final String docId;
  final int like;
  final String descripcion;
  final String usuario;
  final String cityName;
  final String salonId;

  TestMe({required this.cityName,required this.salonId,required this.usuario,required this.name, required this.foto, required this.docId, required this.like, required this.descripcion});

  @override
  _TestMeState createState() => _TestMeState(cityName: cityName,salonId: salonId,usuario: usuario,nombre: name,foto1: foto,doc: docId,like1: like,descripcion1: descripcion);
}

class _TestMeState extends State<TestMe> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final String nombre;
  final String foto1;
  final String doc;
  final String descripcion1;
  final int like1;
  final String usuario;
  final String cityName;
  final String salonId;
  double rating = 0;
  List<CommentModel> comment2 =[];

  _TestMeState(
      {required this.cityName,required this.salonId,required this.usuario, required this.nombre, required this.doc, required this.foto1, required this.descripcion1, required this.like1});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("Comentario para ${nombre}"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "${FirebaseAuth.instance.currentUser!.photoURL == null
                  ? "https://thumbs.dreamstime.com/b/vector-el-icono-del-avatar-del-usuario-para-el-sitio-web-o-el-m%C3%B3vil-45836554.jpg"
                  : FirebaseAuth.instance.currentUser!.photoURL.toString()}"),
          child: FutureBuilder(
            future: getComment(salonId, cityName, doc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else{
                var comment = snapshot.data as List<CommentModel>;
                this.comment2 = comment;
                if (comment.length == 0){
                  return Container();
                }else{

                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: comment.length,
                        itemBuilder: (context,index){
                          return
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                              child: ListTile(
                                autofocus: true,
                                leading: GestureDetector(
                                  onTap: () async {
                                    // Display the image in large form.
                                    print("Dar click para comentar");
                                  },
                                  child: Container(

                                    decoration: new BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: new BorderRadius.all(Radius.circular(50))),
                                    child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: CommentBox.commentImageParser(
                                            imageURLorPath: comment[index].pic)),
                                  ),
                                ),
                                title: Text(
                                  comment[index].name,
                                  style: GoogleFonts.courgette(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                subtitle: Text(comment[index].message,style: GoogleFonts.courgette(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight:
                                    FontWeight.normal),),
                                trailing: Column(
                                  children: [
                                    SizedBox(
                                       height: 15,
                                    ),
                                    Text(comment[index].date, style: GoogleFonts.courgette(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight:
                                        FontWeight.normal)),
                                    RatingBar.builder(
                                        initialRating: comment[index].rating.toDouble(),
                                        minRating: 1,
                                        itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.amber),

                                        onRatingUpdate: (rating){

                                        },
                                        updateOnDrag: true,
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4))
                                  ],
                                )


                              ),
                            );


                        }),
                  );

                }
              }
            },

          ),
          labelText: 'Escribe tu comentario aqui...',
          errorText: 'No puedes dejar comentario en blanco',
          withBorder: false,
          sendButtonMethod: () {

            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                save(FirebaseAuth.instance.currentUser!.photoURL == null
                    ? usuario
                    : FirebaseAuth.instance.currentUser!.displayName.toString(),FirebaseAuth.instance.currentUser!.photoURL == null
                    ? "https://thumbs.dreamstime.com/b/vector-el-icono-del-avatar-del-usuario-para-el-sitio-web-o-el-m%C3%B3vil-45836554.jpg"
                    : FirebaseAuth.instance.currentUser!.photoURL.toString(),commentController.text.toString(),DateTime.now().toString().substring(0,16),0);
                print(commentController.text);

              });

              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("no validado");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }



  void save(String name, String pic, String message, String dateTime, int rating) {

    showDialog(context: context, builder: (context)=>

        AlertDialog(
          backgroundColor: Colors.blue[100],
          title: Text('Con cuanto calificas la atención de ${nombre}?',style:  GoogleFonts.courgette(
              color: Colors.black,
              fontSize: 20,
              fontWeight:
              FontWeight.bold),) ,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("${foto1}"),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                child:   RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    itemBuilder: (context,_)=>Icon(Icons.star,color:Colors.amber),

                    onRatingUpdate: (rating){

                      this.rating =rating;

                    },
                    updateOnDrag: true,
                    itemSize: 35,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4)),
              )
            ,


            ],

          ),actions: [
          ElevatedButton(onPressed: (){

      setState(() {

        CommentModel commentModel = CommentModel(name: name,
            pic:  pic, message:  message,
            date:  dateTime, rating: this.rating.toInt() );

        var batch = FirebaseFirestore.instance.batch();

        DocumentReference comment = FirebaseFirestore.instance
            .collection('AllBarbershop')
            .doc('Cusco')
            .collection('Branch')
            .doc('0ODa6FGIz8zCbVzM2Dwz')
            .collection('Barber')
            .doc(doc).collection('comentarios').doc('0ODa6FGIz8zCbVzM2Dwz${DateTime.now()}');

        batch.set(comment, commentModel.toJson());
        batch.commit();

        print('comentario');
        print(comment2.length);
        print(comment2.map((e) => e.rating).toList());

        var list = comment2.where((element) => element.rating>0).map((e) => e.rating).toList();

        var suma=0;

        for (int i = 0; i < list.length; i++) {

          suma = suma + list.elementAt(i).toInt();

        }
       var numerador = suma +this.rating;
       var promedio = numerador/(list.length+1);


        var batch1 = FirebaseFirestore.instance.batch();

        var barberModelRarint = BarbeModelUpdateRating(rating: promedio.round());
        var barberRef = FirebaseFirestore.instance
            .collection('AllBarbershop')
            .doc(cityName)
            .collection('Branch')
            .doc(salonId)
            .collection('Barber')
            .doc(this.doc);
        print(barberRef.toString());

        batch1.update(barberRef, barberModelRarint.toJson());
        batch1.commit();


        commentController.clear();
        FocusScope.of(context).unfocus();

        Navigator.pop(context);

        showDialog(context: context, builder: (context)=>

            AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Gracias por tu comentario y calificación ${FirebaseAuth.instance.currentUser!.photoURL == null
                  ? usuario
                  : FirebaseAuth.instance.currentUser!.displayName.toString()}',style:  GoogleFonts.courgette(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold),) ,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                ],

              ),actions: [
              ElevatedButton(onPressed: (){
                Navigator.pop(context);

              }, child: Container
                (
                alignment: Alignment.center,
                child: Text('Aceptar'),
              )),
            ],
            ));


      });


          }, child: Container
            (
            alignment: Alignment.center,
            child: Text('Calificar',style:  GoogleFonts.courgette(
                color: Colors.white,
                fontSize: 20,
                fontWeight:
                FontWeight.bold)),
          )),
        ],
        ));



  }
}