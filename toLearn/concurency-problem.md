# .NET Concurrency Problems and Choosing the Right Data Structures

## Overview

When discussing concurrency in .NET, the most important skill is not memorizing classes such as `ConcurrentDictionary` or `ConcurrentQueue`, but understanding:

1. What concurrency problem exists.
2. What guarantees are required.
3. Which data structure or synchronization mechanism solves it.

---

# Common Concurrency Problems

## 1. Race Condition

A race condition occurs when multiple threads access and modify shared state simultaneously, causing unpredictable results.

### Example

```csharp
int counter = 0;

Parallel.For(0, 1000, _ =>
{
    counter++;
});
```

Expected:

```text
1000
```

Actual:

```text
843
912
997
```

### Why?

`counter++` is not atomic.

It is effectively:

```csharp
var temp = counter;
temp++;
counter = temp;
```

Multiple threads may read the same value before writing it back.

### Solutions

- `lock`
- `Interlocked`
- Concurrent collections
- Immutable data structures

---

## 2. Lost Update

A specific type of race condition where one update overwrites another.

### Example

Initial balance:

```text
100
```

Thread A:

```text
+50
```

Thread B:

```text
-20
```

Expected:

```text
130
```

Possible result:

```text
80
```

One update gets lost because both threads worked on stale data.

---

## 3. Check-Then-Act

A thread checks a condition and then performs an action.

Another thread changes the state between those operations.

### Example

```csharp
if (!dictionary.ContainsKey(key))
{
    dictionary.Add(key, value);
}
```

Two threads may both see that the key does not exist.

Result:

```text
ArgumentException
```

### Solution

Use atomic operations:

```csharp
dictionary.GetOrAdd(key, value);
```

---

## 4. Enumeration While Modifying

One thread enumerates a collection while another modifies it.

### Example

```csharp
foreach (var item in list)
{
}
```

Meanwhile:

```csharp
list.Add(newItem);
```

Result:

```text
Collection was modified; enumeration operation may not execute.
```

### Solutions

- Locking
- Snapshot copies
- Immutable collections
- Concurrent collections

---

## 5. Deadlock

Two or more threads wait forever for each other.

### Example

Thread A:

```csharp
lock(lock1)
{
    lock(lock2)
    {
    }
}
```

Thread B:

```csharp
lock(lock2)
{
    lock(lock1)
    {
    }
}
```

Each thread waits for a lock held by the other.

### Prevention

- Consistent lock ordering
- Minimize lock scope
- Use lock-free approaches when possible

---

## 6. Starvation

A thread never gets access to a resource because other threads continuously consume it.

### Example

- High-priority tasks monopolizing CPU
- Worker threads never getting scheduled

---

## 7. Thread Pool Exhaustion

A common issue in ASP.NET applications.

### Example

```csharp
Task.Run(...)
    .Wait();
```

or

```csharp
var result = task.Result;
```

Blocking worker threads can eventually exhaust the thread pool.

### Preferred Approach

Always use async/await:

```csharp
await task;
```

---

# Thread-Safe Collections in .NET

Namespace:

```csharp
System.Collections.Concurrent
```

---

# ConcurrentDictionary<TKey, TValue>

Thread-safe key/value storage.

### Use Cases

- Caching
- Session management
- Subscriber registries
- Shared application state

### Example

```csharp
ConcurrentDictionary<string, User>
```

### Important Methods

#### GetOrAdd

```csharp
dictionary.GetOrAdd(key, value);
```

Atomically:

1. Checks whether the key exists.
2. Creates the value if necessary.

---

#### AddOrUpdate

```csharp
dictionary.AddOrUpdate(
    key,
    1,
    (_, current) => current + 1);
```

Useful for counters.

---

#### TryRemove

```csharp
dictionary.TryRemove(key, out _);
```

Thread-safe removal.

---

#### TryUpdate

```csharp
dictionary.TryUpdate(
    key,
    newValue,
    oldValue);
```

Compare-and-swap semantics.

---

# ConcurrentQueue<T>

Thread-safe FIFO collection.

FIFO = First In, First Out.

### Use Cases

- Work queues
- Message queues
- Producer/Consumer systems

### Example

```csharp
queue.Enqueue(item);

queue.TryDequeue(out var item);
```

---

# ConcurrentStack<T>

Thread-safe LIFO collection.

LIFO = Last In, First Out.

### Use Cases

- Undo systems
- DFS algorithms
- Temporary work stacks

---

# ConcurrentBag<T>

Thread-safe unordered collection.

### Characteristics

- No guaranteed ordering
- Fast additions
- Optimized for scenarios where producers and consumers are often the same thread

### Use Cases

- Event handlers
- Gathering results
- Temporary collections

### Example

```csharp
ConcurrentBag<Func<T, Task>>
```

---

# Immutable Collections

Namespace:

```csharp
System.Collections.Immutable
```

Examples:

```csharp
ImmutableArray<T>
ImmutableList<T>
ImmutableDictionary<TKey,TValue>
```

---

## Why Immutable Collections?

Instead of modifying existing data:

```csharp
list.Add(item);
```

Create a new version:

```csharp
list = list.Add(item);
```

Existing readers are unaffected.

### Benefits

- Naturally thread-safe
- No locking required for reads
- Ideal for configuration and subscriptions

---

# Synchronization Mechanisms

---

## lock

### Example

```csharp
private readonly object _lock = new();

lock(_lock)
{
    // critical section
}
```

### Use When

- Shared mutable state
- Short critical sections

### Avoid

- Long-running operations
- Awaiting inside a lock

---

## Interlocked

Atomic operations without locking.

### Example

```csharp
Interlocked.Increment(ref counter);
```

### Operations

```csharp
Increment
Decrement
Exchange
CompareExchange
Add
```

Use when updating simple numeric values.

---

## SemaphoreSlim

Limits concurrency.

### Example

```csharp
private readonly SemaphoreSlim _semaphore = new(5);
```

Only 5 operations can execute simultaneously.

Useful for:

- API throttling
- Rate limiting
- Resource pools

---

# Channels (Modern Producer/Consumer)

Namespace:

```csharp
System.Threading.Channels
```

Channels are often preferred over `ConcurrentQueue`.

---

## Creating a Channel

```csharp
var channel = Channel.CreateUnbounded<string>();
```

Writing:

```csharp
await channel.Writer.WriteAsync(message);
```

Reading:

```csharp
var message = await channel.Reader.ReadAsync();
```

---

## Advantages over ConcurrentQueue

- Built-in async support
- Backpressure
- Better producer/consumer coordination
- No polling required

---

# Mapping Patterns to Data Structures

---

## Cache

Recommended:

```csharp
ConcurrentDictionary<TKey,TValue>
```

---

## Producer / Consumer

Recommended:

```csharp
Channel<T>
```

Alternative:

```csharp
ConcurrentQueue<T>
```

---

## Message Queue

Recommended:

```csharp
Channel<T>
```

---

## Event Bus

Simple:

```csharp
ConcurrentBag<Handler>
```

Better:

```csharp
ImmutableArray<Handler>
```

With unsubscribe support:

```csharp
ConcurrentDictionary<Guid, Handler>
```

---

## Subscriber Registry

Recommended:

```csharp
ConcurrentDictionary<Guid, Subscriber>
```

---

## Configuration Storage

Recommended:

```csharp
ImmutableDictionary<TKey,TValue>
```

---

## Counters

Recommended:

```csharp
Interlocked
```

Example:

```csharp
Interlocked.Increment(ref counter);
```

---

# Async Publish/Subscribe Design Example

Requirements:

- Multiple subscribers
- Parallel execution
- Thread-safe registration
- Exception isolation

A good solution:

```csharp
public class AsyncBus<TMessage>
{
    private readonly ConcurrentDictionary<Guid, Func<TMessage, Task>> _handlers = new();

    public Guid Subscribe(Func<TMessage, Task> handler)
    {
        var id = Guid.NewGuid();
        _handlers[id] = handler;
        return id;
    }

    public void Unsubscribe(Guid id)
    {
        _handlers.TryRemove(id, out _);
    }

    public async Task PublishAsync(TMessage message)
    {
        var tasks = _handlers.Values.Select(async handler =>
        {
            try
            {
                await handler(message);
            }
            catch
            {
                // log and continue
            }
        });

        await Task.WhenAll(tasks);
    }
}
```

---

# Interview Cheat Sheet

| Problem | Recommended Solution |
|----------|----------|
| Shared counter | Interlocked |
| Shared mutable state | lock |
| Cache | ConcurrentDictionary |
| FIFO queue | ConcurrentQueue |
| Modern async queue | Channel |
| LIFO stack | ConcurrentStack |
| Unordered collection | ConcurrentBag |
| Read-heavy shared data | Immutable Collections |
| Event Bus | ImmutableArray or ConcurrentDictionary |
| Subscriber Registry | ConcurrentDictionary |
| Rate limiting | SemaphoreSlim |

---

# Senior-Level Thinking

A senior engineer should think:

1. What concurrency problem exists?
2. Is mutation necessary?
3. Can immutable data solve it?
4. Is ordering required?
5. Is key-based lookup required?
6. Is asynchronous coordination required?
7. What are the performance characteristics?
8. What failure scenarios must be handled?

The goal is not to know every class in .NET, but to understand the concurrency problem and choose the simplest structure that provides the required guarantees.