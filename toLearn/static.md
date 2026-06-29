# `static` w TypeScript / JavaScript

## Co oznacza

Składowa oznaczona jako `static` należy do **klasy**, nie do jej instancji. Nie potrzebujesz tworzyć obiektu, żeby jej użyć.

```ts
class Counter {
  static count = 0;       // należy do klasy
  name: string;           // należy do instancji

  constructor(name: string) {
    this.name = name;
    Counter.count++;       // dostęp przez nazwę klasy, nie `this`
  }

  static reset() {
    Counter.count = 0;
  }
}

const a = new Counter('a');
const b = new Counter('b');

console.log(Counter.count); // 2 — współdzielone przez wszystkie instancje
Counter.reset();
console.log(Counter.count); // 0
```

## Instancja vs static — różnica

```ts
class MathHelper {
  static PI = 3.14159;

  static square(x: number): number {
    return x * x;
  }
}

MathHelper.square(5);  // 25 — wywołanie bez new
MathHelper.PI;         // 3.14159

// new MathHelper().square(5); // błąd — metoda statyczna nie istnieje na instancji
```

## Porównanie z C#

`static` w TS/JS działa identycznie jak w C#:

| | TypeScript | C# |
|--|------------|-----|
| Właściwość statyczna | `static count = 0` | `static int Count = 0;` |
| Metoda statyczna | `static create() {}` | `static void Create() {}` |
| Dostęp | `ClassName.member` | `ClassName.Member` |
| Bez instancji | tak | tak |
| Współdzielone | tak (jedna kopia) | tak (jedna kopia) |

```csharp
// C# — identyczna koncepcja
public class Counter
{
    public static int Count = 0;

    public Counter() => Count++;

    public static void Reset() => Count = 0;
}

Counter c1 = new Counter();
Counter c2 = new Counter();
Console.WriteLine(Counter.Count); // 2
```

## Kiedy używać `static`

- **Utility / helper methods** — funkcje narzędziowe niezależne od stanu instancji (`MathHelper.square`)
- **Factory methods** — alternatywny konstruktor (`User.fromJson(data)`)
- **Stałe / konfiguracja** — wartości współdzielone przez całą aplikację (`Config.API_URL`)
- **Singleton** — jedna instancja na całą aplikację

```ts
class Config {
  static readonly API_URL = 'https://api.example.com';
  static readonly TIMEOUT = 5000;
}

class UserService {
  static fromJson(json: unknown): UserService {
    // factory method — alternatywny konstruktor
    const data = UserSchema.parse(json);
    return new UserService(data.id, data.name);
  }

  constructor(private id: number, private name: string) {}
}
```

## Czego NIE robić

```ts
class Utils {
  static add(a: number, b: number) { return a + b; }
  static subtract(a: number, b: number) { return a - b; }
  // klasa używana tylko jako namespace — w TS lepiej użyć module (zwykłe funkcje eksportowane)
}

// Lepiej:
export function add(a: number, b: number) { return a + b; }
export function subtract(a: number, b: number) { return a - b; }
```

Klasa z samymi statycznymi metodami to w JS/TS antywzorzec — lepiej po prostu wyeksportować funkcje z modułu.

## `static` a `this`

Wewnątrz metody statycznej `this` odnosi się do **klasy**, nie do instancji:

```ts
class Animal {
  static type = 'unknown';

  static describe() {
    console.log(this.type); // `this` = Animal (klasa)
  }
}

class Dog extends Animal {
  static type = 'dog';
}

Dog.describe(); // 'dog' — this wskazuje na Dog, nie Animal
```
