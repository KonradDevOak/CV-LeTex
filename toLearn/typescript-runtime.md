# TypeScript — type safety w runtime

## Kluczowa zasada

**TypeScript działa TYLKO na etapie kompilacji. W runtime nie istnieje.**

Typy są wymazywane podczas transpilacji do JS (tzw. *type erasure*). Przeglądarka / Node.js nigdy nie widzi typów — wykonuje czysty JavaScript.

## Przykład

```ts
// TypeScript (kompilacja):
function greet(name: string): string {
  return `Hello, ${name}`;
}

// JavaScript po kompilacji (runtime):
function greet(name) {
  return `Hello, ${name}`;
}
```

Typy znikły całkowicie.

## Błąd, który można popełnić

```ts
const x: number = "hello" as unknown as number;
console.log(x.toFixed(2)); // runtime error: x.toFixed is not a function
```

TS nie zaprotestuje po `as unknown as number`. W runtime `x` to string — crash.

## Kiedy to ma znaczenie

Dane z zewnątrz (API, localStorage, user input) **nie są typowane w runtime** — TS tylko "wierzy" twojej deklaracji.

```ts
// TS myśli że response jest typu User — ale to tylko deklaracja
const response = await fetch('/api/user');
const user: User = await response.json(); // może przyjść cokolwiek
```

## Jak zapewnić bezpieczeństwo w runtime

**Opcja 1 — Zod (walidacja schema):**
```ts
import { z } from 'zod';

const UserSchema = z.object({
  id: z.number(),
  name: z.string(),
});

// typ User jest wyprowadzany z schematu — nie trzeba deklarować dwa razy
type User = z.infer<typeof UserSchema>; // { id: number; name: string }

const user = UserSchema.parse(await response.json()); // rzuca błąd jeśli dane nie pasują
// user jest teraz typu User — TS to wie, i mamy gwarancję w runtime
```

**Opcja 2 — Type guard:**
```ts
interface User {
  id: number;
  name: string;
}

function isUser(obj: unknown): obj is User {
  return (
    typeof obj === 'object' &&
    obj !== null &&
    typeof (obj as any).id === 'number' &&
    typeof (obj as any).name === 'string'
  );
}

const data: unknown = await response.json();
if (isUser(data)) {
  console.log(data.name); // TS wie że data to User
}
```

**Opcja 3 — `typeof` / `instanceof`:**
```ts
if (typeof value === 'string') { /* ... */ }
if (value instanceof Date) { /* ... */ }
```

---

## `z.infer` vs TypeScript `typeof` — różnica

`z.infer` istnieje tylko w Zodzie. Bez Zoda TypeScript oferuje wbudowany operator `typeof`, który wyprowadza typ z istniejącej **wartości** (obiektu, stałej, klasy):

```ts
// Definiujesz wartość (stała lub klasa)
const userDefaults = {
  id: 0 as number,
  name: '' as string,
};

// Wyprowadzasz typ z wartości
type User = typeof userDefaults; // { id: number; name: string }

// Możesz użyć tego typu normalnie
const user: User = { id: 1, name: 'Konrad' };
```

**Kiedy to przydatne:** gdy masz już obiekt konfiguracyjny lub stałą i chcesz na jej podstawie stworzyć typ — bez duplikowania struktury.

**Ograniczenie:** `typeof` na wartości to tylko kompilacja — nie daje walidacji w runtime. Do tego nadal potrzebujesz type guarda (Opcja 2) lub Zoda (Opcja 1).

```ts
// Porównanie:
type UserFromZod = z.infer<typeof UserSchema>; // typ z walidatora runtime (Zod)
type UserFromValue = typeof userDefaults;       // typ z plain obiektu (tylko kompilacja)
```

## Odpowiedź na rozmowie

> "Czy TypeScript zapewnia bezpieczeństwo typów w runtime?"

**Nie.** TS to nadzbiór JS działający tylko na etapie kompilacji — typy są wymazywane (type erasure). W runtime nie ma żadnego mechanizmu TS. Jeśli potrzebuję walidacji danych w runtime, używam Zod albo własnych type guardów.
