import 'dart:convert';

import 'package:lernplatform/datenklassen/frage.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Teilnehmer> ladeOderErzeugeTeilnehmer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String teilnehmerKey = "ThorTheTrainer";

  // Lade Daten aus dem LocalStorage
  String? gespeicherterTeilnehmer = prefs.getString(teilnehmerKey);

  // Wenn Teilnehmer gefunden wurde, diesen zurückgeben
  if (gespeicherterTeilnehmer != null) {
    Map<String, dynamic> data = jsonDecode(gespeicherterTeilnehmer);
    return Teilnehmer(
      key: data['key'],
      meineLernfelder: (data['meineLernfelder'] as List)
          .map((feld) => LogLernfeld(
        feld['id'],
        (feld['meineThemen'] as List).map((thema) => LogThema(
          id: thema['id'],
          falschBeantworteteFragen: List<String>.from(thema['falschBeantworteteFragen']),
          richtigBeantworteteFragen: List<String>.from(thema['richtigBeantworteteFragen']),
        )).toList(),
      ))
          .toList(),
    );
  }
  return blanco_teilnehmer;
}

Future<void> speichereTeilnehmer(Teilnehmer teilnehmer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String teilnehmerKey = "ThorTheTrainer";

  // Teilnehmer in JSON-Format umwandeln und speichern
  prefs.setString(teilnehmerKey, jsonEncode({
    'key': teilnehmer.key,
    'meineLernfelder': teilnehmer.meineLernfelder
        .map((feld) => {
      'id': feld.id,
      'meineThemen': feld.meineThemen.map((thema) => {
        'id': thema.id,
        'falschBeantworteteFragen': thema.falschBeantworteteFragen,
        'richtigBeantworteteFragen': thema.richtigBeantworteteFragen,
      }).toList(),
    })
        .toList(),
  }));
}


Teilnehmer blanco_teilnehmer = Teilnehmer(
    key: "key",
    meineLernfelder: [
      LogLernfeld(1, blanco_logThemen_zu_Loglernfeld1),
      LogLernfeld(2, []),
      LogLernfeld(3, []),
      LogLernfeld(4, []),
      LogLernfeld(5, []),
      LogLernfeld(6, []),
    ]
);

List<LogThema> blanco_logThemen_zu_Loglernfeld1 =[
  LogThema(
      id: 1,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 2,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 3,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 4,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
];

List<Lernfeld> mok_lernfelder = [
  Lernfeld(id: 1, name: "Lernfeld 1 der Fachinformatiker", themen: []),
  Lernfeld(id: 2, name: "Lernfeld 2 der Fachinformatiker", themen: []),
  Lernfeld(id: 3, name: "FSM I", themen: []),
  Lernfeld(id: 4, name: "FSM II", themen: []),
  Lernfeld(id: 5, name: "Mobile", themen: []),
  Lernfeld(id: 6, name: "Web", themen: []),
];


List<Thema> mok_themen = [
  Thema(id: 1, name: "LF 1 T1", tags: [1], fragen: []),
  Thema(id: 2, name: "LF 1 T2", tags: [1], fragen: []),
  Thema(id: 3, name: "LF 1,2 T3", tags: [1,2], fragen: []),
  Thema(id: 4, name: "LF 1,2 T4", tags: [1,2], fragen: []),
];

List<Frage> mok_fragen_zuThema1 = [
  // Fragen für Thema 1 (LF 1 T1)
  Frage(
    nummer: 1,
    version: 1,
    themaID: 1,
    punkte: 5,
    text: "Was ist ein Betriebssystem?",
    antworten: [
      Antwort(text: "Eine Software, die Hardware verwaltet", erklaerung: "Betriebssysteme sind für die Verwaltung der Hardware zuständig.", isKorrekt: true),
      Antwort(text: "Ein Programm, das Dateien speichert", erklaerung: "Falsch, Betriebssysteme verwalten Dateien, aber das ist nicht ihre Hauptaufgabe.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 1,
    version: 2,
    themaID: 1,
    punkte: 5,
    text: "Wofür ist ein Betriebssystem zuständig?",
    antworten: [
      Antwort(text: "Für die Verwaltung von Hardware und Software", erklaerung: "Das ist korrekt.", isKorrekt: true),
      Antwort(text: "Für die Sicherheit von Anwendungen", erklaerung: "Das ist nicht die Hauptaufgabe eines Betriebssystems.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 1,
    themaID: 1,
    punkte: 5,
    text: "Welcher dieser Speicher ist flüchtig?",
    antworten: [
      Antwort(text: "RAM", erklaerung: "RAM ist flüchtiger Speicher.", isKorrekt: true),
      Antwort(text: "Festplatte", erklaerung: "Festplatten sind nicht flüchtig.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 2,
    themaID: 1,
    punkte: 5,
    text: "Welcher Speicher verliert seinen Inhalt nach einem Neustart?",
    antworten: [
      Antwort(text: "RAM", erklaerung: "Korrekt, RAM verliert seinen Inhalt.", isKorrekt: true),
      Antwort(text: "SSD", erklaerung: "SSD speichert Daten auch nach dem Ausschalten.", isKorrekt: false),
    ],
  ),
];



List<Frage> mok_fragen_zuThema2 = [
  Frage(
    nummer: 1,
    version: 1,
    themaID: 2,
    punkte: 5,
    text: "Was ist der Hauptzweck einer Firewall?",
    antworten: [
      Antwort(text: "Schutz vor unautorisierten Zugriffen", erklaerung: "Firewalls schützen Netzwerke.", isKorrekt: true),
      Antwort(text: "Daten sichern", erklaerung: "Firewalls schützen, aber sie sichern keine Daten.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 1,
    version: 2,
    themaID: 2,
    punkte: 5,
    text: "Wofür wird eine Firewall verwendet?",
    antworten: [
      Antwort(text: "Zur Sicherung des Netzwerks vor unautorisierten Zugriffen", erklaerung: "Das ist korrekt.", isKorrekt: true),
      Antwort(text: "Zum Backup von Daten", erklaerung: "Backups sind nicht die Aufgabe einer Firewall.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 1,
    themaID: 2,
    punkte: 5,
    text: "Welches Protokoll wird für E-Mail-Versand verwendet?",
    antworten: [
      Antwort(text: "SMTP", erklaerung: "SMTP ist für den E-Mail-Versand zuständig.", isKorrekt: true),
      Antwort(text: "FTP", erklaerung: "FTP wird für Dateitransfers verwendet, nicht für E-Mail.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 2,
    themaID: 2,
    punkte: 5,
    text: "Welches Protokoll ermöglicht den Versand von E-Mails?",
    antworten: [
      Antwort(text: "SMTP", erklaerung: "Richtig, SMTP wird dafür verwendet.", isKorrekt: true),
      Antwort(text: "HTTP", erklaerung: "HTTP ist für das Laden von Webseiten zuständig.", isKorrekt: false),
    ],
  ),
];



List<Frage> mok_fragen_zuThema3 = [
  Frage(
    nummer: 1,
    version: 1,
    themaID: 3,
    punkte: 5,
    text: "Was ist die Aufgabe eines Betriebssystems?",
    antworten: [
      Antwort(text: "Verwaltung von Hardware und Software", erklaerung: "Das ist korrekt.", isKorrekt: true),
      Antwort(text: "Erstellen von Programmen", erklaerung: "Betriebssysteme erstellen keine Programme.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 1,
    version: 2,
    themaID: 3,
    punkte: 5,
    text: "Wie unterstützt ein Betriebssystem die Hardware?",
    antworten: [
      Antwort(text: "Es verwaltet die Ressourcen", erklaerung: "Das ist richtig.", isKorrekt: true),
      Antwort(text: "Es installiert Software", erklaerung: "Das ist nicht die Hauptaufgabe eines Betriebssystems.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 1,
    themaID: 3,
    punkte: 5,
    text: "Welches Protokoll wird verwendet, um Webseiten anzuzeigen?",
    antworten: [
      Antwort(text: "HTTP", erklaerung: "HTTP ist das korrekte Protokoll.", isKorrekt: true),
      Antwort(text: "SMTP", erklaerung: "SMTP wird für E-Mail verwendet, nicht für Webseiten.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 2,
    themaID: 3,
    punkte: 5,
    text: "Welches Protokoll überträgt Webseiteninhalte?",
    antworten: [
      Antwort(text: "HTTP", erklaerung: "Richtig, HTTP wird dafür verwendet.", isKorrekt: true),
      Antwort(text: "FTP", erklaerung: "FTP wird für Dateitransfers verwendet, nicht für Webseiten.", isKorrekt: false),
    ],
  ),
];



List<Frage> mok_fragen_zuThema4 = [
  Frage(
    nummer: 1,
    version: 1,
    themaID: 4,
    punkte: 5,
    text: "Was ist die Aufgabe von HTTP?",
    antworten: [
      Antwort(text: "Webseiten-Inhalte übertragen", erklaerung: "Das ist korrekt.", isKorrekt: true),
      Antwort(text: "Dateien auf Server hochladen", erklaerung: "Falsch, dafür wird FTP verwendet.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 1,
    version: 2,
    themaID: 4,
    punkte: 5,
    text: "Wofür wird das HTTP-Protokoll verwendet?",
    antworten: [
      Antwort(text: "Übertragung von Webseiten", erklaerung: "Richtig, HTTP überträgt Webseiten.", isKorrekt: true),
      Antwort(text: "Übertragung von E-Mails", erklaerung: "E-Mails werden mit SMTP übertragen.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 1,
    themaID: 4,
    punkte: 5,
    text: "Was ist ein Server?",
    antworten: [
      Antwort(text: "Ein Gerät, das Dienste bereitstellt", erklaerung: "Korrekt, das ist die Hauptaufgabe eines Servers.", isKorrekt: true),
      Antwort(text: "Ein Computer für normale Benutzer", erklaerung: "Das ist nicht korrekt, Server sind für Dienste zuständig.", isKorrekt: false),
    ],
  ),
  Frage(
    nummer: 2,
    version: 2,
    themaID: 4,
    punkte: 5,
    text: "Welche Funktion hat ein Server?",
    antworten: [
      Antwort(text: "Bereitstellung von Diensten", erklaerung: "Das ist korrekt.", isKorrekt: true),
      Antwort(text: "Speichern von Dateien", erklaerung: "Das ist nicht die Hauptaufgabe eines Servers.", isKorrekt: false),
    ],
  ),
];