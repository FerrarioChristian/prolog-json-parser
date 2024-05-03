Il predicato jsonparse/2 è il punto di ingresso principale per il parsing di un
input JSON, una stringa o una rappresentazione atomica di JSON, in un termine
Prolog che rappresenta la struttura dati JSON.

I predicati jsonobj/2 e jsonarray/2 vengono usati per parsare rispettivamente
oggetti e array JSON.

Il predicato jsonaccess/3 viene utilizzato per accedere ai valori nella
struttura dati JSON analizzata, mentre i predicati jsonread/2 e jsondump/2
vengono utilizzati rispettivamente per leggere e scrivere dati JSON da e verso
un file.

Il predicato jsonparse/2 accetta due argomenti: l'input JSON e l'output parsato.
Innanzitutto controlla se l'input è una stringa o un atomo e lo converte in una
rappresentazione di termini del JSON. Il predicato utilizza quindi jsonobj/2 e
jsonarray/2 per analizzare rispettivamente gli oggetti e gli array JSON
nell'input.

Il predicato jsonobj/2 accetta due argomenti: l'oggetto JSON di input e
l'output parsato. Utilizza il predicato member/2 per analizzare le coppie
chiave-valore dell'oggetto, dove il predicato member/2 prende una singola
coppia chiave-valore e la restituisce come tupla della chiave e del valore
parsato.

Il predicato jsonarray/2 accetta due argomenti: l'array JSON di input e
l'output parsato. Itera attraverso gli elementi dell'array e usa 
jsonparse/2 per analizzare ogni elemento in modo ricorsivo.

Il predicato jsonaccess/3 accetta tre argomenti: la struttura dati JSON
parsata, una lsita di campi e il risultato trovato. Utilizza il predicato
accessvalue/3 per accedere al valore di un campo in un oggetto JSON e il
predicato nth0/3 per accedere a un elemento in un determinato indice in un
array JSON.

Il predicato jsonread/2 accetta due argomenti: il nome del file e il JSON
parsato. Apre il file, legge l'input JSON da esso, utilizza jsonparse/2 per
parsarlo e quindi chiude il file.

Il predicato jsondump/2 accetta due argomenti: la struttura dei dati JSON
parsata e il nome del file. Utilizza encloseinparens/3 per racchiudere il JSON
tra parentesi graffe per gli oggetti e parentesi quadre per gli array e scrive
la stringa risultante in un file.

I predicati encloseinparens/3 ed elements/3 vengono utilizzati per formattare i
dati JSON parsati in modo che possano essere scritti su file. Il predicato
encloseinparens/3 racchiude gli elementi con la parentesi appropriata, il
predicato elements/3 viene utilizzato per formattare gli elementi dell'array
JSON da scrivere sul file.
