---
name: przychod-walutowy-nbp
description: >
  Przelicza przychód w walucie obcej (np. Amazon KDP, faktury w EUR/USD/GBP)
  na PLN według właściwego kursu NBP dla celów KPiR i ryczałtu. Używaj, gdy
  pojawia się przychód walutowy do zaksięgowania, raport sprzedaży Amazon KDP,
  wpływ waluty na rachunek lub pytanie "po jakim kursie przeliczyć przychód".
---

# Przeliczanie przychodu walutowego wg kursu NBP

## Cel
Ustalić poprawną kwotę przychodu w PLN dla przychodu osiągniętego w walucie
obcej, zgodnie z polskimi przepisami podatkowymi, i przygotować dane gotowe
do zaksięgowania w KPiR lub ewidencji przychodów (ryczałt).

## Kiedy używać
- Rozliczenie sprzedaży Amazon KDP (royalties w USD/EUR/GBP itd.).
- Faktury sprzedażowe wystawione w walucie obcej.
- Każdy przychód, którego kwota pierwotnie wyrażona jest w walucie obcej.

## Zasada prawna (najważniejsze)
> Przychód w walucie obcej przelicza się na złote według **średniego kursu NBP
> z ostatniego dnia roboczego poprzedzającego dzień uzyskania przychodu**
> (tabela A NBP).
> Podstawa: art. 11a ust. 1 ustawy o PIT.

Dlatego kluczowe są DWIE rzeczy:
1. **Data powstania przychodu** (nie data wpływu waluty na konto!).
2. **Kurs z dnia roboczego POPRZEDZAJĄCEGO** tę datę (pomijamy soboty,
   niedziele i święta — cofamy się do ostatniego dnia, w którym NBP publikował
   tabelę A).

## Ustalenie daty przychodu
- Zasadniczo: dzień wykonania usługi / wydania rzeczy, nie później niż dzień
  wystawienia faktury albo uregulowania należności (art. 14 ust. 1c PIT).
- Dla Amazon KDP przyjmij datę zgodną z dotychczasową, konsekwentnie stosowaną
  metodą w tej JDG. **Jeśli nie jest jednoznaczna — zapytaj, nie zgaduj.**

## Krok po kroku
1. Zbierz dane wejściowe: kwota, waluta, **data powstania przychodu**.
2. Wyznacz dzień kursu = ostatni dzień roboczy **przed** datą przychodu
   (cofnij się przez weekendy i święta).
3. Pobierz średni kurs NBP (tabela A) dla danej waluty na ten dzień.
   - Źródło: tabela A NBP. Jeśli dostępny jest serwer MCP / integracja z API
     NBP — użyj go. Jeśli nie — poproś o ręczne podanie kursu i go zastosuj.
4. Przelicz: `kwota_PLN = kwota_waluta * kurs`, zaokrąglij do 0,01 PLN.
5. Zapisz w zestawieniu: data przychodu, data kursu, kurs, kwota waluty,
   kwota PLN, źródło kursu.
6. Wskaż miejsce ujęcia: KPiR kol. 7 (sprzedaż) lub ewidencja przychodów
   (właściwa stawka ryczałtu).

## Format wyniku
Zwróć tabelę i jedno zdanie podsumowania:

| Data przychodu | Data kursu | Waluta | Kurs NBP | Kwota waluta | Kwota PLN |
|---|---|---|---|---|---|
| 2026-05-10 | 2026-05-09 | USD | 3,9812 | 1 250,00 | 4 976,50 |

Podsumowanie: "Przychód 1 250,00 USD z 2026-05-10 → 4 976,50 PLN (kurs NBP
tab. A z 2026-05-09: 3,9812). Ująć w KPiR kol. 7."

## Czego NIE robić
- Nie używaj kursu z dnia wpływu waluty na konto ani kursu z dnia przychodu.
- Nie używaj kursu kupna/sprzedaży banku — tylko **średni** kurs NBP (tab. A).
- Nie zaokrąglaj kursu — bierz pełną wartość z tabeli (4 miejsca po przecinku).
- Nie zgaduj kursu, gdy brak danych — poproś o jego podanie.

## Lista kontrolna przed zaksięgowaniem
- [ ] Data przychodu ustalona i uzasadniona.
- [ ] Kurs z dnia roboczego POPRZEDZAJĄCEGO (nie z dnia przychodu).
- [ ] Tabela A NBP, kurs średni, 4 miejsca po przecinku.
- [ ] Kwota PLN zaokrąglona do grosza.
- [ ] Wskazane miejsce ujęcia (KPiR / ewidencja ryczałtu).

## Źródła do zweryfikowania (stan prawny sprawdzaj na bieżąco)
- Ustawa o PIT, art. 11a ust. 1 (przeliczanie walut).
- Ustawa o PIT, art. 14 ust. 1c (data powstania przychodu).
- Tabela kursów średnich NBP (tabela A).
