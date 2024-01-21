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


***Komentar:*** 
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


***Komentar:***
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


***Komentar:***
Analiza je pokrenuta nad svim fajlovima. Na prethodnoj slici mozemo videti dva upozorenja koja se ponavljaju u nekoliko fajlova. Jedno se odnosi na ime slota(funkcija koja reaguje na signale određenih objekata) zato sto nije konzistentno sa ostalim imenima slotova(korisiti se ime sa podvlakama umesto kamilje notacije) a konzistentnost je veoma bitna prilikom pisanja koda i ukoliko postoji i održava se, verovatnoća pravljenja greške se smanjuje. Drugo upozorenje se odnosi na vektor(preciznije QVector tip podataka) koji je inicijalizovan ali se nigde ne koristi.



Za više detalja o samom upozorenju, mozemo pristupiti dostupnoj dokumentaciji u par koraka:
* Desni klik na određeno upozorenje
* Izabrati opciju Web Page



**Zaključak:**

Clang alati su uglavnom jako korisni alati. Ukazuju nam na različite vrste greška i njihovim ispravljanjem možemo primetno unaprediti kvalitet koda.
Međutim, neka upozorenja ne treba usvojiti ili uopšte razmatrati. Nekada se te predložene izmene ne uklapaju u stil kodiranja koji smo koristili, nekada moze doći do narušavanja čitljivosti pa čak i do kolizija.
