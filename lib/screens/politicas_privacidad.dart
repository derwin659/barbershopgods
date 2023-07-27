
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PoliticalPrivacity extends StatefulWidget {
  const PoliticalPrivacity({Key? key}) : super(key: key);

  @override
  State<PoliticalPrivacity> createState() => _PoliticalPrivacityState();
}

class _PoliticalPrivacityState extends State<PoliticalPrivacity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Politicas y Privacidad"),
        ),
        body:  Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.white,
            margin: EdgeInsets.all(15),
            child:SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(

                        color: Colors.white12,
                        child: Image.asset('assets/images/logog.png', fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 220),
                      ),
                      SizedBox(height: 15,),
                      Text("POLITICAS Y PRIVACIDAD", style: TextStyle(

                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.justify,),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"   De conformidad con lo establecido en la Ley N° 29733, Ley de Protección de Datos Personales y el Decreto Supremo N° 003-2013-JUS, Reglamento de la Ley de Protección de Datos Personales, Barbershop gods I.R.L con Registro Único de Contribuyentes (“RUC”) N° 15608399744, con domicilio en Cusco Av los inkas 805A,Cusco Perú (en adelante, “Barbershop Gods”) le informa mediante esta Política de Privacidad (en adelante, la “Política”), las condiciones del tratamiento de su información.",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight
                                  .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   Como parte normal de nuestras actividades, recopilamos información sobre nuestros Usuarios, que acceden y utilizan nuestras aplicación movil Barbershop gods.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify," El Titular consiente de manera libre, expresa, previa e informada que BARBERSHOP GODS trate los datos personales que usted nos proporcione mediante los formularios electrónicos que se le proponga y los almacene en un banco de datos de su titularidad para los fines establecidos en esta Política."
                          , style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight
                                  .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"  Se informa que la información del Usuario se almacenará en uno de los siguientes bancos de datos personales, por el plazo señalado, según corresponda:", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"1) Si usted se registra como Usuario en nuestras Aplicaciones móviles.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Nombre de banco de datos personales: Banco de datos de usuarios", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Plazo de almacenamiento: Durante el plazo que dure la relación contractual entre BARBERSHOP GODS y usted más 10 años.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"2) Si usted se registra como Usuario y Barbershop gods, reconoce que eres un barbero.Si usted se registra como Usuario en nuestras Aplicaciones móviles.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Nombre de banco de datos personales: Banco de datos de barberos", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Plazo de almacenamiento:  Durante la relación entre el barbero y Barbershop gods.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text("PRIMERA: Derechos de acceso, cancelación y rectificación de la Información Personal", style: TextStyle(

                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"1.1. El Usuario puede ejercer los derechos de acceso, rectificación, cancelación u oposición, establecidos en la normativa de protección de datos personales.De considerar el Titular que no ha sido atendido en el ejercicio de sus derechos, puede presentar un reclamo ante la Dirección de Protección de Datos Personales del Ministerio de Justicia y Derechos Humanos.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"1.2 En caso que el Usuario se registre como Usuario , podrá revisar y cambiar la información que ha enviado a Barbershop gods, por motivos debidamente justificados y legítimos, incluyendo: el correo y la constraseña del usuario, asi como su direccion", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"1.3. BARBERSHOP GODS podrá modificar esta Política. En dicho caso, BARBERSHOP GODS notificará al Usuario publicando una versión actualizada de la Política en esta página y mediante el envío de un e-mail o informándolo en notificaciones push de nuestra  aplicacion, a efectos de mantener actualizado al Usuario. El Usuario acepta que, si después de dicha notificación, mantiene su registro en la Aplicación, es porque está de acuerdo con las mismas. Si no está de acuerdo, el Usuario deberá solicitar darse de baja a BARBERSHOP GODS, en cuyo caso, BARBERSHOP GODS no tratará más su información, sino únicamente para el cumplimiento de la ley aplicable.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text("SEGUNDA: La Información Personal que recopilamos", style: TextStyle(

                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"2.1. A fin de acceder como Usuario  a la aplicación Barbershop gods, los mismos deben registrarse o loguearse con su cuenta de gmail o google. BARBERSHOP GODS podrá solicitar, recabar y almacenar la siguiente información personal: apodo o seudónimo (nombre de Titular de los datos) para operar en el sitio de BARBERSHOP GODS, nombre y apellido, número de documento o identificación válida, información física de contacto (como número de teléfono, domicilio, tipo de domicilio, dirección de e-mail, etc.), historial de compras, preferencias de consumo.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"2.2. Al fin de acceder como Usuario o Barbero, el mismo deben registrarse, suministrando ciertos datos personales completos y exactos o logueandose con su cuenta ed google. BARBERSHOP GODS  podrá solicitar, recabar y almacenar la siguiente información personal: apodo o seudónimo (nombre de Titular de los datos) para operar en el sitio de BARBERSHOP GODS, nombre y apellido, género, número de documento o identificación válida, fecha de nacimiento, medio de transporte, información física de contacto (como número de teléfono domicilio, imagen de perfil, dirección de e-mail, etc.).", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   BARBERSHOP GODS podrá confirmar la Información Personal suministrada acudiendo a fuentes de acceso público, tales como entidades públicas, compañías especializadas o centrales de riesgo. Esta verificación es necesaria para mejorar los servicios a través de nuestras Aplicación movil.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text("TERCERA: Finalidad y Uso de la Información Personal", style: TextStyle(

                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"3.1. Su información será tratada de acuerdo a las siguientes finalidades y usos, según corresponda:", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Si usted es un Usuario: ", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   La Información Personal será tratada para ejecutar la relación contractual entre BARBERSHOP GODS  y sus respectivos barberos y para brindar los servicios a los Usuarios a través de las Aplicaciones , de acuerdo a sus términos y condiciones.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"Su información también podrá ser utilizada, de manera anonimizada, para realizar estudios internos sobre los intereses, comportamientos y demografía del Titular para comprender mejor sus necesidades e intereses y ofrecer mejores servicios o proveerles información relacionada.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"CONSENTIMIENTOS CON FINES OFERTA", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   Solo y exclusivamente en el caso que usted haya aceptado expresa y voluntariamente, mediante la aplicación, recibir información sobre novedades, descuentos y recomendaciones sobre los productos y servicios de  Barbershop gods, usted autoriza que BARBERSHOP GODS pueda enviar información a través de diferentes medios, tales como  mensajes al Titular por e-mail, sms (mensaje de texto) y/o a cualquier otro tipo de dispositivos móviles o a través de plataformas de mensajería instantánea (incluyendo Whatsapp), sobre publicidad o promociones, banners, de interés para el Titular, noticias sobre BARBERSHOP GODS.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   Sin perjuicio de ello, el Usuario puede en cualquier momento solicitar que lo excluyan de las listas para el envío de información promocional o publicitaria, mediante la sección de Soporte disponible a través de la plataforma o ejerciendo sus derechos ARCO.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"   Asimismo, si el Usuario decide no aceptar recibir estas comunicaciones, al momento de registrarse, desmarcando la casilla correspondiente, puede otorgar su autorización en cualquier momento posteriormente, a través de los centros de soporte correspondientes.Sin perjuicio de ello, el Titular puede en cualquier momento solicitar que lo excluyan de las listas para el envío de información promocional o publicitaria, mediante la sección de Soporte disponible a través de la plataforma o ejerciendo sus derechos ARCO.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text("CUARTA:Confidencialidad de la Información Personal", style: TextStyle(

                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 15,),
                      Text(textAlign: TextAlign.justify,"4.1. Barbershop gods no venderá, intercambiará, alquilará o compartirá la Información Personal del Titular excepto en las formas establecidas en esta Política.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text("QUINTA:Clave Personal", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"5.1. Para acceder a los servicios reservados, el Usuario dispondrá de una clave personal. Con ella podrá contratar y calificar los servicios que prestan por terceros a través de la aplicación movil. El Usuario deberá mantener esta clave bajo absoluta confidencialidad y, en ningún caso, deberá revelarla o compartirla con otras personas.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"5.2. El Usuario será responsable de todos los actos que tengan lugar mediante el uso de su nombre de Usuario y clave, lo que incluye asumir la responsabilidad por los daños que puedan sufrir otros Titulares mediante su cuenta. Si, por cualquier razón, un Titular creyera que alguien puede conocer su clave, deberá modificarla ingresando a la opción de modificación dispuesta para tal fin en la plataforma de Barbershop gods.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text("SEXTA:Menores de Edad", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"6.1. Debes tener más de 14 años para registrarte en la APP o el Sitio como usuario.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"6.2 BARBERSHOP GODS se reserva el derecho de verificar, por los medios legales que considere más oportunos y relevantes, la edad real de cualquier Usuario de los datos.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"6.3 Ante una sospecha razonable de que un Usuario de los datos de la Aplicación se ha registrado incumpliendo los límites mínimos de edad o que ha falseado los datos que se requieren para su acceso, Barbershop gods podrá denegar el acceso a sus servicios.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"6.4.  En ningún caso, Barbershop gods solicitará el consentimiento de menores para el tratamiento de datos personales para el acceso a actividades, vinculadas con bienes o servicios que están restringidos para mayores de edad.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text("SÉPTIMA: Requerimientos Legales", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.left,),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.justify,"7.1. BARBERSHOP GODS cooperará con las autoridades competentes y con otros terceros para garantizar el cumplimiento de las leyes. Barbershop gods podrá revelar la Información Personal del Titular sin su consentimiento únicamente cuando esté permitido por ley, requerido por mandato judicial, o en casos de prevención de lavado de activos o financiamiento del terrorismo o el caso que dicho Titular participa de actividades ilegales. En tales situaciones, BARBERSHOP GODS colaborará con las autoridades competentes con el fin de salvaguardar la integridad y la seguridad de la comunidad y la de sus Titulares de los datos.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                      SizedBox(height: 10,),
                      Text("OCTAVA: Seguridad y Almacenamiento de la Información Personal", style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .bold) ,textAlign: TextAlign.justify,),
                      SizedBox(height: 10,),
                      Text(textAlign: TextAlign.left,"8.1. En el tratamiento de la Información Personal, BARBERSHOP GODS garantiza que ha adoptado medidas técnicas para garantizar la seguridad de sus datos personales. Sin perjuicio de lo expuesto, considerando que internet es un sistema abierto, de acceso público, Barbershop gods no puede garantizar que terceros no autorizados no puedan eventualmente superar las medidas de seguridad y utilizar la Información Personal en forma indebida, por tratarse de eventos imprevisibles.", style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight
                              .normal) ),
                    ],
                  )
              ),
            )
        )
    );
  }
}
