# HashSet

## Co to jest

`HashSet<T>` to kolekcja **unikalnych elementów** bez kolejności, oparta na hash table. Działa jak `Dictionary<T, bool>` — ale bez wartości, sam klucz.

## Operacje i złożoność

| Operacja | Złożoność | Opis |
|----------|-----------|------|
| `Add` | O(1) avg | dodaj element (ignoruje duplikaty) |
| `Contains` | O(1) avg | sprawdź czy element istnieje |
| `Remove` | O(1) avg | usuń element |
| Iteracja | O(n) | przejście przez wszystkie elementy |

Pesymistycznie O(n) przy kolizjach hash — tak samo jak Dictionary.

## C# — `HashSet<T>`

```csharp
var set = new HashSet<string>();

set.Add("a");
set.Add("b");
set.Add("a"); // ignorowane — duplikat

set.Count;        // 2
set.Contains("a"); // true — O(1)
set.Contains("c"); // false — O(1)

// vs List:
var list = new List<string> { "a", "b", "a" };
list.Contains("a"); // true — O(n), przejście liniowe
```

## JavaScript — `Set`

```ts
const set = new Set<string>();

set.add("a");
set.add("b");
set.add("a"); // ignorowane

set.size;       // 2
set.has("a");   // true — O(1)
set.has("c");   // false

set.delete("a");

// Konwersja z/na tablicę:
const arr = ["a", "b", "a", "c"];
const unique = [...new Set(arr)]; // ["a", "b", "c"] — usunięcie duplikatów
```

## Kiedy używać zamiast `List`

**Pytanie na rozmowie: "kiedy HashSet zamiast List?"**

> Gdy potrzebuję często sprawdzać czy element istnieje (`Contains`) — HashSet to O(1), List to O(n). Gdy zależy mi na unikalności elementów. Gdy kolejność nie ma znaczenia.

```csharp
// Szukanie odwiedzonych węzłów w BFS/DFS:
var visited = new HashSet<int>(); // O(1) Contains — kluczowe dla wydajności

// vs:
var visited = new List<int>();    // O(n) Contains — wolne dla dużych grafów
```

## Operacje na zbiorach

HashSet obsługuje operacje matematyczne na zbiorach:

```csharp
var a = new HashSet<int> { 1, 2, 3, 4 };
var b = new HashSet<int> { 3, 4, 5, 6 };

a.IntersectWith(b);  // część wspólna:  { 3, 4 }
a.UnionWith(b);      // suma:           { 1, 2, 3, 4, 5, 6 }
a.ExceptWith(b);     // różnica (a - b): { 1, 2 }
a.IsSubsetOf(b);     // czy a ⊆ b?
```

```ts
// JavaScript:
const a = new Set([1, 2, 3, 4]);
const b = new Set([3, 4, 5, 6]);

const intersection = new Set([...a].filter(x => b.has(x))); // { 3, 4 }
const union = new Set([...a, ...b]);                         // { 1, 2, 3, 4, 5, 6 }
const difference = new Set([...a].filter(x => !b.has(x)));  // { 1, 2 }
```

## Porównanie struktur

| Struktura | Contains | Duplikaty | Kolejność | Kiedy |
|-----------|----------|-----------|-----------|-------|
| `List<T>` | O(n) | tak | zachowana | kolejność ważna, mało Contains |
| `HashSet<T>` | O(1) avg | nie | brak | szybkie Contains, unikalność |
| `Dictionary<K,V>` | O(1) avg | nie (klucze) | brak | klucz → wartość |
| `SortedSet<T>` | O(log n) | nie | posortowana | unikalność + kolejność |
