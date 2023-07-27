
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermAnNotifications extends StatefulWidget {
  const TermAnNotifications({Key? key}) : super(key: key);

  @override
  State<TermAnNotifications> createState() => _TermAnNotificationsState();
}

class _TermAnNotificationsState extends State<TermAnNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Terminos y Condiciones"),
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
                    Text("ASPECTOS GENERALES", style: TextStyle(

                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ,textAlign: TextAlign.justify,),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   Barbershop Gods I.R.L fue constituida conforme a las leyes de la República del Perú, identificada con RUC N° 15608399744, con domicilio en Cusco Avenida los inkas 805A, distrito de wanchaq, provincia y departamento del cusco, que para los efectos de los presentes Términos & Condiciones de uso de la Plataforma Barbershop Gods denominada “Barbershop gods”.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight
                                .normal) ),
                    SizedBox(height: 15,),
                    Text("DEFINICIONES", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),

                    Text(textAlign: TextAlign.justify,"Barberos: persona natural , que tiene un conjunto de horario definido , para poder ejecutar los servicios necesarios por cada usuario de la Plataforma.", style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight
                                .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"Ubicacion: significan el intangible de dar la ubicaciones exacta de nuestras sedes de la  barberia Barbershop gods."
                        , style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight
                                .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"Datos Personales: es toda información que permite identificar o hacer identificable a una persona natural", style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight
                                .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"Plataforma Barbershop gods: plataforma virtual compuesta por una aplicación para dispositivos móviles por medio de la cual los Aliados Comerciales pueden realizar una reserva de corte en cualquier horario 24/7", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"Categorias: Sección importante donde podrán observar todos los tipos de cortes y servicios que ofrecemos asociado a la sucursal de Barbershop Gods", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"Usuario: persona natural que, como destinatario final, utiliza la Plataforma Barbershop gods para adquirir las reservas de  servicios exhibidos, ofrecidos por las sedes de Barbershop Gods", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"FUNCIONAMIENTO DE LA PLATAFORMA", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   La Plataforma BARBERSHOP GODS es una herramienta tecnológica que, haciendo uso del internet, facilita la intermediación entre el usuario y los barberos de cada sucursal de barbershop gods. Los Usuarios finales pueden elegir la el salón,  barbero y horario de su preferencia para realizar la reserva del servicio que requiera. Barbershop Gods actúa en todo momento como tercero intermediario entre Barberos de barbershop gods y Usuarios finales", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Asimismo, los Usuarios aceptan y entienden que barbershop gods no define servicio a realizar, sino que el mismo se elige una vez estando en el establecimiento,en la fecha y hora exacta elegido en el momento de realizar la reserva.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"ACEPTACIÓN TÉRMINOS & CONDICIONES", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   El Usuario, al momento de registrarse en la Plataforma Barbershop gods, voluntariamente acepta de manera previa, expresa e informada el contenido de los presentes Términos & Condiciones en su totalidad, por lo cual, se obliga irrevocablemente a éstos. Esto quiere decir, que el Usuario declara haber leído y entendido todas las condiciones en la Política de Privacidad y en los presentes Términos & Condiciones, manifestando su conformidad y aceptación al registrarse y hacer uso de la Plataforma Barberhop GODS.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   La persona natural que acepta los presentes Términos & Condiciones declara y garantiza ser el Usuario que hará uso de la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Cualquier persona que no acepte o se encuentre en desacuerdo con estos Términos & Condiciones, los cuales tienen un carácter obligatorio y vinculante, deberá abstenerse de utilizar la Plataforma Barbershop Gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Los presentes Términos & Condiciones de Uso de la Plataforma Barbershop gods, regulan la relación contractual entre los Usuarios con barbershop gods. El servicio se encuentra dirigido exclusivamente a residentes en la zona de cobertura de barbershop gods en la República de Perú. Los Usuarios se encontrarán sujetos a los Términos & Condiciones Generales respectivos, junto con todas las demás políticas y principios que rigen Barbershop gods y que son incorporados al presente por referencia.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"OBLIGACIONES DE LOS USUARIOS", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   En virtud de la aceptación de los presentes Términos & Condiciones, el Usuario se obliga a:", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"1.-Ingresar sus Datos Personales de manera veraz al momento de registrarse en la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"2.-Abstenerse de transferir a terceros los datos de validación de su cuenta en la Plataforma Barbershop Gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"3.-Notificar a Barbershop gods respecto de cualquier uso no autorizado de su cuenta al interior de la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"4.-Abstenerse de utilizar la Plataforma Barbershop gods para realizar actos contrarios a la moral, la ley, el orden público, y las buenas costumbres en contra de Barbershop gods y sus respectivos barberos.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"5.-El Usuario reconoce que no es obligado a asistir a la reserva, y podrá eliminarla en cualquier momento que desee.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"6.-Verificar que las reservas solicitadas por medio de la Plataforma Barbershop gods correspondan a los solicitados por el Usuario.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"7.-Informarse sobre los servicios que desea realizarse al llegar al salón con la fecha y hora reservada, dentro de nuestras categorias", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"8.-Asegurarse que la hora de la fecha reservada sea el horario que tendrá disponibles para disfrutar del servicio", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"9.-El Usuario tendrá preferencia por realizar la reserva, y este deberá llegar 10 minutos antes de la reserva, reconocerá que en caso contrario  pierde la reserva pautada.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"10.-Abstenerse de realizar conductas que atenten en contra del funcionamiento de la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"11.-Abstenerse de suplantar la identidad de otros Usuarios.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"12.-Abstenerse de descifrar, descompilar o desensamblar cualquier elemento de la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"13.-Abstenerse de tener más de una (1) cuenta en la Plataforma Barbershop gods con los mismos Datos Personales. El Usuario reconoce y acepta que Barbershop gods  se reserva el derecho de desactivar las cuentas que no cumplan con estos parámetros.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"14.-Mantener custodia del dispositivo móvil o portátil por medio del cual accede a la Plataforma Barbershop gods, garantizando que terceros no tengan acceso indebido a la Plataforma Barbershop gods por acciones u omisiones del Usuario. Se aclara que, en caso de que se evidencie que el Usuario no ha custodiado en debida forma su dispositivo móvil o portátil, Barbershop gods no tendrá ningún tipo de responsabilidad por accesos no autorizados por parte de terceros a la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"15.-Reconoce que los servicios realizado en cada salón de Barbershop gods, tendrá distintos métodos de pagos, únicamente al finalizar el servicio.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"16.-Tratar de manera respetuosa a los barberos y al personal de trabajo dentro del salon de barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"17.-Los representantes legales de los Usuarios que sean menores de edad declaran expresamente que han autorizado a estos últimos su registro en la Plataforma Barbershop gods, entendiéndose que son responsables por el uso de la Plataforma Barbershop gods por parte de los Usuarios menores de edad.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"18.-Ante el incumplimiento de cualquiera de las obligaciones contenidas en la presente sección, Barbershop gods se reserva el derecho de bloquear definitivamente la cuenta del Usuario en la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"DEL REGISTRO DEL USUARIO", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   El acceso a la Plataforma Barbershop gods es gratuito, salvo en lo relativo al costo de la conexión a través de la red de telecomunicaciones suministrada por el proveedor de acceso contratado (ISP) por el Usuario, que estará a su exclusivo cargo. El Usuario únicamente podrá acceder a la Plataforma a través de los medios autorizados.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"    Para el acceso a los contenidos de la Plataforma Barbershop gods será necesario el registro del Usuario. Por ello, para acceder al Servicio de reservas prestado por los barberos, el Usuario deberá contar con un Smartphone con sistema operativo Android y completar todos los campos del formulario de inscripción correspondiente a los Usuarios con datos válidos. Los Usuarios deberán verificar que la información que ponen a disposición de Barbershop gods; es decir, sus Datos Personales, sean exactos, precisos y verdaderas. Asimismo, el Usuario asumirá el compromiso de actualizar sus Datos Personales cada vez que los mismos sufran modificaciones. Barbershop gods  podrá utilizar diversos medios para identificar a los Usuarios, pero Barbershop gods  no se responsabiliza por la certeza de los Datos Personales que los Usuarios pongan a su disposición. Los Usuarios garantizan y responden, en cualquier caso, por la veracidad, exactitud, vigencia y autenticidad de los Datos Personales puestos a disposición de Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   A los efectos de adquirir la condición de Usuario de Barbershop gods, el Usuario deberá completar el formulario de registro, brindar su consentimiento para el tratamiento de sus Datos Personales, aceptar la Política de Privacidad y Tratamiento de Datos Personales, y los presentes Términos & Condiciones.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Una vez efectuado el Registro, Barbershop gods otorgará al Usuario una cuenta personal para acceder con la contraseña que elija (en adelante, la “Cuenta”). La Cuenta es personal, única e intransferible, y está prohibido que un mismo Usuario registre o posea más de una Cuenta. En caso que Barbershop gods detecte distintas Cuentas que contengan datos coincidentes o relacionados, podrá cancelar, suspender o inhabilitarlas. El Usuario será el único responsable por el uso de su cuenta.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Los Datos Personales introducidos por el Usuario deberán ser exactos, actuales y veraces en todo momento. Barbershop gods se reserva el derecho de solicitar algún comprobante y/o dato adicional a efectos de corroborar los Datos Personales, y de suspender temporal y/o definitivamente a aquel Usuario cuyos datos no hayan podido ser confirmados. Barbershop Gods NO se responsabiliza por la certeza de los datos consignados en el Registro. El Usuario garantiza y responde, en cualquier caso, por la veracidad, exactitud, vigencia y autenticidad de sus Datos Personales. Los Datos Personales que el Usuario proporcione se integrarán en una base de datos personales de la que es responsable Barbershop gods. Para más información consultar la Política de Privacidad y Tratamiento de Datos Personales.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"USO DE LA PLATAFORMA ", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   Barbershop gods  tendrá las facultades para denegar o restringir el uso a la Plataforma Barbershop gods a cualquier Usuario en caso de incumplimiento de los presentes Términos & Condiciones, sin que ello genere perjuicio alguno al Usuario. Barbershop gods no será responsable si el Usuario no cuenta con un teléfono celular compatible con el uso del aplicativo que contiene la Plataforma Barbershop gods. El Usuario se compromete a hacer un uso adecuado y lícito de la Plataforma Barbershop gods  de conformidad con la legislación aplicable, los presentes Términos & Condiciones, la moral y buenas costumbres generalmente aceptadas y el orden público. Además de las obligaciones de los Usuarios, detalladas en los presentes Términos & Condiciones, al utilizar la Plataforma Barbershop gods, el Usuario acuerda que:", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"1.-Solo utilizará el Servicio para su uso personal y no tendrá facultades para revender su Cuenta a un tercero.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"2.-No autorizará a terceros a usar su Cuenta.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"2.-No cederá ni transferirá de otro modo su Cuenta a ninguna otra persona o entidad legal.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"3.-No utilizará una cuenta que esté sujeta a cualquier derecho de una persona que no sea ella sin la autorización adecuada.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"4.-No solicitará el Servicio con fines ilícitos, ilegales, contrarios a lo establecido en los presentes Términos & Condiciones, a la buena fe y al orden público, lesivos de los derechos e intereses de terceros incluyendo, sin limitación, el transporte de material ilegal o con fines fraudulentos.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"5.-No tratará de dañar el Servicio o la Plataforma Barbershop gods de ningún modo, ni accederá a recursos restringidos en la misma.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"6.-Guardará de forma segura y confidencial la contraseña de su Cuenta y cualquier identificación facilitada para permitirle acceder al Servicio y la Plataforma Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"7.-No utilizará el Servicio o la Plataforma Barbershop gods con un dispositivo incompatible o no autorizado.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"8.-No intentará acceder, utilizar y/o manipular los datos de Barbershop gods y de sus respectivos barberos.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"9.-No introducirá ni difundirá virus informáticos o cualesquiera otros sistemas físicos o lógicos que sean susceptibles de provocar daños en la Plataforma Barbershop.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"USO Y GARANTÍA DE LA PLATAFORMA", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   Barbershop Gods informa a sus Usuarios que la Plataforma  podría presentar limitaciones de disponibilidad y continuidad en su funcionamiento, por razones de mantenimiento o acciones que escapen al control y manejo de Barbershop gods. En estos casos, Barbershop gods hará todo lo que se encuentre razonablemente a su alcance para retomar el adecuado funcionamiento de la Plataforma. Sin embargo, hace de conocimiento de los Usuarios para que tomen las precauciones correspondientes, siendo que Barbershop gods no será responsable por eventuales daños y/o perjuicios que puedan derivarse de: (i) la falta de disponibilidad o accesibilidad a la Plataforma Barbershop gods por las razones antes expuestas; (ii) la interrupción en el funcionamiento de la Plataforma  o fallos informáticos ajenos al control de barbershop gods, averías telefónicas, desconexiones, retrasos o bloqueos causados por deficiencias o sobrecargas en las líneas telefónicas, centros de datos, en el sistema de Internet o en otros sistemas electrónicos, producidos en el curso de su funcionamiento; y, (iii) otros daños que puedan ser causados por terceros mediante intromisiones no autorizadas ajenas al control de Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Barbershop gods adopta las medidas de seguridad necesarias y razonables para el funcionamiento de la Plataforma . Sin embargo, estas medidas no necesariamente aseguran la ausencia de virus ni de otros elementos en la Plataforma Barbershop gods, introducidos por terceros, ajenos al control de barbershop gods, que puedan producir alteraciones en los sistemas físicos o lógicos del Usuario en los documentos electrónicos y ficheros almacenados en sus sistemas. En consecuencia, Barbershop gods no será responsable de los daños y perjuicios que pudieran derivarse de la presencia de virus u otros elementos, ajenos al control de Rappi, que puedan producir alteraciones en los sistemas físicos o lógicos, documentos electrónicos o ficheros del Usuario.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Con la suscripción de los presentes Términos & Condiciones, el Usuario que suscribe el presente documento declara que mantendrá indemne frente a cualquier reclamación a Barbershop gods.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"PROPIEDAD INTELECTUAL", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"   El Usuario reconoce y acepta que todos los derechos de propiedad intelectual e industrial sobre los contenidos y/o cualesquiera otros elementos insertados en la Plataforma Barbershop gods (incluyendo, sin limitación, marcas, logotipos, nombres comerciales, lemas comerciales textos, imágenes, gráficos, diseños, sonidos, bases de datos, software, diagramas de flujo, presentación, audio y vídeo y/o cualquier otro derecho de propiedad intelectual e industrial de cualquier naturaleza que éstos sean), pertenecen y son de propiedad exclusiva de Barbershop gods. Por lo tanto, Barbershop gods autoriza al Usuario a utilizar, visualizar, imprimir, descargar y almacenar los contenidos y/o los elementos insertados en la Plataforma Barbershop gods exclusivamente para su uso personal, privado y no lucrativo, absteniéndose de realizar sobre los mismos cualquier acto de descompilación, ingeniería inversa, modificación, divulgación o suministro.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 15,),
                    Text(textAlign: TextAlign.justify,"PROTECCIÓN DE DATOS PERSONALES", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .bold) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Los datos personales que los Usuarios proporcionen en el Registro, serán almacenados y tratados según lo dispone la Ley N° 29733, Ley de Protección de Datos Personales, su Reglamento, aprobado mediante Decreto Supremo N° 003-2013-JUS, demás normas conexas y la Política de Privacidad de Barbershop gods y Tratamiento de Datos Personales que aceptan los Usuarios al momento del Registro.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   En ese sentido, Barbershop gods se obliga al cumplimiento estricto de las normas anteriormente mencionadas, así como a mantener los estándares máximos de seguridad, protección, resguardo, conservación y confidencialidad de la información recibida o enviada.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                    Text(textAlign: TextAlign.justify,"   Los Usuarios declaran que los datos personales han sido entregados de forma absolutamente libre y voluntaria, sin ningún tipo de presión, obligación o condición de por medio.", style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight
                            .normal) ),
                    SizedBox(height: 10,),
                  ],
                )
            ),
          )
      )
    );
  }
}
