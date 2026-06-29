# Queue

## Co to jest

Queue (kolejka) to struktura danych działająca na zasadzie **FIFO** — First In, First Out. Pierwszy dodany element jest pierwszym do zabrania.

Analogia: kolejka w sklepie — wchodzisz na końcu, wychodzisz z przodu.

## Operacje i złożoność

| Operacja | Złożoność | Opis |
|----------|-----------|------|
| `Enqueue` | O(1) | dodaj na koniec |
| `Dequeue` | O(1) | zdejmij z początku |
| `Peek` | O(1) | podejrzyj początek bez zdejmowania |
| `Contains` | O(n) | szukanie liniowe |

## C# — `Queue<T>`

```csharp
var queue = new Queue<string>();

queue.Enqueue("pierwsze");
queue.Enqueue("drugie");
queue.Enqueue("trzecie");

queue.Peek();    // "pierwsze" — nie usuwa
queue.Dequeue(); // "pierwsze" — usuwa
queue.Dequeue(); // "drugie"
// queue: ["trzecie"]
```

## JavaScript

```ts
// JS nie ma wbudowanego Queue — używa się tablicy
const queue: string[] = [];

queue.push("pierwsze");   // enqueue — dodaj na koniec
queue.push("drugie");
queue.shift();            // dequeue — zdejmij z początku → "pierwsze"
queue.shift();            // → "drugie"

// Uwaga: shift() to O(n) — przesuwa wszystkie elementy
// Dla wydajności przy dużych kolejkach użyj biblioteki (np. `denque`)
```

## Kiedy używać

- **Message queue / task queue** — przetwarzanie zadań w kolejności zgłoszenia (np. RabbitMQ, Azure Service Bus)
- **BFS** (przeszukiwanie grafu wszerz) — iteracyjna implementacja
- **Event loop** w JS — task queue i microtask queue to kolejki
- **Print spooler** — dokumenty drukowane w kolejności dodania
- **Rate limiting** — buforowanie requestów

## Przykład — BFS (przeszukiwanie wszerz)

```ts
function bfs(graph: Record<string, string[]>, start: string): string[] {
  const visited: string[] = [];
  const queue: string[] = [start];

  while (queue.length > 0) {
    const node = queue.shift()!;
    if (visited.includes(node)) continue;
    visited.push(node);
    queue.push(...(graph[node] ?? []));
  }

  return visited;
}
```

## Warianty

**`PriorityQueue<T, P>`** (C# .NET 6+) — elementy wychodzą według priorytetu, nie kolejności dodania:

```csharp
var pq = new PriorityQueue<string, int>();
pq.Enqueue("niski", 3);
pq.Enqueue("wysoki", 1);
pq.Enqueue("średni", 2);

pq.Dequeue(); // "wysoki" (priorytet 1 = najwyższy)
pq.Dequeue(); // "średni"
```

**`ConcurrentQueue<T>`** — thread-safe, do użycia w środowiskach wielowątkowych.

## Porównanie z Stack

| | Queue | Stack |
|--|-------|-------|
| Zasada | FIFO | LIFO |
| Dodawanie | na koniec | na szczyt |
| Zabieranie | z początku | ze szczytu |
| Analogia | kolejka w sklepie | stos talerzy |
| Użycie | BFS, task queue | DFS, undo, call stack |
