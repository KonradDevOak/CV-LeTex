# Stack

## Co to jest

Stack (stos) to struktura danych działająca na zasadzie **LIFO** — Last In, First Out. Ostatni dodany element jest pierwszym do zabrania.

Analogia: stos talerzy — kładziesz na górze, zdejmujesz z góry.

## Operacje i złożoność

| Operacja | Złożoność | Opis |
|----------|-----------|------|
| `Push` | O(1) | dodaj na szczyt |
| `Pop` | O(1) | zdejmij ze szczytu |
| `Peek` | O(1) | podejrzyj szczyt bez zdejmowania |
| `Contains` | O(n) | szukanie liniowe |

## C# — `Stack<T>`

```csharp
var stack = new Stack<int>();

stack.Push(1);
stack.Push(2);
stack.Push(3);

stack.Peek(); // 3 — nie usuwa
stack.Pop();  // 3 — usuwa
stack.Pop();  // 2
// stack: [1]
```

## JavaScript

```ts
// JS nie ma wbudowanego Stack — używa się tablicy
const stack: number[] = [];

stack.push(1);
stack.push(2);
stack.push(3);

stack[stack.length - 1]; // 3 — peek
stack.pop();             // 3
stack.pop();             // 2
```

## Kiedy używać

- **Call stack** — JS/C# używa stosu do śledzenia wywołań funkcji
- **Cofanie operacji (Undo)** — każda akcja ląduje na stosie, Ctrl+Z zdejmuje
- **Parsowanie wyrażeń** — np. sprawdzanie poprawności nawiasów `()[]{}`
- **Nawigacja wstecz** — historia w przeglądarce (Back button)
- **DFS** (przeszukiwanie grafu w głąb) — iteracyjna implementacja

## Przykład — sprawdzanie nawiasów

```ts
function isBalanced(s: string): boolean {
  const stack: string[] = [];
  const pairs: Record<string, string> = { ')': '(', ']': '[', '}': '{' };

  for (const char of s) {
    if ('([{'.includes(char)) {
      stack.push(char);
    } else if (char in pairs) {
      if (stack.pop() !== pairs[char]) return false;
    }
  }

  return stack.length === 0;
}

isBalanced('([{}])'); // true
isBalanced('([)]');   // false
```

## Porównanie z Queue

| | Stack | Queue |
|--|-------|-------|
| Zasada | LIFO | FIFO |
| Dodawanie | na szczyt | na koniec |
| Zabieranie | ze szczytu | z początku |
| Analogia | stos talerzy | kolejka w sklepie |
