# Closures

Closure to funkcja, która "zamknęła w sobie" dostęp do zmiennych ze scope'u, w którym została zdefiniowana — nawet jeśli ten scope już nie istnieje (funkcja rodzica zakończyła działanie).

## Podstawowy przykład

```js
function makeCounter() {
  let count = 0;
  return () => ++count; // closure — trzyma referencję do `count`
}

const counter = makeCounter();
counter(); // 1
counter(); // 2
// `count` żyje, bo closure nadal do niej referuje
```

## Dlaczego to działa

JS używa **lexical scoping** — funkcja ma dostęp do zmiennych ze scope'u, w którym *została zdefiniowana*, nie gdzie jest *wywoływana*. Closure to funkcja + referencja do jej zewnętrznego scope'u (tzw. environment).

## Praktyczne zastosowania

**Enkapsulacja stanu:**
```js
function createUser(name) {
  let loginCount = 0;
  return {
    login: () => { loginCount++; console.log(`${name} zalogowany ${loginCount}x`); },
    getCount: () => loginCount
  };
}
```

**Fabryka funkcji:**
```js
const multiply = (x) => (y) => x * y;
const double = multiply(2);
double(5); // 10
```

**Debounce / throttle** — patrz `debounce-throttle.md`

## Pułapka — closure w pętli

```js
// Błąd (var):
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0); // 3, 3, 3
}

// Poprawnie (let tworzy nowy scope per iteracja):
for (let i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0); // 0, 1, 2
}
```

## Analogia do C#

W C# closures działają tak samo przy lambda expressions:
```csharp
int count = 0;
Action increment = () => count++; // lambda zamknęła count
increment();
increment();
Console.WriteLine(count); // 2
```
