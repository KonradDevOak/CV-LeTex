# Event Loop

JavaScript jest jednowątkowy — ma jeden stos wywołań (call stack). Event loop to mechanizm pozwalający wykonywać asynchroniczny kod bez blokowania wątku.

## Jak działa

1. **Call stack** — gdzie wykonuje się synchroniczny kod
2. **Web APIs** — przeglądarka/Node obsługuje async operacje (setTimeout, fetch) poza call stackiem
3. **Task queue (macrotask)** — callbacki gotowe do wykonania (`setTimeout`, `setInterval`, I/O)
4. **Microtask queue** — Promise `.then`, `queueMicrotask` — wyższy priorytet niż task queue

**Event loop sprawdza:** gdy call stack jest pusty → opróżnij całą microtask queue → weź jeden macrotask → powtórz.

## Przykład

```js
console.log('1');
setTimeout(() => console.log('2'), 0);
Promise.resolve().then(() => console.log('3'));
console.log('4');
// Output: 1, 4, 3, 2
```

Wyjaśnienie:
- `1` i `4` — synchronicznie na call stacku
- `3` — microtask (Promise), wykonany przed macrotaskiem
- `2` — macrotask (setTimeout), ostatni

## Dlaczego to ważne

- Wyjaśnia dlaczego `async/await` nie blokuje UI
- Wyjaśnia kolejność wykonania w złożonym kodzie async
- `await` to "sugar" na Promise — wszystko po `await` trafia do microtask queue

## Pytanie na rozmowie

> "Dlaczego setTimeout z delay 0 nie wykonuje się natychmiast?"

Bo callback trafia do task queue — event loop może go zabrać dopiero gdy call stack jest pusty i microtask queue opróżniona.
