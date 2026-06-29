# Stos (Stack) vs Sterta (Heap) — pamięć

> Uwaga: to NIE jest `Stack<T>` jako struktura danych — to dwa różne obszary pamięci w procesie.

## Stos (Stack)

- Pamięć zarządzana **automatycznie** przez runtime
- Działa LIFO — każde wywołanie funkcji odkłada **ramkę stosu** (stack frame) z lokalnymi zmiennymi i adresem powrotu
- **Szybki** — alokacja to przesunięcie wskaźnika stosu
- **Ograniczony rozmiar** — przekroczenie to `StackOverflowException`
- Przechowuje: typy wartościowe (value types), referencje do obiektów, parametry funkcji

## Sterta (Heap)

- Pamięć zarządzana przez **Garbage Collector** (GC)
- Dynamiczna alokacja — obiekty żyją dopóki istnieje do nich referencja
- **Wolniejszy** dostęp — alokacja wymaga znalezienia wolnego miejsca + GC musi śledzić obiekty
- **Nieograniczony** (w praktyce: do RAM)
- Przechowuje: typy referencyjne (obiekty, tablice, stringi, klasy)

## C# — co gdzie trafia

```csharp
void Method()
{
    int x = 5;              // stos — value type
    bool flag = true;       // stos — value type

    var user = new User();  // referencja `user` — stos
                            // obiekt User — sterta

    var list = new List<int>(); // referencja — stos, obiekt List — sterta
}
// po wyjściu z metody: stos automatycznie zwalniany
// obiekty na stercie: GC sprząta gdy brak referencji
```

## Value type vs Reference type

| | Value type | Reference type |
|--|------------|----------------|
| Gdzie | stos (lokalnie) | sterta |
| Przykłady C# | `int`, `bool`, `struct`, `enum` | `class`, `string`, `array`, `interface` |
| Kopiowanie | kopia wartości | kopia referencji (oba wskazują na ten sam obiekt) |

```csharp
// Value type — kopia:
int a = 5;
int b = a;
b = 10;
Console.WriteLine(a); // 5 — a bez zmian

// Reference type — ta sama referencja:
var list1 = new List<int> { 1, 2, 3 };
var list2 = list1;
list2.Add(4);
Console.WriteLine(list1.Count); // 4 — list1 też zmodyfikowana
```

## JavaScript

JS ukrywa ten podział, ale zasada jest ta sama:

- **Prymitywy** (`number`, `string`, `boolean`, `null`, `undefined`, `symbol`) — zachowują się jak value types (kopiowanie przez wartość)
- **Obiekty, tablice, funkcje** — referencje, dane na stercie

```ts
let a = 5;
let b = a;
b = 10;
console.log(a); // 5 — kopia wartości

const obj1 = { x: 1 };
const obj2 = obj1;
obj2.x = 99;
console.log(obj1.x); // 99 — ta sama referencja
```

## StackOverflow — co to znaczy

Rekurencja bez warunku stopu zapełnia stos kolejnymi ramkami, aż zabraknie miejsca:

```csharp
void Infinite() => Infinite(); // StackOverflowException
```

```ts
function infinite(): void { infinite(); } // Maximum call stack size exceeded
```

## Pytanie na rozmowie

> "Czym różni się stos od sterty?"

Stos to szybki obszar pamięci zarządzany automatycznie — trzyma lokalne zmienne i ramki wywołań funkcji, zwalniany natychmiast po wyjściu z metody. Sterta to obszar zarządzany przez GC — trzyma obiekty, żyją dopóki istnieje referencja. W C# typy wartościowe (`int`, `struct`) trafiają na stos, typy referencyjne (`class`, tablice) na stertę.
