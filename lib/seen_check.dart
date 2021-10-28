typedef SeenChecker = bool Function(Symbol id);

/// Combines the [SeenChecker] for a parent [Indexable] with a new ID to mark as seen
SeenChecker chainSeenChecker(Symbol thisId, SeenChecker parent) =>
        (id) => thisId == id || parent(id);

