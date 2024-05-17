## Predicati Principali

### jsonparse/2

Il predicato `jsonparse/2` è il punto di ingresso principale per il parsing di un input JSON, una stringa o una rappresentazione atomica di JSON, in un termine Prolog che rappresenta la struttura dati JSON.

- **Argomenti:**
  - `Input`: la stringa o l'atomo JSON da parsare.
  - `Output`: il termine Prolog che rappresenta la struttura dati JSON parsata.

Innanzitutto, il predicato controlla se l'input è una stringa o un atomo e lo converte in una rappresentazione di termini del JSON. Utilizza quindi `jsonobj/2` e `jsonarray/2` per analizzare rispettivamente gli oggetti e gli array JSON nell'input.

### jsonobj/2

Il predicato `jsonobj/2` viene usato per parsare oggetti JSON.

- **Argomenti:**
  - `Input`: l'oggetto JSON di input.
  - `Output`: il termine Prolog che rappresenta l'oggetto JSON parsato.

Utilizza il predicato `member/2` per analizzare le coppie chiave-valore dell'oggetto, dove `member/2` prende una singola coppia chiave-valore e la restituisce come tupla della chiave e del valore parsato.

### jsonarray/2

Il predicato `jsonarray/2` viene usato per parsare array JSON.

- **Argomenti:**
  - `Input`: l'array JSON di input.
  - `Output`: il termine Prolog che rappresenta l'array JSON parsato.

Itera attraverso gli elementi dell'array e usa `jsonparse/2` per analizzare ogni elemento in modo ricorsivo.

### jsonaccess/3

Il predicato `jsonaccess/3` viene utilizzato per accedere ai valori nella struttura dati JSON analizzata.

- **Argomenti:**
  - `ParsedJSON`: la struttura dati JSON parsata.
  - `Fields`: una lista di campi.
  - `Result`: il risultato trovato.

Utilizza il predicato `accessvalue/3` per accedere al valore di un campo in un oggetto JSON e il predicato `nth0/3` per accedere a un elemento in un determinato indice in un array JSON.

### jsonread/2

Il predicato `jsonread/2` viene utilizzato per leggere dati JSON da un file.

- **Argomenti:**
  - `Filename`: il nome del file.
  - `ParsedJSON`: il JSON parsato.

Apre il file, legge l'input JSON da esso, utilizza `jsonparse/2` per parsarlo e quindi chiude il file.

### jsondump/2

Il predicato `jsondump/2` viene utilizzato per scrivere dati JSON su un file.

- **Argomenti:**
  - `ParsedJSON`: la struttura dei dati JSON parsata.
  - `Filename`: il nome del file.

Utilizza `encloseinparens/3` per racchiudere il JSON tra parentesi graffe per gli oggetti e parentesi quadre per gli array e scrive la stringa risultante in un file.

### encloseinparens/3

Il predicato `encloseinparens/3` viene utilizzato per formattare i dati JSON parsati.

- **Argomenti:**
  - `Type`: il tipo di parentesi (`{}` per gli oggetti, `[]` per gli array).
  - `Elements`: gli elementi da racchiudere.
  - `Result`: la stringa risultante formattata.

### elements/3

Il predicato `elements/3` viene utilizzato per formattare gli elementi dell'array JSON da scrivere su file.

- **Argomenti:**
  - `Elements`: la lista degli elementi.
  - `Accumulator`: l'accumulatore per i risultati intermedi.
  - `Result`: la lista degli elementi formattata.
