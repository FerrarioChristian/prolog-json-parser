# Prolog JSON Parser

Custom, dependency-free JSON parser and serializer developed in SWI-Prolog.

This project explores the application of logic programming paradigms to data parsing and serialization. By leveraging Prolog's powerful term unification, the univ operator (`=..`), and recursive clause resolution, it transforms flat JSON strings into structured, traversable Prolog terms without relying on external libraries.

## Key Features

- **Logical Parsing:** Converts JSON objects (`{...}`) and arrays (`[...]`) into compound Prolog terms (`jsonobj/1` and `jsonarray/1`).
- **Data Access:** Query nested JSON structures dynamically using field names or array indices via logical backtracking.
- **File I/O:** Built-in predicates to read JSON from files directly into memory or serialize Prolog terms back into formatted JSON files.
- **Pure Logic Implementation:** Utilizes pattern matching and recursion instead of imperative control flows.

## Core Predicates

The implementation is driven by a set of highly recursive predicates that evaluate and construct the JSON AST.

### Ingestion & Serialization
- `jsonparse/2`: The primary entry point. It accepts a JSON string (or atom) and parses it. It first maps the string to standard Prolog terms using `term_string/2` and then recursively transforms those terms into the custom `jsonobj/1` and `jsonarray/1` structures.
- `jsonread/2`: Opens a file, reads its contents into a string, and evaluates it using `jsonparse/2`.
- `jsondump/2`: The serializer. It takes a parsed `jsonobj` or `jsonarray`, recursively converts the AST back into character codes (using predicates like `encloseinparens/3` and `elements/3`), and writes the resulting JSON string to a file.

### Data Access
- `jsonaccess/3`: A flexible querying predicate. You can pass a parsed JSON structure and a list of fields (keys for objects, indices for arrays). Through unification and recursive traversal (`accessvalue/3` and `nth0/3`), it resolves and unifies the `Result` variable with the requested nested value.

### Internal Logic
- `jsonobj/2` & `jsonarray/2`: These predicates handle the recursive decomposition of Prolog term structures. They utilize the univ operator (`=..`) to unpack terms (like `,` for lists of members or `:` for key-value pairs) and recursively parse inner values.
- `member/2`: Identifies and extracts key-value pairs (separated by `:`) ensuring keys are strings and deferring value parsing based on their type.

## Getting Started

### Prerequisites
You need a Prolog environment installed, such as [SWI-Prolog](https://www.swi-prolog.org/).

### Running the Parser

1. Clone the repository and navigate to the directory:
   ```bash
   git clone <your-repository-url>
   cd prolog-json-parser
   ```

2. Launch the SWI-Prolog interpreter with the source file:
   ```bash
   swipl -s jsonparse.pl
   ```

3. Query the parser directly in the REPL:
   ```prolog
   ?- jsonparse("{\"name\": \"John\", \"age\": 30}", Parsed).
   ```
   *Expected Output:*
   ```prolog
   Parsed = jsonobj([("name", "John"), ("age", 30)]).
   ```
