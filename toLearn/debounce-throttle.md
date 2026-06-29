# Debounce i Throttle

Obie techniki służą do **ograniczania liczby wywołań funkcji** w czasie — szczególnie przy zdarzeniach, które mogą triggerować się bardzo często (scroll, resize, input, mousemove).

---

## Debounce

**Zasada:** wywołaj funkcję dopiero po tym, gdy przez X ms nie pojawił się nowy trigger. Każdy nowy trigger resetuje odliczanie.

**Analogia:** wyszukiwarka — nie chcesz strzelać requestem do API po każdej wpisanej literze, tylko gdy użytkownik skończy pisać.

```js
function debounce(fn, delay) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => fn(...args), delay);
  };
}

const onSearch = debounce((query) => fetchResults(query), 300);
input.addEventListener('input', (e) => onSearch(e.target.value));
// request pójdzie dopiero 300ms po ostatnim keystroke
```

**Kiedy używać:** wyszukiwanie live, autosave, walidacja formularza po wpisaniu.

---

## Throttle

**Zasada:** wywołaj funkcję maksymalnie raz na X ms — niezależnie od tego ile razy trigger się pojawił w tym czasie.

**Analogia:** scroll handler — chcesz aktualizować pozycję co 100ms, nie 60 razy na sekundę.

```js
function throttle(fn, interval) {
  let lastCall = 0;
  return (...args) => {
    const now = Date.now();
    if (now - lastCall >= interval) {
      lastCall = now;
      fn(...args);
    }
  };
}

const onScroll = throttle(() => updateNavbar(), 100);
window.addEventListener('scroll', onScroll);
// updateNavbar wykona się max raz na 100ms
```

**Kiedy używać:** scroll, resize, mousemove, rate limiting kliknięć przycisku.

---

## Porównanie

| | Debounce | Throttle |
|---|----------|----------|
| Wywołanie | Po przerwie w triggerach | Co stały interwał |
| Gdy user nie przestaje | Funkcja się nie wykona | Wykona się co X ms |
| Przypadek użycia | Search input, autosave | Scroll, resize, mousemove |

---

## Połączenie z Closures

Obie funkcje to fabryki zwracające closure — wewnętrzna funkcja "zamknęła w sobie" zmienną `timer` / `lastCall`, która persystuje między wywołaniami. To klasyczny przykład praktycznego zastosowania closures.

---

## W Angular

Angular ma wbudowany `debounceTime` z RxJS:

```ts
this.searchControl.valueChanges.pipe(
  debounceTime(300),
  distinctUntilChanged(),
  switchMap(query => this.api.search(query))
).subscribe(results => this.results = results);
```
