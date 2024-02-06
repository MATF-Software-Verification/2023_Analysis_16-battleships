# 2023_Analysis_16-battleships

# :memo: O projektu:
- Projekat ***Battleships*** je igrica koja simulira borbu između ratnih brodova. Igra se u potezima naizmenično i cilj je prvi potopiti sve protivničke brodove. Otežavajuća okolonost je to što brodovi protivnika nisu vidljivi, već im se nasumičnim gađanjem može ući u trag. Igrica se može igrati i u singleplayer i u multiplayer(na istom računaru) režimu. Najbolji rezultati se čuvaju u tabeli rezultata.
  
- U okviru ovog rada biće predstavljena analiza prethodno opisanog projekta Battleships rađenog u okviru kursa Razvoj softvera na Matematičkom fakultetu, koji se nalazi na adresi https://gitlab.com/matf-bg-ac-rs/course-rs/projects-2022-2023/16-battleships (main grana, hash kod commita: 0402b14071df6016652a8ad0ab88a9a1da863025) , gde se u okviru README.md fajla mogu pronaći i detaljnije informacije o igrici, instalacije, pokretanje, autori, kao i demo snimak. Ovaj rad će sadržati analizu tog projekta, odnosno alate za verifikaciju softvera koji su primenjeni, način njihove primene, rezultate, eventualne pronađene bagove i zaključke izvedene iz analiza.



# :wrench: Alati koji su korišćeni:
* Clang-Tidy
* Clazy
* CppCheck
* Flawfinder
* Memcheck
* Callgrind
* Massif

Za alate CppCheck, Flawfinder, Memcheck i Callgrind napisane su skripte za njihovo pokretanje i one se nalaze u okviru foldera navednih alata.



# :memo: Zaključak:
Kod projekta se moze smatrati urednim i čitljivim. Određeni delovi koda se mogu izbaciti jer se ne koriste i takođe se mogu usvojiti neki od predloga stilskih upozorenja iz analiza kako bi kvalitet koda bio jos veći. 

Sama logika igrice mi je bila poznata, pa je to olakšalo razumevanje koda ali generalno bi bilo korisno dodati i komentare na nekim mestima.

Aplikacija nije takva da sadrži neke poverljive i osetljive informacije, pa malobrojni propusti dobijeni u sigurnosnoj analizi nisu od prevelike važnosti, ali je svakako preporučljivo da se i oni reše ukoliko je to moguće. 

Rad sa pokazivačima a pogotovo sa memorijom je mogao biti oprezniji, a takođe je bitno naglasiti da u projektu nijedan bag nije pronađen.



# Autor:
Momčilo Knežević, 1087/2022
