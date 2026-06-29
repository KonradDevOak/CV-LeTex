# Złożoność algorytmiczna — podstawy

## Big O — co oznacza

Big O opisuje jak rośnie czas wykonania (lub zużycie pamięci) w zależności od rozmiaru danych (n), w **najgorszym przypadku**.

| Notacja | Nazwa | Przykład |
|---------|-------|---------|
| O(1) | stała | dostęp do elementu słownika po kluczu |
| O(log n) | logarytmiczna | binary search |
| O(n) | liniowa | przejście przez listę |
| O(n log n) | | sortowanie (QuickSort avg, MergeSort) |
| O(n²) | kwadratowa | zagnieżdżone pętle |

## Dictionary vs List — kluczowa różnica

### Dictionary<K,V> (hash table)

- **Wyszukiwanie po kluczu: O(1) średnio**
- Klucz jest hashowany → bezpośredni adres w pamięci
- Pesymistyczny przypadek (kolizje): O(n), ale w praktyce rzadki
- Dodawanie / usuwanie: O(1) średnio

```csharp
var dict = new Dictionary<string, int>();
dict["klucz"] = 42;
var val = dict["klucz"]; // O(1) — hash → bezpośredni dostęp
```

### List<T> (dynamic array)

- **Wyszukiwanie po wartości: O(n)** — trzeba przejść przez całą listę
- **Dostęp po indeksie: O(1)** — `list[5]` to bezpośredni adres (indeks × rozmiar elementu)
- Dodawanie na końcu: O(1) amortyzowane
- Wstawianie w środku: O(n) — przesunięcie elementów

```csharp
var list = new List<int> { 1, 2, 3, 4, 5 };
var val = list[2];          // O(1) — indeks numeryczny
var found = list.Contains(3); // O(n) — liniowe szukanie
```

## Porównanie struktur w C#

| Struktura | Dostęp | Szukanie | Dodawanie |
|-----------|--------|----------|-----------|
| `Dictionary<K,V>` | O(1) po kluczu | O(n) po wartości | O(1) avg |
| `List<T>` | O(1) po indeksie | O(n) po wartości | O(1) na końcu |
| `HashSet<T>` | — | O(1) avg | O(1) avg |
| `SortedDictionary<K,V>` | O(log n) | O(log n) | O(log n) |
| `LinkedList<T>` | O(n) | O(n) | O(1) na początku/końcu |

## Zasada praktyczna

- Często szukam po kluczu → `Dictionary`
- Potrzebuję kolejności + indeksu numerycznego → `List`
- Sprawdzam tylko czy element istnieje (unikalność) → `HashSet`

## Pytanie na rozmowie

> "Jaka jest złożoność wyszukiwania po kluczu w słowniku vs po wartości w liście?"

`Dictionary<K,V>` — O(1) średnio, bo używa hash table i klucz hashowany trafia bezpośrednio do odpowiedniego miejsca. `List<T>` — O(n), bo bez indeksu muszę przejść przez wszystkie elementy liniowo.
