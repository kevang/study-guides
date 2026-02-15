# Advanced Software Engineering Techniques

## Table of Contents

### Part I: Distributed Systems & Consistency

* [1. Consistent Hashing](#1-consistent-hashing)
* [2. Consensus Algorithms: Raft and Paxos](#2-consensus-algorithms-raft-and-paxos)
* [3. Vector Clocks](#3-vector-clocks)
* [4. Merkle Trees](#4-merkle-trees)
* [5. Gossip Protocols](#5-gossip-protocols)
* [6. CRDTs](#6-crdts)

### Part II: Caching & Performance

* [1. Cache Eviction Algorithms](#1-cache-eviction-algorithms)
* [2. Write Strategies](#2-write-strategies)
* [3. Cache Coherence](#3-cache-coherence)
* [4. CDN Algorithms](#4-cdn-algorithms)

### Part III: Database & Storage

* [1. B-Trees and B+ Trees](#1-b-trees-and-b-trees)
* [2. LSM Trees](#2-lsm-trees)
* [3. MVCC](#3-mvcc)
* [4. Sharding Strategies](#4-sharding-strategies)
* [5. Skip Lists](#5-skip-lists)
* [6. Segment Trees and Fenwick Trees](#6-segment-trees-and-fenwick-trees)

### Part IV: Concurrency & Parallelism

* [1. Lock-Free Data Structures](#1-lock-free-data-structures)
* [2. Actor Model](#2-actor-model)
* [3. MapReduce](#3-mapreduce)
* [4. Work-Stealing Algorithms](#4-work-stealing-algorithms)
* [5. Epoch-Based Reclamation](#5-epoch-based-reclamation)

### Part V: System Design Patterns

* [1. Circuit Breaker](#1-circuit-breaker)
* [2. Bulkhead Pattern](#2-bulkhead-pattern)
* [3. Event Sourcing and CQRS](#3-event-sourcing-and-cqrs)
* [4. Saga Pattern](#4-saga-pattern)

### Part VI: Security & Cryptography

* [1. HMAC](#1-hmac)
* [2. PKI and Certificate Chains](#2-pki-and-certificate-chains)
* [3. Rate Limiting Algorithms](#3-rate-limiting-algorithms)
* [4. Cryptographic Hash Functions](#4-cryptographic-hash-functions)

### Part VII: Optimization & Approximation

* [1. HyperLogLog](#1-hyperloglog)
* [2. Count-Min Sketch](#2-count-min-sketch)
* [3. Locality-Sensitive Hashing](#3-locality-sensitive-hashing)
* [4. Genetic Algorithms](#4-genetic-algorithms)

### Part VIII: Network & Communication

* [1. Load Balancing Algorithms](#1-load-balancing-algorithms)
* [2. Backpressure Handling](#2-backpressure-handling)
* [3. Protocol Buffers](#3-protocol-buffers)

### Part IX: Search & String Algorithms

* [1. Phonetic Algorithms](#1-phonetic-algorithms)
* [2. Rabin-Karp](#2-rabin-karp)
* [3. Aho-Corasick](#3-aho-corasick)
* [4. MinHash and SimHash](#4-minhash-and-simhash)
* [5. BM25](#5-bm25)
* [6. HNSW](#6-hnsw)

---

## Part I: Distributed Systems & Consistency

### 1. Consistent Hashing

Consistent hashing is a distributed hashing scheme that minimizes data movement when nodes are added or removed from a cluster. Traditional hashing maps keys to buckets using `hash(key) mod n`, which requires remapping nearlyn` changes. Consistent hashing maps both all keys when ` keys and nodes to a hash ring, allowing keys to stay assigned to the same node unless that node fails.

**How It Works**

The hash function maps both keys and node identifiers to points on a circular ring (typically 0 to 2^32-1). A key is assigned to the first node encountered when traversing clockwise from the key's position on the ring. When a node fails, only the keys that were assigned to that node need to be redistributed to the next node; all other keys remain unaffected.

**Virtual Nodes**

To improve load distribution, each physical node is represented by multiple virtual nodes on the ring. This helps because if one node receives more traffic, its virtual nodes are spread across the ring, distributing the load more evenly. When a node fails, its load is distributed across multiple successor nodes rather than overwhelming a single node.

**Example Applications**

- **Cassandra** uses consistent hashing for data partitioning across nodes
- **DynamoDB** employs consistent hashing to distribute data across partitions
- **Content Delivery Networks (CDNs)** use consistent hashing to direct requests to the nearest cache

**Trade-offs**

- Adds complexity compared to simple hashing
- Load distribution may not be perfectly uniform without virtual nodes
- Recovery from node failure still requires some data redistribution

---

### 2. Consensus Algorithms: Raft and Paxos

Consensus algorithms enable a cluster of nodes to agree on a value, even when some nodes fail. They are fundamental to building fault-tolerant distributed systems.

#### Paxos

Paxos is the foundational consensus algorithm, proven to achieve safety (nothing bad happens) under asynchronous assumptions. It uses a majority-based approach where a value is chosen when a quorum (majority) of acceptors agree.

**Key Concepts**

- **Proposers**: Nodes that propose values
- **Acceptors**: Nodes that receive and evaluate proposals
- **Learners**: Nodes that learn the chosen value

Paxos proceeds in two phases: prepare (where a proposer learns if a value has already been chosen) and accept (where the proposer tries to get acceptors to accept its proposed value). The requirement for a majority ensures that at most one value can be chosen.

**Practical Considerations**

- Complex to implement correctly
- Difficult to understand and reason about
- Requires careful handling of leader election
- Used in Google Chubby, Zookeeper (originally Zab protocol, influenced by Paxos)

#### Raft

Raft was designed as a more understandable alternative to Paxos. It organizes consensus into three distinct subproblems: leader election, log replication, and safety.

**Key Concepts**

- **Leader**: One node acts as the leader and handles all client requests
- **Log Replication**: The leader appends entries to its log and replicates them to followers
- **Term Numbers**: Logical time periods that help identify stale leaders

**Leader Election**

Nodes start as followers. If a follower doesn't receive a heartbeat from the leader within an election timeout, it becomes a candidate and requests votes from other nodes. If a candidate receives votes from a majority, it becomes the leader. This ensures only one leader per term.

**Log Replication**

Client requests are treated as log entries. The leader appends entries to its log and sends them to followers. Entries are committed once a majority have replicated them. The leader includes the commit index in heartbeats so followers know which entries to apply.

**Why Raft is Popular**

- Easier to understand than Paxos
- Explicit leader semantics simplify reasoning
- Built-in membership changes
- Used in **etcd**, **Consul**, **TiKV**, and **RethinkDB**

---

### 3. Vector Clocks

Vector clocks are a mechanism for tracking causality in distributed systems. They extend logical clocks by maintaining a vector of timestamps, one per node, allowing detection of concurrent events and causal relationships.

**The Problem with Logical Clocks**

Logical clocks (Lamport clocks) assign a partial ordering to events but cannot determine if two events are concurrent. Vector clocks solve this by having each node maintain a vector of logical clocks, one for each node in the system.

**How It Works**

Each node maintains a vector clock `VC`. When an event occurs locally, node `i` increments `VC[i]`. When sending a message, the node includes its vector clock. Upon receiving a message, the node takes the maximum of each component from its local clock and the received clock, then increments its own component.

**Causality Detection**

- If all components of `VC_a` are less than or equal to `VC_b`, then `a` happened before `b`
- If some components are greater and some are less, the events are concurrent
- If neither vector is less than or other, the events are concurrent

**Example Applications**

- **Dynamo** uses vector clocks for conflict resolution
- **Riak** implements vector clocks for eventually consistent data
- **Cassandra** uses a variant (lightweight transactions with PAXOS)

**Trade-offs**

- Memory grows with the number of nodes
- Clock synchronization requires message passing
- Pruning may be needed in long-running systems (e.g., server-wide timestamp buckets)

---

### 4. Merkle Trees

A Merkle tree (hash tree) is a binary tree where each leaf node contains a hash of a data block, and each internal node contains a hash of its children's hashes. This structure enables efficient and secure verification of large data sets.

**How It Works**

1. Hash each data block to create leaf nodes
2. Pair adjacent leaf hashes and hash them together to create parent nodes
3. Continue pairing and hashing until reaching a single root hash (Merkle root)
4. The root hash represents the entire dataset

**Verification Properties**

To verify that a specific data block is part of the tree, you only need O(log n) hashes (the authentication path), rather than the entire dataset. This makes Merkle trees extremely efficient for partial verification.

**Example Applications**

- **Git** uses Merkle trees for content-addressable storage and to detect changes
- **Bitcoin** uses Merkle trees to summarize all transactions in a block, allowing lightweight clients to verify transaction inclusion
- **DynamoDB** and **Cassandra** use Merkle trees for anti-entropy (detecting inconsistencies between replicas)
- **Amazon S3** uses Merkle trees for cross-region replication verification

**Benefits**

- Efficient verification of large datasets
- Can detect differences without comparing all data
- Supports incremental updates when data changes

---

### 5. Gossip Protocols

Gossip protocols are a class of peer-to-peer communication mechanisms where nodes periodically share state with random peers. They achieve eventual consistency without central coordination, making them highly scalable and fault-tolerant.

**How It Works**

1. Each node maintains local state and periodically selects random peers to exchange state
2. On exchange, nodes merge their state using conflict resolution rules
3. Over time, information propagates across the entire cluster (O(log n) rounds)

**Convergence Time**

In a cluster of n nodes, gossip converges in O(log n) rounds with high probability. Each round, each node contacts roughly one peer, giving O(n log n) total messages per round—efficient for large clusters.

**Variants**

- **Push-only**: Nodes only push their state to random peers
- **Pull-only**: Nodes periodically pull state from random peers
- **Push-pull**: Nodes both push their state and pull peer's state (fastest convergence)

**Example Applications**

- **Cassandra** uses gossip for node membership and metadata distribution
- **Consul** uses gossip for cluster membership and distributed failure detection
- **Riak** uses gossip for bucket properties and key metadata
- **DynamoDB** uses gossip-style protocols for cluster state

**Trade-offs**

- Eventual consistency (not strong consistency)
- Can produce redundant messages
-抗 requires tuning of protocol parameters (gossip interval, fanout)

---

### 6. CRDTs

Conflict-free Replicated Data Types (CRDTs) are data structures designed for distributed systems that can be replicated across multiple nodes, modified independently, and merged automatically without coordination—guaranteeing eventual consistency.

**The Problem with Distributed Data**

In distributed systems, network partitions can cause nodes to receive updates in different orders. Traditional approaches require coordination (locking, consensus) which reduces availability. CRDTs provide conflict resolution built into their design.

**Types of CRDTs**

**CmRDT (Operation-based)**: Operations (not state) are exchanged replicas. Each operation between is designed to be commutative.

**CvRDT (State-based)**: Full state is exchanged and merged using a commutative, associative, idempotent merge function.

**Common CRDT Structures**

- **G-Counter**: Grow-only counter (increment only); merge takes max of each component
- **PN-Counter**: Positive-negative counter supporting both increments and decrements
- **LWW-Register**: Last-writer-wins register (timestamp-based conflict resolution)
- **OR-Set**: Observed-Remove Set supporting adds and removes
- **RGA**: Replicated Growable Array for ordered sequences

**Example Applications**

- **Riak** uses CRDTs for counters, sets, and maps
- **Redis CRDT** provides conflict-free data types
- **Automerge** uses CRDT principles for collaborative text editing
- **Yjs** uses CRDTs for real-time collaborative applications

**Benefits**

- No coordination required—highly available during partitions
- Automatic conflict resolution
- Simple reasoning about consistency

**Trade-offs**

- Not all data types have efficient CRDT implementations
- Some structures have unbounded memory growth
- Eventual consistency, not strong consistency

---

## Part II: Caching & Performance

### 1. Cache Eviction Algorithms

Cache eviction algorithms determine which items to remove when capacity is reached. The choice significantly impacts cache hit rates and system performance.

#### LRU (Least Recently Used)

LRU evicts the item that was accessed least recently. It maintains a timestamp or ordering of accesses, discarding the oldest on cache miss when full.

**How It Works**

- On each access, move the item to the most recently used position
- On eviction, remove the least recently used item
- Implementation typically uses a doubly-linked list with a hash map for O(1) access

**Trade-offs**

- Simple and widely used
- Poor performance when access patterns have temporal locality but no repetition
- Can be fooled by sequential scans that don't repeat

#### LFU (Least Frequently Used)

LFU counts how many times each item is accessed and evicts the least frequently used item.

**How It Works**

- Maintain a frequency counter for each cache entry
- On access, increment the counter
- On eviction, remove the item with lowest frequency

**Trade-offs**

- Better than LRU for workloads with power-law access distributions
- Can retain rarely-used but recently-fetched items (the "cache pollution" problem)
- Implementation complexity higher than LRU

#### ARC (Adaptive Replacement Cache)

ARC combines LRU and LFU dynamically, adapting to changing workloads. It maintains four lists: recently used but not repeated (T1), recently repeated but not frequent (T2), recently evicted from T1 (B1), and recently evicted from T2 (B2).

**Trade-offs**

- Superior hit ratio across diverse workloads
- More complex implementation
- Used in **IBM DS8000** storage systems

#### TinyLFU / W-TinyLFU

TinyLFU uses a frequency sketch (approximate counting) to track access frequencies with minimal memory. W-TinyLFU adds a windowed LRU component to protect against cache pollution from one-time accesses.

**How It Works**

- Use a Count-Min sketch to track frequencies across the entire cache
- On potential eviction, compare frequency of the candidate against incoming item
- Maintain a small LRU window for very recent arrivals
- Used in **Caffeine** (Java) and **Guava** caches

**Example Applications**

- **Caffeine** cache library uses W-TinyLFU
- **Guava Cache** uses TinyLFU for approximate frequency tracking

#### CLOCK / CLOCK-Pro

CLOCK is an approximation of LRU with lower overhead. It uses a circular buffer with reference bits—on each access, set the reference bit to 1; on eviction, scan the clock hand and clear bits, evicting the first item with bit 0.

**Trade-offs**

- Nearly LRU-equivalent performance
- O(1) operations without mutation on access
- CLOCK-Pro extends this to include recency awareness

---

### 2. Write Strategies

Write strategies define how updates to cached data are propagated to the underlying data store.

#### Write-Through

All writes go to both cache and database simultaneously. The write is considered complete only when both succeed.

**Trade-offs**

- **Pros**: Data never lost from cache; simple consistency model
- **Cons**: Higher write latency; may write to DB for data never read

**Best For**: Read-heavy workloads where data must be durable

#### Write-Back (Write-Behind)

Writes are written to cache only, with asynchronous write-through to the database. The cache returns success immediately, and background processes flush changes.

**Trade-offs**

- **Pros**: Lower write latency; reduces database load
- **Cons**: Risk of data loss if cache fails before flush; complexity in handling failures

**Best For**: Write-heavy workloads (e.g., logging, analytics); systems that can tolerate some data loss

#### Write-Around

Writes bypass the cache entirely, going directly to the database. The cache is populated only on subsequent reads.

**Trade-offs**

- **Pros**: Minimizes cache pollution from write-heavy data
- **Cons**: First read after write misses cache

**Best For**: Write-heavy workloads where same data rarely read immediately

---

### 3. Cache Coherence

Cache coherence ensures that multiple caches (in multi-core CPUs or distributed caches) maintain a consistent view of data.

#### MESI Protocol

MESI is a common write-invalidate protocol for CPU caches with four states:

- **Modified**: Cache line modified, not in other caches
- **Exclusive**: Cache line present only in this cache, unmodified
- **Shared**: Cache line present in multiple caches, unmodified
- **Invalid**: Cache line not present or stale

**State Transitions**

On a read miss, fetch from memory or another cache. On a write to a shared line, send invalidate to other caches. The line transitions to Modified state.

#### Distributed Cache Coherence

In distributed caching systems (e.g., memcached clusters), coherence is typically handled through:

- **Write invalidation**: On write, invalidate or update cached copies on other nodes
- **Write broadcasting**: Broadcast writes to all relevant nodes
- **Version vectors**: Track which nodes have which version of data

---

### 4. CDN Algorithms

Content Delivery Networks use various algorithms to deliver content efficiently to global users.

#### Request Routing

- **GeoDNS**: Direct users to geographically closest edge server
- **Anycast**: Multiple servers share the same IP; routing infrastructure directs to nearest
- **Least connections**: Direct to server with fewest active connections
- **Weighted routing**: Consider server capacity and load

#### Cache Hierarchies**

Content is cached at multiple levels: origin server, CDN edge servers, ISP proxies. Algorithms determine:

- Which content to cache at which level
- How to invalidate across hierarchies
- How to handle cache misses (origin fetch strategies)

---

## Part III: Database & Storage

### 1. B-Trees and B+ Trees

B-trees are self-balanced tree data structures that maintain sorted data and allow searches, sequential access, insertions, and deletions in logarithmic time. B+ trees are a variant optimized for disk-based storage.

#### B-Tree Properties

- Nodes can have multiple keys and children (typically tens to hundreds)
- All leaf nodes are at the same depth
- Non-leaf nodes store keys that act as separation values
- Tree remains balanced through node splits and merges

#### B+ Tree Optimizations

B+ trees differ from B-trees in that:
- All data (or pointers to data) is stored in leaf nodes only
- Leaf nodes are linked sequentially, enabling efficient range queries
- Non-leaf nodes store only keys (not data), allowing more keys per node

**Example Applications**

- **Virtually all relational databases** use B+ trees for indexes (MySQL InnoDB, PostgreSQL, Oracle)
- **File systems** (NTFS, HFS+) use B+ trees for directory indexing
- **Key-value stores** (LMDB, Berkeley DB) use B+ trees

**Performance Characteristics**

- O(log n) search, insert, delete
- Excellent for range queries (sequential leaf access)
- Cache-friendly due to high fanout (fewer levels)
- Typical fanout of 100-1000 means 3-4 levels for millions of rows

---

### 2. LSM Trees

Log-Structured Merge (LSM) trees are write-optimized data structures that batch writes in memory before flushing to disk in sorted runs. They provide much faster writes than B+ trees at the cost of slower reads.

#### How It Works

1. **Memory Component (Memtable)**: Incoming writes go to an in-memory balanced tree (often skip list)
2. **Immutable SSTables**: When memtable reaches size threshold, it becomes immutable and is flushed to disk as a Sorted String Table (SSTable)
3. **Compaction**: Background processes merge multiple SSTables into larger ones, applying merges (deleting overwritten data, merging keys)

#### Levels and Compaction

**Level-based (L0 to Ln)**: Each level can hold 10x data of the previous. New SSTables start at L0; compaction pushes data to higher levels.

**Size-tiered**: Similar-sized SSTables are merged together, producing larger SSTables.

#### Trade-offs

- **Pros**: Writes are O(1) and sequential (fast); excellent for write-heavy workloads
- **Cons**: Reads must check multiple files; compaction causes background overhead; write amplification

**Example Applications**

- **RocksDB** (Facebook) - embedded key-value store
- **Cassandra** - wide-column NoSQL database
- **LevelDB** (Google) - predecessor to RocksDB
- **HBase** - uses HDFS-backed LSM-like storage

---

### 3. MVCC

Multi-Version Concurrency Control allows databases to provide concurrent access while maintaining consistency. Instead of locking rows, each transaction sees a snapshot of the database at a point in time.

#### How It Works

- Each row has additional metadata: transaction ID and pointer to previous version
- On update, create new version instead of overwriting
- On delete, mark as deleted rather than removing
- Old versions are garbage collected when no longer needed

#### Snapshot Isolation

A transaction sees all commits that existed when the transaction started. This prevents dirty reads and non-repeatable reads without requiring read locks.

#### Implementation Details

- **PostgreSQL** uses MVCC with a dedicated system column (ctid) and transaction IDs
- **MySQL InnoDB** uses roll pointers and undo logs
- **Oracle** uses undo segments for MVCC
- **SQLite** uses rollback journals (write-ahead logging is also supported)

#### Trade-offs

- **Pros**: Readers never block writers; strong isolation guarantees
- **Cons**: Storage overhead; requires garbage collection; more complex vacuum/cleanup

---

### 4. Sharding Strategies

Database sharding horizontally partitions data across multiple databases or servers, enabling horizontal scaling.

#### Sharding Keys

The shard key determines how data is distributed:

- **Range-based**: Consecutive key ranges go to same shard (e.g., users A-G on shard 1)
- **Hash-based**: Hash of key modulo number of shards
- **Directory-based**: Lookup service maps keys to shards (flexible but adds latency)

#### Challenges

- **Cross-shard queries**: Joins and transactions become complex
- **Resharding**: Adding shards requires data migration
- **Hot spots**: Some keys may receive more traffic

#### Strategies in Practice

- **Application-level sharding**: Application handles routing (e.g., Vitess for MySQL)
- **Database-native sharding**: Database handles distribution (e.g., CockroachDB, YugabyteDB)
- **Proxy-based**: Sharding handled by middleware (e.g., ShardingSphere)

---

### 5. Skip Lists

Skip lists are probabilistic data structures that allow O(log n) average-case search, insertion, and deletion. They serve as an alternative to balanced trees with simpler implementation.

#### How It Works

A skip list is a multi-level linked list where:
- Bottom level contains all elements in sorted order
- Higher levels act as "express lanes" with sparser elements
- Each element appears in multiple levels with exponentially decreasing probability

#### Search

To find an element, start at the highest level and move forward as long as the next element is less than target, then drop down. Average O(log n) comparisons.

#### Probabilistic Balance

Unlike tree rebalancing (rotations), skip lists maintain balance probabilistically. With random height assignment, the structure tends toward balance.

**Example Applications**

- **Redis** sorted sets use skip lists internally
- **LevelDB** uses skip lists in its MemTable
- **Lucene** uses skip lists for term index acceleration
- **HBase** uses skip lists in some components

**Trade-offs**

- Simpler implementation than balanced trees
- Slightly higher memory overhead (multiple pointers)
- O(log n) expected but O(n) worst case (very unlikely)

---

### 6. Segment Trees and Fenwick Trees

Both data structures enable efficient range queries and updates, commonly used in competitive programming and stream processing.

#### Segment Tree

A segment tree is a binary tree where each node represents a range. Leaf nodes represent individual elements; internal nodes represent merged information (sum, min, max) of their children's ranges.

**Operations**

- Build: O(n)
- Query range: O(log n)
- Update point: O(log n)
- Update range: O(log n) with lazy propagation

#### Fenwick Tree (Binary Indexed Tree)

A Fenwick tree uses a clever binary representation of indices to achieve the same O(log n) operations with less memory than a segment tree.

**Operations**

- Prefix sum query: O(log n)
- Point update: O(log n)
- Range sum: O(log n) via two prefix queries

**Example Applications**

- **Competitive programming**: Range sum queries, frequency counting
- **Analytics systems**: Streaming percentile computation
- **Game development**: Efficient terrain/collision queries
- **Stock trading systems**: Price range queries

---

## Part IV: Concurrency & Parallelism

### 1. Lock-Free Data Structures

Lock-free data structures use atomic operations (compare-and-swap, fetch-and-add) instead of locks, enabling multiple threads to operate concurrently without blocking.

#### Compare-And-Swap (CAS)

CAS atomically compares a memory location with an expected value and, if equal, swaps it with a new value. Returns whether the swap succeeded.

```python
# Conceptual CAS operation
def compare_and_swap(location, expected, new):
    atomic:
        if location.value == expected:
            location.value = new
            return True
        return False
```

#### Lock-Free Queue (Michael-Scott Queue)

A common lock-free queue uses CAS to atomically enqueue at the tail and dequeue from the head. The key insight is using a dummy node to simplify boundary conditions.

#### Challenges

- **ABA problem**: A location changes from A to B and back to A; CAS sees no change but state may have been modified. Solution: tagged pointers or tagged CAS.
- **Memory reclamation**: When is it safe to free removed nodes? (Epoch-based reclamation addresses this)
- **Complexity**: Lock-free algorithms are notoriously difficult to implement correctly

**Example Applications**

- **Java ConcurrentLinkedQueue**: Lock-free queue implementation
- **Disruptor** (LMAX): High-performance inter-thread messaging
- **Rust crossbeam**: Lock-free data structures

---

### 2. Actor Model

The actor model is a concurrency paradigm where actors are independent entities that communicate exclusively through asynchronous messages. Each actor has private state and processes one message at a time.

#### Core Principles

- **Encapsulation**: Actor state is private; only accessible via messages
- **No shared state**: Actors don't share memory; each has its own mailbox
- **Asynchronous messaging**: Senders don't wait for response; responses are separate messages
- **Location transparency**: Actors can be local or remote without code changes

#### Failure Handling

Actors can supervise child actors and define failure policies (restart, escalate, stop). This creates fault-tolerant hierarchies.

**Example Applications**

- **Akka** (Scala/Java): Distributed actor framework
- **Erlang/OTP**: Original actor language; used in WhatsApp, Ericsson
- **Elixir**: Erlang VM-based language
- ** Orleans** (Microsoft): Virtual actors for distributed computing
- **Phoenix Channels**: WebSocket handling in Elixir

---

### 3. MapReduce

MapReduce is a programming model for processing large datasets in parallel across distributed machines. It consists of two phases:

#### Map Phase

Input data is divided into chunks. A map function processes each chunk and emits key-value pairs:

```
map(key1, value1) -> list(key2, value2)
```

#### Reduce Phase

All values for each key are collected together. A reduce function combines these values:

```
reduce(key2, list(value2)) -> list(value3)
```

#### Execution Flow

1. Input split into chunks (typically 64-128MB)
2. Map tasks run on nodes with data locality
3. Output partitioned to Reducer nodes (shuffle phase)
4. Reducer tasks process sorted intermediate data
5. Output written to distributed filesystem

#### Word Count Example

```
Map: "hello world" -> ("hello",1), ("world",1)
Shuffle: groups values by key
Reduce: ("hello", [1,1]) -> ("hello", 2)
```

**Example Applications**

- **Hadoop MapReduce**: Original open-source implementation
- **Apache Spark**: In-memory MapReduce successor
- **Google MapReduce**: Original paper (2004)
- **MongoDB**: Map-reduce for aggregation

---

### 4. Work-Stealing Algorithms

Work-stealing is a scheduling paradigm where threads with idle work take tasks from other threads' queues. It balances load dynamically without central coordination.

#### How It Works

1. Each thread has its own deque of tasks
2. When a thread's deque is empty, it "steals" from the bottom of another random thread's deque
3. This provides good load balance with minimal synchronization (only the victim deque is locked)

#### Implementation

- **Cilk** (C runtime): First popular work-stealing scheduler
- **Java ForkJoinPool**: Work-stealing for parallel streams
- **Go scheduler**: Lightweight green threads with work-stealing
- ** Tokio**: Rust async runtime using work-stealing

**Trade-offs**

- **Pros**: Excellent load balancing; scalable; minimal contention
- **Cons**: Memory overhead for multiple queues; steal operations can be expensive

---

### 5. Epoch-Based Reclamation

Epoch-based reclamation (EBR) is a technique for safely freeing memory in lock-free data structures. It's simpler than hazard pointers and provides good performance.

#### How It Works

1. **Epochs**: Time is divided into epochs (typically three: previous, current, next)
2. **Protection**: Before reading a node, a thread "registers" in the current epoch
3. **Announcing done**: When a thread finishes accessing, it announces completion
4. **Reclamation**: When all threads have finished the current epoch, nodes from the previous epoch can be freed

#### Phases

- **Quiescent state**: All threads have left the epoch
- **Advancement**: When all threads in current epoch have quiesced, move to next epoch
- **Garbage collection**: Objects from the oldest epoch can now be freed

**Example Applications**

- **Boost lock-free library**
- **Linux kernel** (some components)
- **Rust crossbeam** epoch-based memory management

---

## Part V: System Design Patterns

### 1. Circuit Breaker

The circuit breaker pattern prevents cascading failures by detecting when a downstream service is failing and temporarily stopping requests to it.

#### States

- **Closed**: Normal operation; requests pass through
- **Open**: Failure threshold exceeded; requests fail immediately (or fallback)
- **Half-Open**: After timeout, limited requests test if service recovered

#### Configuration

- **Failure threshold**: Number or percentage of failures triggering open state
- **Timeout**: Duration to wait before attempting recovery
- **Success threshold**: Number of successes needed in half-open to close

**Example Applications**

- **Hystrix** (Netflix): Circuit breaker for Java microservices
- **Resilience4j**: Modern Java circuit breaker
- **Polly**: .NET resilience library
- **Finagle**: Twitter's RPC framework

---

### 2. Bulkhead Pattern

The bulkhead pattern isolates resources so that failure in one component doesn't affect others. Like ship bulkheads that contain flooding, it prevents total system failure.

#### Types

- **Thread pool isolation**: Each dependency gets its own thread pool
- **Connection pool isolation**: Separate connection pools per service
- **Process isolation**: Run components in separate processes/containers
- **Deployment isolation**: Deploy critical services on separate infrastructure

**Example Applications**

- **Netflix Hystrix**: Thread pool isolation per command
- **Service meshes**: Istio VirtualServices for traffic isolation
- **AWS**: Lambda reserved concurrency for isolation

---

### 3. Event Sourcing and CQRS

These related patterns separate read and write concerns, enabling scalable architectures.

#### Event Sourcing

Instead of storing current state, store a sequence of events. State is reconstructed by replaying events. Events are immutable and append-only.

**Benefits**

- Complete audit trail (every change is an event)
- Temporal queries (state at any point in time)
- Easy replication (events can be replayed anywhere)
- Undo/redo capabilities

**Challenges**

- Event schema evolution (backwards compatibility)
- Storage growth (snapshotting mitigates this)
- Complex initial implementation

#### CQRS (Command Query Responsibility Segregation)

Separate models for reading and writing. Commands (writes) go to one model; queries (reads) use a potentially different, optimized model.

**Benefits**

- Optimized read and write models separately
- Scalable: different read/write scaling
- Flexible: different storage for different query patterns

**Example Applications**

- **EventStoreDB**: Event sourcing database
- **Axon Framework**: CQRS framework for Java
- **Lokad**: Event sourcing in production
- **Bank systems**: Audit requirements favor event sourcing

---

### 4. Saga Pattern

The saga pattern manages distributed transactions across multiple services where traditional ACID transactions aren't possible.

#### Choreography vs Orchestration

**Choreography**: Services emit and listen to events. Each service knows its part but not the whole.

**Orchestration**: A central coordinator tells participants what to do. More explicit control but central point of failure.

#### Compensation

Each service action has a compensating action (undo). If one step fails, compensating actions run for previously completed steps.

#### Example: Order Processing

1. Order Service creates order (pending)
2. Payment Service charges customer -> Compensation: refund
3. Inventory Service reserves items -> Compensation: release reservation
4. Shipping Service schedules delivery -> Compensation: cancel shipping

If step 2 fails, step 1's compensation (cancel order) runs.

**Example Applications**

- **Temporal.io**: Workflow engine with saga support
- **Azure Durable Functions**: Orchestration with compensation
- **AWS Step Functions**: Distributed state machines
- **Lotus Commerce**: Saga-based order management

---

## Part VI: Security & Cryptography

### 1. HMAC

Hash-based Message Authentication Code provides message integrity and authentication using a secret key and cryptographic hash function.

#### How It Works

HMAC combines a secret key with message data using nested hashing:

```
HMAC(key, message) = H((key ⊕ opad) || H((key ⊕ ipad) || message))
```

Where `ipad` and `opad` are padding constants.

#### Properties

- **Integrity**: Any modification to message changes the MAC
- **Authentication**: Only parties with the key can generate valid MACs
- **Keyed hashing**: Different key produces different output

#### Security

Security depends on underlying hash function. HMAC remains secure even if underlying hash has some weaknesses (unlike simple concatenation).

**Example Applications**

- **API authentication**: AWS uses HMAC-SHA256 for request signing
- **JWT signatures**: Some JWT libraries use HMAC
- **TLS**: HMAC used in HMAC-based cipher suites
- **Database authentication**: Password reset tokens

---

### 2. PKI and Certificate Chains

Public Key Infrastructure provides a framework for verifying identities using digital certificates.

#### Components

- **Certificate Authority (CA)**: Trusted entity that issues certificates
- **Registration Authority (RA)**: Validates identity before certificate issuance
- **Certificate**: Binds a public key to an entity (domain, organization, person)
- **Certificate Revocation List (CRL)**: List of revoked certificates
- **OCSP (Online Certificate Status Protocol)**: Real-time certificate validation

#### Certificate Chain

Certificates are issued in chains:

1. **End-entity certificate**: Issued to the entity (e.g., website)
2. **Intermediate CA**: Issues end-entity certificates
3. **Root CA**: Trust anchor; self-signed; browser/OS trusted

Validation verifies each certificate signed the next, ending at a trusted root.

#### Certificate Types

- **DV (Domain Validation)**: Domain ownership verified
- **OV (Organization Validation)**: Organization verified
- **EV (Extended Validation)**: Thorough verification; green address bar

**Example Applications**

- **HTTPS**: TLS/SSL certificates
- **Code signing**: Verify software integrity
- **Client certificates**: Mutual TLS authentication
- **S/MIME**: Email encryption and signing

---

### 3. Rate Limiting Algorithms

Rate limiting controls how many requests a client can make in a time window, protecting services from abuse and ensuring fair resource allocation.

#### Token Bucket

A bucket holds tokens, each costing one request. Tokens are added at a fixed rate (r). When a request arrives:

- If bucket has tokens, remove one and allow request
- If bucket empty, reject request

**Properties**: Allows bursts up to bucket size; steady rate over time.

#### Leaky Bucket

Requests enter a queue that leaks at a fixed rate. Queue has maximum size. If queue full, reject request.

**Properties**: Smooths output to constant rate; FIFO; bursty input produces constant output.

#### Sliding Window

Maintains a timestamp log of recent requests. Count requests in sliding window (current time minus window size). If count < limit, allow and record; else reject.

**Variants**: Fixed window (simpler but allows burst at boundaries), sliding log (precise but memory-intensive).

**Example Applications**

- **API Gateways**: AWS API Gateway, Kong, NGINX
- **Cloud services**: Google Cloud Armor, Azure Rate Limiting
- **Distributed systems**: Redis-based rate limiters
- **CDNs**: Cloudflare, Akamai

---

### 4. Cryptographic Hash Functions

Cryptographic hash functions map arbitrary data to fixed-size outputs with specific security properties.

#### Properties

- **Deterministic**: Same input produces same output
- **One-way**: Computationally infeasible to reverse
- **Collision resistance**: Hard to find two inputs with same output
- **Avalanche**: Small input changes produce drastically different outputs

#### Common Functions

- **MD5**: 128-bit output; broken (collisions found)
- **SHA-1**: 160-bit output; deprecated (collisions found)
- **SHA-256**: 256-bit output; current standard
- **SHA-3**: Latest standard; different design

#### Applications

- **Integrity verification**: File checksums
- **Password hashing**: Store password hashes, not plaintext (use bcrypt, Argon2)
- **Digital signatures**: Hash message, then sign hash
- **Proof of work**: Cryptocurrency mining
- **Merkle trees**: Data integrity verification

---

## Part VII: Optimization & Approximation

### 1. HyperLogLog

HyperLogLog estimates cardinalities (count of distinct elements) with ~2% accuracy using minimal memory—typically 12KB for 2^64 unique items.

#### How It Works

The algorithm uses hash functions to map elements to binary strings. It tracks the maximum number of leading zeros seen, estimating cardinality using the formula:

```
Estimate = m * 2^R
```

Where `m` is the number of registers and `R` is the maximum observed zeros.

#### Implementation Details

- Split hash output into `m` registers (typically 2^14 = 16384)
- Use hash value's low bits to select register
- Use remaining bits to update register with leading zero count
- Final estimate includes bias correction

**Example Applications**

- **Redis**: PFADD, PFCOUNT commands for hyperloglog
- **Google BigQuery**: Approximate COUNT(DISTINCT)
- **Instagram**: Counting unique likes, views
- **Analytics pipelines**: Real-time unique user counting

**Trade-offs**

- ~2% standard error (adjustable with more registers)
- Memory: ~12KB for 2^64 elements
- Cannot retrieve actual distinct elements (only count)

---

### 2. Count-Min Sketch

Count-Min sketch approximates frequency counts for items in a stream using sub-linear memory.

#### How It Works

Use `d` hash functions, each mapping to one of `w` array positions. For each item, compute all `d` positions and increment each. To query frequency, take the minimum value across all positions.

This gives an upper bound on frequency (may overcount due to hash collisions).

#### Parameters

- `w` (width): Larger = less overcounting
- `d` (depth): Larger = reduced collision probability
- Memory: O(w * d)

Typical: w=2^14 (16384), d=5, uses ~80KB

**Example Applications**

- **Heavy hitters detection**: Find most frequent items
- **Network traffic analysis**: Count packet types, flow frequencies
- **Recommendation systems**: Track item frequencies for personalization
- **Distributed stream processing**: Algorithmic sketches in Flink, Spark

---

### 3. Locality-Sensitive Hashing

LSH hashes items so that similar items collide with high probability. Unlike cryptographic hashing (which randomizes), LSH preserves similarity.

#### How It Works

Define a similarity metric (Jaccard, cosine, Hamming distance). Create hash functions where similar items map to same bucket with higher probability than dissimilar items.

**LSH Families**

- **MinHash**: Jaccard similarity; used for set similarity
- **SimHash**: Cosine similarity; produces fingerprint for comparison
- **E2LSH**: Euclidean distance

#### Applications

- **Near-duplicate detection**: Find similar documents at scale
- **Image search**: Find similar images
- **Recommendation**: Item similarity
- **Audio/Video fingerprinting**: Content identification

---

### 4. Genetic Algorithms

Genetic algorithms are optimization techniques inspired by natural selection. They maintain a population of candidate solutions, evolving them over generations.

#### Components

- **Chromosome**: Representation of a solution (often bit vector)
- **Population**: Set of chromosomes
- **Fitness function**: How good is a solution
- **Selection**: Choose parents based on fitness
- **Crossover**: Combine parents to create children
- **Mutation**: Random changes to offspring

#### Algorithm

1. Initialize population
2. Evaluate fitness
3. Select parents
4. Create offspring via crossover
5. Apply mutation
6. Replace population
7. Repeat until convergence

**Example Applications**

- **Route optimization**: Traveling salesman, vehicle routing
- **Machine learning**: Hyperparameter tuning, feature selection
- **Engineering design**: Aerodynamic shapes, circuit design
- **Game AI**: Evolving strategies, procedural content generation
- **Portfolio optimization**: Investment allocation

---

## Part VIII: Network & Communication

### 1. Load Balancing Algorithms

Load balancers distribute traffic across multiple servers to optimize resource utilization.

#### Algorithms

- **Round Robin**: Cycle through servers; simple but ignores current load
- **Least Connections**: Direct to server with fewest active connections
- **Least Response Time**: Direct to server with fastest response
- **Weighted**: Assign weights based on capacity
- **IP Hash**: Consistent hashing by client IP (session persistence)
- **Random**: Random selection; works well with many servers

#### L4 vs L7

- **Layer 4 (Transport)**: TCP/UDP level; less parsing overhead; no content awareness
- **Layer 7 (Application)**: HTTP level; can route by URL, headers; smarter but more overhead

**Example Applications**

- **HAProxy**: L4/L7 load balancer
- **NGINX**: L7 load balancer with advanced routing
- **AWS ELB/ALB**: Managed load balancing
- **Consul**: Service mesh with load balancing

---

### 2. Backpressure Handling

Backpressure (or flow control) prevents overwhelming downstream systems when they can't keep up with incoming data.

#### Techniques

- **TCP flow control**: Receiver advertises available buffer space
- **Application-level**: Explicitly slow producers
- **Windowing**: Credit-based systems
- **Drop policies**: Drop oldest, newest, or random when buffer full
- **Reactive streams**: Publisher-subscriber with demand signaling

#### Handling Strategies

- **Buffer with limits**: Bounded queues; apply backpressure when full
- **Load shedding**: Drop requests when overloaded
- **Circuit breaking**: Temporarily stop accepting work
- **Adaptive throttling**: Adjust rate based on system health

**Example Applications**

- **Reactive Streams**: Standard for async stream processing
- **Akka Streams**: Backpressure-aware streams
- **RxJava**: Observable with backpressure strategies
- **Kafka**: Consumer lag management

---

### 3. Protocol Buffers

Protocol Buffers (protobuf) are Google's language-neutral, platform-neutral serialization format. They define data structures in `.proto` files, then compile to language-specific code.

#### Advantages

- **Compact**: Binary format smaller than JSON/XML
- **Fast parsing**: Binary format parses faster than text
- **Schema evolution**: Fields can be added/removed with backward compatibility
- **Cross-language**: Generated code for many languages

#### Example

```proto
message Person {
  string name = 1;
  int32 age = 2;
  repeated string emails = 3;
}
```

**Example Applications**

- **gRPC**: Uses Protocol Buffers for service definition and serialization
- **Google internal**: Many internal systems use protobuf
- **Apache Beam**: Data processing pipelines
- **Kubernetes**: API objects

---

## Part IX: Search & String Algorithms

### 1. Phonetic Algorithms

Phonetic algorithms convert words to phonetic representations so similar-sounding words map to the same code. Useful for matching names that sound alike.

#### Soundex

Maps names to 4-character codes: first letter + 3 digits representing consonants with similar sounds. Limited accuracy but simple.

```
Algorithm:
1. Keep first letter
2. Replace letters with digit: B,F,P,V=1; C,G,J,K,Q,S,X,Z=2; D,T=3; L=4; M,N=5; R=6
3. Remove consecutive duplicates
4. Pad with zeros, take first 4 chars
```

#### Metaphone

More sophisticated than Soundex; accounts for English pronunciation rules. Used in spell checkers and genealogical databases.

**Example Applications**

- **Search**: Phonetic matching for names
- **Deduplication**: Find similar records
- **Spell checking**: Suggest corrections
- **Genealogy software**: Match variant name spellings

---

### 2. Rabin-Karp

Rabin-Karp is a string matching algorithm using rolling hash. It finds pattern occurrences in text in O(n + m) average time.

#### How It Works

1. Compute hash of pattern
2. Compute hash of first window in text
3. If hashes match, verify string (collision possible)
4. Roll window: subtract effect of first character, add new character

#### Properties

- **Average case**: O(n + m)
- **Worst case**: O(nm) - but rare with good hash function
- **Multiple patterns**: Efficiently extendable to search multiple patterns

**Example Applications**

- **Plagiarism detection**: Find matching text in documents
- **String searching**: General-purpose substring search
- **DNA sequence matching**: Find pattern occurrences
- **File integrity**: Content-based hashing

---

### 3. Aho-Corasick

Aho-Corasick finds all occurrences of multiple patterns in a text in linear time O(n + m + z), where z is number of matches.

#### How It Works

1. Build automaton from all patterns using a trie
2. Add failure links (like KMP's prefix function)
3. Process text character by character
4. Follow failure links to find matches

#### Properties

- **Single pass**: Processes text once regardless of pattern count
- **Efficient**: O(text length + pattern length + matches)
- **Memory**: Proportional to total pattern length

**Example Applications**

- **Network security**: Firewall pattern matching (intrusion detection)
- **Keyword filtering**: Ad blockers, profanity filters
- **Bioinformatics**: DNA pattern matching
- **Search engines**: Multiple keyword highlighting

---

### 4. MinHash and SimHash

Both algorithms approximate similarity between sets or documents.

#### MinHash

Estimates Jaccard similarity (intersection over union) of two sets.

1. Hash each element to multiple permutation values
2. For each permutation, take minimum hash value (signature)
3. Estimate similarity as fraction of matching minimum values

**Properties**: Can handle millions of elements with small signature; probabilistic but accurate.

#### SimHash

Creates fingerprint for documents to find near-duplicates.

1. Hash features to 64-bit or 128-bit values
2. Weight features (e.g., TF-IDF)
3. Combine using weighted sum with signs
4. Fingerprint is resulting bit vector

**Hamming distance**: Compare fingerprints by counting differing bits.

**Example Applications**

- **Google**: Near-duplicate news article detection
- **Facebook**: Finding similar posts/images
- **Crawlers**: Detect duplicate pages
- **Recommendation**: Find similar items

---

### 5. BM25

BM25 is the ranking function behind most full-text search engines. It improves on TF-IDF by accounting for term frequency saturation and document length.

#### Formula

```
score(Q, D) = sum IDF(qi) * (f(qi,D) * (k1 + 1)) / (f(qi,D) + k1 * (1 - b + b * |D| / avgdl))
```

Where:
- `f(qi,D)`: Term frequency in document
- `|D|`: Document length
- `avgdl`: Average document length
- `k1`: Term frequency saturation parameter (typically 1.5-2.0)
- `b`: Document length normalization (typically 0.75)

#### Why It Works

- **IDF**: Rare terms weighted more heavily
- **Saturation**: Diminishing returns after frequency threshold
- **Length normalization**: Normalizes for document length

**Example Applications**

- **Elasticsearch**: Default ranking algorithm
- **Lucene/Solr**: Standard similarity implementation
- **Search engines**: Web search ranking
- **Document retrieval**: Academic paper search

---

### 6. HNSW

Hierarchical Navigable Small World is the dominant algorithm for approximate nearest neighbor search in high-dimensional spaces.

#### How It Works

- Build a multi-layer graph
- Higher layers have fewer, more distant connections
- Lower layers have more, closer connections
- Search starts at top layer, moves down via local nearest-neighbor connections
- Exploits "small world" property for efficient navigation

#### Properties

- **Sub-linear search**: O(log n) average
- **High accuracy**: Can tune accuracy/speed tradeoff
- **Memory**: Higher than flat indexes but acceptable

**Example Applications**

- **Faiss**: Facebook's vector similarity search library
- **pgvector**: PostgreSQL vector extension
- **Weaviate**: Vector database
- **Pinecone**: Managed vector database
- **Milvus**: Open-source vector database
