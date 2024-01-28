# Izveštaj analize projekta

## 1. Clang
Clang jeste kompilator koji se koristi za jezike C, C++, Objective C i Objective C++. Posmatramo ga kao frontend koji na ulazu dobije kod koji je napisan u nekom od nabrojanih jezika i zatim taj isti kod prevodi u međureprezentaciju. Backend delu ostaje da izvrši optimizacije koje zavise od same arhitekture i da prevede kod na mašinski jezik.

Implementacija je urađena u C++.  



### 1.1. Clang-Tidy
Clang-Tidy predstavlja jedan od clang zasnovanih alata koji obavlja statičku analizu koda tj. vrši analiziranje izvornog koda bez njegovog izvršavanja sa ciljem pronalaženja grešaka, poboljšanja kvaliteta koda i ispravljanja neoptimalno napisanih delova koda.
Pripada takođe i linter alatima koji analiziraju kod i pronalaze programske i stilske greške unutar koda.

Integrisan je u okviru QtCreator-a i njegova upotreba će biti prikazana u okviru ovog okruženja.
* Izabrati karticu Analyze a zatim odabrati alat Clang-Tidy.
 
![clangTidy_pokretanje](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_pokretanje.png "Pokretanje alata Clang-Tidy.")
* Izabrati fajlove koje želimo da obuhvatimo analizom.

![clangTidy_izborFajlova](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_izborFajlova.png "Biranje fajlova za analizu.")
* Analiza nad izabranim fajlovima se pokreće klikom na dugme Analyze.
* Dobija se sledeći rezultat.

![clangTidy_rezultat_defaultConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_rezultat_defaultConfig.png "Rezultati analize.")


**Komentar:**
Analiza je pokrenuta nad svim fajlovima i u okviru izveštaja smo dobili tri upozorenja, istog tipa u istom fajlu. Upozorenja nam govore da postoje promenljive čije se vrednosti nikada ne čitaju.


Prethodno izvedena analiza urađena je pod podrazumevanom konfiguracijom
![clangTidy_dafaultConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_dafaultConfig.png "Podrazumevana konfiguracija za alat Clang-Tidy.")


Postoji mogućnost da se ta konfiguracija modifikuje.

* Izabrati karticu Edit a zatim opciju Preference.
* U listi koja se nalazi sa leve strane, biramo Analyzer.
* Klikom na Default Clang-Tidy and Clazy checks, otvaramo prozor u kom se moze napraviti nova konfiguracija dodavanjem novih opcija (pored standardno izabrane clang-* koja je uvek uključena)
* Pravimo novu konfiguraciju MyCustomChecks dodavanjem još i opcija performance-\* i readability-\*

![clangTidy_customConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_customConfig.png "Modifikovana konfiguracija za alat Clang-Tidy.")
* Dobija se sledeći rezultat

![clangTidy_rezultat_customConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clang-Tidy/clangTidy_rezultat_customConfig.png "Rezultati analize.")


**Komentar:**
Analiza je pokrenuta nad svim fajlovima. Očekivano, ovde dobijamo i više različitih upozorenja. Upozorenje koje se najčešće javlja u ovom projektu i koje se nalazi na prethodnoj slici, jeste vezano za uvođenje konstanti umesto korišćenja 'magičnih' brojeva što bi povećalo čitljivost. Pored toga pojavila su se i upozorenja za kratko ime promenljive(zbog čitljivosti traži da dužina bude najmanje tri karaktera), za suvišne delove unutar klasa ili struktura(uglavnom se odnose na nepotrebna ponavljanja)...



### 1.2. Clazy
Clazy predstavlja dodatak za clang, koji mu pomaže da razume Qt semantiku. Njegov zadatak je da prikazuje upozorenja kompajlera vezana za Qt(nepravilno korišćenje API-ja, potencijalno curenje memorije, nepravilne konverzije tipova podataka...).


Integrisan je u okviru QtCreator-a i njegova upotreba će biti prikazana u okviru ovog okruzenja.

* Kao i kod Clang-Tidy-a mogu se namestiti različite konfiguracije. Podrazumevana obuhvata dva nivoa provere a to su 0 i 1. Prilikom ovog pokretanja, izabran je samo nivo 0(Bez lažnih pozitivnih upozorenja).

![clazy_customConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clazy/clazy_customConfig.png "Modifikovana konfiguracija za alat Clazy.")
* Izabrati karticu Analyze a zatim odabrati Clazy.
* Izabrati fajlove koje želimo da obuhvatimo analizom.
* Analiza nad izabranim fajlovima se pokreće klikom na dugme Analyze.
* Dobijeni rezultati.
  
![clazy_rezultat_customConfig](https://github.com/MATF-Software-Verification/2023_Analysis_16-battleships/blob/main/Clang/Clazy/clazy_rezultat_customConfig.png "Rezultati analize.")


**Komentar:**
Analiza je pokrenuta nad svim fajlovima. Na prethodnoj slici mozemo videti dva upozorenja koja se ponavljaju u nekoliko fajlova. Jedno se odnosi na ime slota(funkcija koja reaguje na signale određenih objekata) zato sto nije konzistentno sa ostalim imenima slotova(korisiti se ime sa podvlakama umesto kamilje notacije) a konzistentnost je veoma bitna prilikom pisanja koda i ukoliko postoji i održava se, verovatnoća pravljenja greške se smanjuje. Drugo upozorenje se odnosi na vektor(preciznije QVector tip podataka) koji je inicijalizovan ali se nigde ne koristi.



Za više detalja o samom upozorenju, mozemo pristupiti dostupnoj dokumentaciji u par koraka:
* Desni klik na određeno upozorenje
* Izabrati opciju Web Page



***Zaključak:***

Clang alati su uglavnom jako korisni alati. Ukazuju nam na različite vrste greška i njihovim ispravljanjem možemo primetno unaprediti kvalitet koda.
Međutim, neka upozorenja ne treba usvojiti ili uopšte razmatrati. Nekada se te predložene izmene ne uklapaju u stil kodiranja koji smo koristili, nekada moze doći do narušavanja čitljivosti pa čak i do kolizija.



## 2. CppCheck

CppCheck jeste alat koji se koristi za statičku analizu koda pisanog u C/C++ programskom jeziku. Detektuje bagove i fokusira se na pronalaženje nedefinisanog ponašanja(deljenje nulom, neinicijalizovane promenljive, nekorišćeni pokazivači...) i curenja memorije. 
Upotrebom ovog alata može se značajno poboljšati kvalitet koda i povećati pouzdanost softvera.

Za instalaciju ovog alata potrebno je prvo u terminalu pokrenuti sledeću komandu:
```
sudo apt-get install cppcheck
```

Prilikom pokretanja analize, dodaćemo i odredjene opcije koje će doprineti samoj analizi:
* *--enable=all* (uključuje sve dostupne provere koje alat može da izvrši)
* *--inconcuslive* (alat će prijaviti i neodlučne greške tj greške koje alat nije mogao da kategorijuzuje kao greške ili upozorenja pa ih u redovnim okolnostima ne bi uključio u izveštaj)
* *--suppress=missingInclude* (Ignorisaćemo greške koje dobijamo iz headera. Razlog za to je što alat može imati problem sa proveravanjem biblioteka(pogotovo sistemskih) koje se uključuju u header delu nekog fajla.)
* *--output-file="cppcheck-output"*


Komanda se primenjuje nad svim fajlovima i na kraju izgleda ovako:
```
cppcheck --enable=all --inconclusive --suppress=missingInclude --quiet --output-file="cppcheck-output.txt" 16-battleship
```


Kompletan rezultat nalazi se u fajlu cppcheck-output.txt, a u ovom izveštaju izdvojiću par zanimljivih:

> 16-battleships/Server/source/server.cpp:41:5: warning:inconclusive: Either the condition 'if(soket)' is redundant or there is possible null pointer dereference: soket. [nullPointerRedundantCheck]
    soket->flush();
    ^

**Komentar:**

U analizi se javlja nekoliko upozorenja tipa nullPointerRedundantCheck u kojima se prijavljuje da može doći do pozivanja funkcije nad pokazivačem koji ima null vrednost.
Ukoliko se pogleda baš ovaj primer u server.cpp fajlu, može se primetiti da su autori projekta proverili da li soket ima vrednost pre nego što su ga koristili, ali su van te provere ostavili njegovo pražnjenje i zato dolazi do ovog upozorenja. Rešenje može biti dodatni if ili premeštanje linije u blok koda u kom smo sigurni da pokazivač ima svoju vrednost.



> 16-battleships/Server/source/server.cpp:21:56: note: Assignment 'soket=m_server->nextPendingConnection()', assigned value is 0
    QTcpSocket* soket = m_server->nextPendingConnection();
    
**Komentar:** 

Alat upozorava da je vrednost pokazivača prilikom inicijalizacije jednaka nuli. Autori su svakako pre korišćenja proverili vrednost pokazivača.


> 16-battleships/battleships/source/Brod.cpp:5:7: warning: Member variable 'Brod::m_postavljen' is not initialized in the constructor. [uninitMemberVar]
Brod::Brod(int broj, QPair<int, int> poc,QPair<int,int> kraj)

**Komentar:**

Alat upozorava da odredjena promenljiva nije inicijlizovana prilikom kreiranja klase kojoj pripada. Ukoliko postoji neka podrazumevana ili neutralna vrednost za ovu promenljivu može se iskoristiti da se izbegne ovo upozorenje, ali to često nije slučaj.


> 16-battleships/battleships/source/Brod.cpp:25:5: performance: Variable 'm_pozPocetak' is assigned in constructor body. Consider performing initialization in initialization list. [useInitializationList]
    m_pozPocetak = brod.m_pozPocetak;
    
**Komentar:**

Alat predlaže, zbog boljih performansi, da prilikom kreiranja navedene klase koristi lista inicijalizacije, umesto inicijalizovanja unutar tela konstrukta. Razlog za to je što navedenu promenljivu verovatno prepoznaje kao konstantnu vrednost.


Ostatak analize se uglavnom odnosi na situacije u kojima promenljiva moze biti deklarisana kao konstanta ili kada se neka funkcija/promenljiva naprave a ne koriste se nigde u kodu.


***Zaključak:***

Na osnovu analize, stiče se utisak da autori nisu oprezno koristili pokazivače ali to nije potpuno tačno. U kodu postoje provere pokazivača pre njihovog korišćenja i preduzimanja akcija zbog kojih su suštinski i napravljeni, a propusti su uglavnom bili to što su završne akcije nad pokazivačima (pražnjenje, oslobadjanje i slično) van bloka koda u kom smo sigurni da pokazivač ima valjanu vrednost. Opisani problem se može jednostavno rešiti.
Pored toga, postoji prostor za poboljšanje čitljivosti koda, kao i performansi ukoliko autor proceni da su dobijeni predlozi iz analize izvodljivi.


## 3. Flawfinder

**Flawfinder** jeste alat koji služi za pregledanje i prijavljivanje sigurnosnih propusta u programu koji je napisan u C ili C++ programskom jeziku. Poseduje odredjeni skup pravila koji koristi prilikom traženja potencijalno nebezbednih mesta unutar programa. Kao izlaz, dobija se izveštaj u kom svaka od prijavljenih grešaka ima svoju ocenu značajnosti(nalazi se u uglastim zagradama).

Za instalaciju ovog alata potrebno je prvo u terminalu pokrenuti sledeću komandu:
```
sudo apt-get install flawfinder
```

Prilikom pokretanja analize, mogu se dodati i neke opcije kojima možemo preciznije da usmerimo analizu ili koje nam mogu pomoći za kasnije tumačenje izveštaja koji se dobije. Neke od njih su:

* *--followdotdir* (prilikom analiziranja ulazi i u direktorijume koji počinju sa tačkom, koje inače ignoriše)
* *--minlevel=X* (odredjuje se minimalna ocena značajnosti za greške koje se prikazuju u izveštaju)
* *--neverignore* (nijedan bezbednosni propust se ne ignoriše)
* *--html* (izveštaj će biti u html formatu)
* *--immediate* (ispis se desi čim se propusti pronadju, ne čeka se kraj analize)
 


Komandu primenjujem nad svim fajlovima i ona izleda ovako:
```
flawfinder --html 16-battleship > flawfinder_result.html 16-battleship
```

Kompletan rezultat nalazi se u fajlu flawfinder_result.html. 
Jako korisna stvar je to što za svaku od prijavljenih grešaka možemo pročitati detaljnije informacije samo jednim klikom na kod greške u samom izveštaju.

**Komentar:**
* <ins>*Upozorenje CWE-27:*

Upozorava da program koristi neispravan ili rizican kriptografski algoritam ili protokol, što može dovesti do otkrivanja osetljivih informacija, modifikovanja podataka na neočekivane načine ili neke druge neželjene akcije. 

U ovom konkretnom slučaju, ovo upozorenje ima ocenu važnosti tri, odnosi se na funkciju srand u fajlu partija.cpp i predlaže se da se pronadje nova bezbednija funkcija koja će vraćati nasumične vrednosti. Kao jedna od bezbednijih alternativa navodi se funckija rand_s.

* <ins>*Upozorenje CWE-362:*

Upozorava da u programu postoji sekvenca koda koja bi trebala da ima poseban eksluzivni pristup deljenim resursima, ali da to nije slučaj. Postoji opasnost da se paralelnim izvršavanjem nekog drugog, mozda namenski ubačenog, koda izmeni i zloupotrebi željeno ponašanje kako bi se došlo do poverljivih datoteka ili informacija.

U projektu koji analiziramo, dobili smo tri ovakva upozorenja i njihova ocena važnosti je dva. Sve se odnose na otvaranje fajla pomoću funkcije open i predlog za rešavanje ovog potencijalnog bezbednosnog problema jeste da se uvedu dodatne provere pre samog otvaranja fajla kojim bi se proverilo da li izabrane datoteke zaista smeju biti otvorene.

* <ins>*Upozorenje CWE-119/CWE-120:*

Upozorenja se odnose na rad sa baferom bez proveravanja njegove veličine i skreću pažnju autoru projekta da je neophodno da na tim mestima postoje odredjene provere kako ne bi došlo do čitanja ili pisanja van opsega statički alociranog bafera. Ocena važnosti ovog upozorenja jesta dva.

U ovom projektu se ovo upozorenje najčešće javlja.


***Zaključak:***

Može se uočiti da se javlju tri različita upozorenja u samom programu, jedno od njih dominantno. Propusta ima i po oceni značajnosti postoji samo jedno upozorenje nivoa 3.
Treba više pažnje obratiti prilikom rada sa baferom i otvaranja datoteka kako bi se izbegle greške i sačuvale poverljive informacije(ukoliko autor proceni da uopšte takve informacije postoje u ovom projektu).
Uglavnom se sva upozorenja mogu rešiti odgovarajućim (dodatnim) proverama pre preduzimanja samih akcija.
