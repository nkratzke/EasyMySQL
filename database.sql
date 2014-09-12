CREATE DATABASE  IF NOT EXISTS `LVBsp` DEFAULT CHARSET=utf8;USE `LVBsp`;--
-- Table structure for table `Lehrveranstaltung`
--

DROP TABLE IF EXISTS `Lehrveranstaltung`;
CREATE TABLE `Lehrveranstaltung` (
  `LVID` varchar(16) NOT NULL,
  `Raum` varchar(16) DEFAULT NULL,
  `Semester` int(11) DEFAULT NULL,
  `Titel` varchar(256) DEFAULT NULL,
  `Zeit` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`LVID`)
);

--
-- Table structure for table `Studiengang`
--

DROP TABLE IF EXISTS `Studiengang`;
CREATE TABLE `Studiengang` (
  `SGID` varchar(16) NOT NULL,
  `Bezeichnung` varchar(128) DEFAULT NULL,
  `Abschluss` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`SGID`)
);

--
-- Table structure for table `Studenten`
--

DROP TABLE IF EXISTS `Studenten`;
CREATE TABLE `Studenten` (
  `MatrNr` varchar(16) NOT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Strasse` varchar(64) DEFAULT NULL,
  `PLZ` varchar(5) DEFAULT NULL,
  `ORT` varchar(16) DEFAULT NULL,
  `Telefon` varchar(16) DEFAULT NULL,
  `EmailAdresse` varchar(64) DEFAULT NULL,
  `SGID` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`MatrNr`),
  KEY `SGID` (`SGID`),
  CONSTRAINT `Studenten_ibfk_1` FOREIGN KEY (`SGID`) REFERENCES `Studiengang` (`SGID`)
);

--
-- Table structure for table `besteht_aus`
--

DROP TABLE IF EXISTS `besteht_aus`;
CREATE TABLE `besteht_aus` (
  `SGID` varchar(16) NOT NULL,
  `LVID` varchar(16) NOT NULL,
  PRIMARY KEY (`SGID`,`LVID`),
  KEY `LVID` (`LVID`),
  CONSTRAINT `besteht_aus_ibfk_1` FOREIGN KEY (`SGID`) REFERENCES `Studiengang` (`SGID`),
  CONSTRAINT `besteht_aus_ibfk_2` FOREIGN KEY (`LVID`) REFERENCES `Lehrveranstaltung` (`LVID`)
);

--
-- Table structure for table `besuchen`
--

DROP TABLE IF EXISTS `besuchen`;
CREATE TABLE `besuchen` (
  `MatrNr` varchar(16) NOT NULL,
  `LVID` varchar(16) NOT NULL,
  `Note` int(11) DEFAULT NULL,
  PRIMARY KEY (`MatrNr`,`LVID`),
  KEY `LVID` (`LVID`),
  CONSTRAINT `besuchen_ibfk_1` FOREIGN KEY (`MatrNr`) REFERENCES `Studenten` (`MatrNr`),
  CONSTRAINT `besuchen_ibfk_2` FOREIGN KEY (`LVID`) REFERENCES `Lehrveranstaltung` (`LVID`)
);

--
-- Dumping data for table `Lehrveranstaltung`
--

LOCK TABLES `Lehrveranstaltung` WRITE;
INSERT INTO `Lehrveranstaltung` VALUES
  ('DBSP','1-1.10',5,'Datenbank-gestützte serverseitige Programmierung','Mo: 12:00-13:30'),
  ('DBSPP1','18-1.18',5,'Praktikum I zu DBSP','Mo: 10:00-11:30'),
  ('DBSPP2','18-1.18',5,'Praktikum II zu DBSP','Di: 10:00-11:30'),
  ('DBSPP3','18-1.18',5,'Praktikum III zu DBSP','Di: 12:00-13:30'),
  ('GOOP','1-1.09',1,'Grundlagen objektorienter Programmierung','Fr: 10:00-11:30'),
  ('GOOPÜ1','18-1.17',1,'Übung I GOOP','Mi: 14:30-16:00'),
  ('GOOPÜ2','18-1.17',1,'Übung II GOOP','Mi: 16:15-17:30'),
  ('ITM','18-0.01',5,'IT-Management','Fr: 12:00-13:30'),
  ('ITMP','18-0.01',5,'IT-Management Praktikum','Fr: 14:00-15:30');
UNLOCK TABLES;

--
-- Dumping data for table `Studiengang`
--

LOCK TABLES `Studiengang` WRITE;
INSERT INTO `Studiengang` VALUES
  ('ESA','ESA - Energiesysteme und Automation','Bachelor'),
  ('IGi','IGi - Informationstechnologie & Gestaltung','Bachelor'),
  ('INF','INF - Informatik','Master'),('MIB','MIB - Medieninformatik Online','Bachelor');
UNLOCK TABLES;

--
-- Dumping data for table `Studenten`
--

LOCK TABLES `Studenten` WRITE;
INSERT INTO `Studenten` VALUES
  ('12345678','Helge Schneider','Klimpergasse 4','23578','Kuckucksheim','089-nie-wieder','h.schn@ider.de','INF'),
  ('12345679','Armin Schneider','Asgardweg 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345680','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','INF'),
  ('12345681','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','MIB'),
  ('12345682','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345683','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('12345684','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','INF'),
  ('12345685','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','MIB'),
  ('12345686','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','ESA'),
  ('12345687','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345688','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('12345689','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','INF'),
  ('12345690','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','ESA'),
  ('12345691','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345692','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','MIB'),
  ('12345693','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','IGi'),
  ('12345694','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','IGi'),
  ('12345695','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','IGi'),
  ('12345696','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','IGi'),
  ('12345697','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('12345698','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','ESA'),
  ('12345699','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','INF'),
  ('12345700','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','MIB'),
  ('12345701','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345702','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','INF'),
  ('12345703','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','MIB'),
  ('12345704','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','ESA'),
  ('12345705','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345706','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('12345707','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','INF'),
  ('12345708','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','ESA'),
  ('12345709','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('12345710','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','MIB'),
  ('12345711','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','IGi'),
  ('12345712','Helge Müller','Klimpergasse 4','23578','Endhausen','089-schon-wieder','h.schneider@gmx.de','IGi'),
  ('12345713','Wilder Wahnsinn','Testosteron 5','41111','Bungeehausen','034-wo-war-was-n','nomail@wwww.de','IGi'),
  ('12345714','Holger Hilflos','Klimpergasse 46','23569','Lübeck','0451-1','mueller@gate.de','IGi'),
  ('12345715','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('12345716','Wilder Müller','Endhausen 5','45632','Kuckuckshein','keine Angabe','wilder@oderwas.de','ESA'),
  ('12345717','Helge SoundSo','Musikergrube 4','23578','Lübeck','keine Angabe','unbekannt','INF'),
  ('56734512','Armin Müller','Asgardweg 9','23569','Lübeck','0451-1','mueller@gate.de','ESA'),
  ('56788992','Wilder Wutz','Sackgasse 5','45632','Endhausen','034-wo-war-das','ww@w.de','MIB');
UNLOCK TABLES;

--
-- Dumping data for table `besteht_aus`
--

LOCK TABLES `besteht_aus` WRITE;
INSERT INTO `besteht_aus` VALUES
  ('ESA','DBSP'),
  ('IGi','DBSP'),
  ('MIB','DBSP'),
  ('ESA','DBSPP1'),
  ('IGi','DBSPP2'),
  ('IGi','DBSPP3'),
  ('IGi','GOOP'),
  ('INF','GOOP'),
  ('IGi','GOOPÜ1'),
  ('INF','GOOPÜ1'),
  ('IGi','GOOPÜ2'),
  ('INF','GOOPÜ2'),
  ('INF','ITM'),
  ('INF','ITMP');
UNLOCK TABLES;

--
-- Dumping data for table `besuchen`
--

LOCK TABLES `besuchen` WRITE;
INSERT INTO `besuchen` VALUES
  ('12345678','GOOP',1),
  ('12345678','ITM',1),
  ('12345679','GOOP',2),
  ('12345680','GOOP',2),
  ('12345681','GOOP',2),
  ('12345682','DBSP',3),
  ('12345682','GOOP',3),
  ('12345682','ITM',3),
  ('12345696','ITM',4),
  ('12345697','DBSP',4),
  ('12345697','GOOP',5),
  ('12345698','DBSP',5),
  ('12345699','DBSP',4),
  ('12345700','ITM',4),
  ('12345701','GOOP',3),
  ('12345702','GOOP',3),
  ('12345703','ITM',3),
  ('12345704','ITM',2),
  ('12345705','GOOP',2),
  ('12345706','ITM',2),
  ('12345707','GOOP',1),
  ('12345708','ITM',1),
  ('12345709','GOOP',1),
  ('12345710','GOOP',2),
  ('12345711','DBSP',2),
  ('12345712','DBSP',2),
  ('12345713','DBSP',3),
  ('12345714','ITM',3),
  ('12345715','ITM',3),
  ('12345716','ITM',2),
  ('12345717','DBSP',2),
  ('12345717','ITM',NULL),
  ('56734512','DBSP',NULL),
  ('56734512','GOOP',NULL),
  ('56788992','ITM',NULL);
UNLOCK TABLES;
