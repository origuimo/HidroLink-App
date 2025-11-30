import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termes i Condicions"),
        backgroundColor: Color(0xFF4e73df),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: const Text(
          """
TERMES I CONDICIONS D’ÚS D'HIDTROLINK
Darrera actualització: gener 2025

1. Objecte del servei
L’aplicació permet monitoritzar, de forma remota i automàtica, la pressió d’aigua en sistemes de reg mitjançant un dispositiu IoT que recull dades i les envia a través de connexió mòbil. El servei té finalitat informativa i de suport al manteniment agrari.

2. Acceptació de les condicions
En registrar-se i utilitzar l’aplicació, l’usuari accepta íntegrament aquests Termes i Condicions. Si l’usuari no està d’acord amb algun punt, no ha d’utilitzar el servei.

3. Registre de l'usuari
Per crear un compte, l’usuari ha de facilitar nom i cognoms, correu electrònic i una contrasenya. L’usuari es compromet a proporcionar informació veraç i a mantenir-la actualitzada.

4. Dades recollides pel dispositiu IoT
El dispositiu recull dades relatives a:
- Pressió d’aigua,
- Estat del dispositiu,
- Data i hora de les mesures,
- Informació mínima de connectivitat (SIM) necessària pel funcionament.

No es recullen altres dades personals més enllà de les proporcionades voluntàriament.

5. Ús de les dades
Les dades es fan servir exclusivament per:
- Visualitzar la pressió i l’estat del sistema de reg,
- Detectar anomalies o incidències,
- Millorar la gestió hídrica per part de l’usuari.

No es venen ni transfereixen a tercers.

6. Responsabilitat de l’usuari
L’usuari és responsable de:
- La instal·lació correcta del dispositiu,
- El manteniment del sensor i la línia de reg,
- La gestió i seguretat del seu compte.

L’usuari no ha de compartir la seva contrasenya.

7. Limitació de responsabilitat
L’aplicació proporciona dades informatives. Tot i que el sistema es dissenya per ser fiable, poden existir fallades de xarxa, errors del sensor o interrupcions del servei.

No es garanteix el funcionament continuat ni s’assumeix responsabilitat per danys derivats d’interpretacions errònies o fallades externes.

8. Suspensió o baixa del servei
L’administrador pot suspendre o eliminar un compte en cas d’ús fraudulent, manipulació del dispositiu o incompliment dels Termes i Condicions.

9. Protecció de dades
Les dades personals es tracten segons la normativa vigent, incloent el RGPD i la LOPD-GDD. L’usuari pot sol·licitar l’eliminació del seu compte en qualsevol moment.

10. Modificacions
Aquests Termes poden ser actualitzats. Els canvis es mostraran a l’aplicació.

11. Contacte
Per qualsevol consulta:
guimomorell@hidrolink.es
          """,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ),
    );
  }
}
