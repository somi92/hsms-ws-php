create table ORGANIZACIJA (
	
	org_id numeric(7),
	naziv varchar(255) character set utf8,
	opis varchar(1024) character set utf8,
	website varchar(255) character set utf8,
	constraint ORG_PK primary key (org_id)
) DEFAULT CHARACTER SET utf8   
 COLLATE utf8_unicode_ci;

create table HUMANITARNI_BROJ (

	hb_id numeric(7),
	opis varchar(255) character set utf8,
	broj varchar(30) character set utf8,
	cena varchar(255) character set utf8,
	hb_status varchar(10) character set utf8,
	prioritet numeric(4) ,
	napomena varchar(255) character set utf8,
	org_id numeric(7),

	constraint HB_PK primary key (hb_id),
	constraint HB_FK foreign key (org_id)
		references ORGANIZACIJA (org_id),
	constraint HB_STATUS_CHECK check (hb_status in('Otvoren','Zatvoren','Nepoznato')),
	constraint HB_PRIORITET_CHECK check (prioritet in(1,2,3))
) DEFAULT CHARACTER SET utf8   
 COLLATE utf8_unicode_ci;


drop table HUMANITARNI_BROJ;
drop table ORGANIZACIJA;


insert into ORGANIZACIJA values (100,'Fondacija "Fond B92"', 'Fond B92 je nevladina organizacija koja osmišljava i realizuje neprofitne projekte. Fond B92 nastavlja tradiciju svih delova medijske kuće B92 (Odeljenja za društveno-odgovorno poslovanje) koristeći savremene alate za promociju demokratskih vrednosti. U okviru Fonda B92 realizuju se humanitarne kampanje, filantropski projekti, akcije društvene odgovornosti, produciraju se i promovišu dokumentarni filmovi i angažovana umetnost, podržava se aktivizam, podstiče edukacija, informiše o društvenim problemima – sve u cilju pozitivnih promena u društvu.','http://fondb92.org/sr/naslovna.1.1.html');
insert into ORGANIZACIJA values (101,'Humanitarna organizacija "Dečje srce"','Humanitarnu organizaciju Dečje srce smo 2001. godine zvanično registrivali, kako bi ozvaničili i struktuisali rad entuzijasta, većinom defektologa, koji su želeli da svoje vreme, znanje i druge resurse posvete pomoći osobama sa smetnjama u razvoju. Istraživanje koje smo tih godina sprovodili pokazalo je da među marginalizovanim grupama dece najugroženiju grupu dece čine deca sa smetnjama u mentalnom razvoju. Saznanje da će celi život neko morati da zastupa njihova prava opredelilo je naš rad i naš put kojim i danas hodamo.','http://decjesrce.rs/');
insert into ORGANIZACIJA values (102,'Vlada Republike Srbije','-','http://www.srbija.gov.rs/');
insert into ORGANIZACIJA values (103,'Blic fondacija','-','http://www.blic.rs/tag/115978/Blic-fondacija');
insert into ORGANIZACIJA values (104,'Fondacija "Ana i Vlade Divac"','-','http://www.fondacijadivac.org/Ana-i-Vlade-Divac/1/Naslovna.shtml');

insert into HUMANITARNI_BROJ values (200,'Pomoć ugroženima u poplavama','1003','100 din','Otvoren',1,'-',102);
insert into HUMANITARNI_BROJ values (201,'Humanitarna akcija za pomoć u lečenju Sare Živković','5045','100 din','Otvoren',1,'-',101);
insert into HUMANITARNI_BROJ values (202,'Humanitarna akcija "Bitka za bebe"','3100','100 din','Otvoren',2,'-',100);
insert into HUMANITARNI_BROJ values (203,'Humanitarna akcija za pomoć u lečenju Srne Sedmak','6133','100 din','Otvoren',1,'-',101);
insert into HUMANITARNI_BROJ values (204,'Humanitarna akcija "65+ Pokret za brigu o starima"','1651','100 din','Otvoren',3,'-',100);
insert into HUMANITARNI_BROJ values (205,'Humanitarna akcija "Srce za decu"','2552','100 din','Otvoren',2,'-',103);
insert into HUMANITARNI_BROJ values (206,'Humanitarna akcija "Jedan u milion"','2112','100 din','Otvoren',2,'-',104);
insert into HUMANITARNI_BROJ values (207,'Humanitarna akcija za pomoć u lečenju Une Savić','2205','100 din','Otvoren',1,'-',101);
insert into HUMANITARNI_BROJ values (208,'Humanitarna akcija za pomoć u lečenju Vuka Lojkovića','7553','100 din','Otvoren',1,'-',101);

select HB.hb_id, HB.opis, HB.broj, HB.cena, ORG.naziv, ORG.website, HB.prioritet, HB.napomena
from HUMANITARNI_BROJ HB join ORGANIZACIJA ORG on (HB.org_id = ORG.org_id)
order by HB.prioritet;

ALTER DATABASE hsms_database
 CHARACTER SET utf8
 DEFAULT CHARACTER SET utf8
 COLLATE utf8_unicode_ci
 DEFAULT COLLATE utf8_unicode_ci;

ALTER TABLE HUMANITARNI_BROJ
 DEFAULT CHARACTER SET utf8
 COLLATE utf8_unicode_ci
 ;

ALTER TABLE ORGANIZACIJA
 DEFAULT CHARACTER SET utf8
 COLLATE utf8_unicode_ci
 ;