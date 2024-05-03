/* 
	Ferrario Christian	886230
	Bonfanti Davide 		873293
*/

jsonparse({}, jsonobj([])).
jsonparse([], jsonarray([])).
jsonparse(JSONInput, ParsedJSON) :-
    (string(JSONInput) ; atom(JSONInput)),
    (string(JSONInput) -> term_string(JSONTerm, JSONInput);
      atom_string(JSONInput, JSONString),
      term_string(JSONTerm, JSONString)
    ),
    jsonparse(JSONTerm, ParsedJSON).

jsonparse(JSONTerm, jsonobj(ParsedMembers)) :-
    JSONTerm =.. [{}, ObjectMembers],
    jsonobj([ObjectMembers], ParsedMembers).

jsonparse(ArrayInput, jsonarray(ParsedArray)) :-
  jsonarray(ArrayInput, ParsedArray).

%%%%%%%%%% Object %%%%%%%%%%

jsonobj([Member], [ParsedMember]) :-
    member(Member, ParsedMember).

jsonobj([Members], [ParsedMember | ParsedMembers]) :-
    Members =.. [',', Member | MembersToParse],
    member(Member, ParsedMember),
    jsonobj(MembersToParse, ParsedMembers).

member(Member, (Attribute, ParsedValue)) :-
    Member =.. [':', Attribute, Value],
    string(Attribute),
    ((string(Value) ; number(Value)) -> ParsedValue = Value;
    jsonparse(Value, ParsedValue)).
    

%%%%%%%%%% Array %%%%%%%%%%

jsonarray([], []).

jsonarray([Value | MoreElements], [ParsedValue | ParsedElements]) :-
    ((string(Value) ; number(Value)) -> ParsedValue = Value;
    jsonparse(Value, ParsedValue)),
    jsonarray(MoreElements, ParsedElements).

%%%%%%%%%% Accesso ai dati %%%%%%%%%%

jsonaccess(Result, [], Result).

jsonaccess(jsonobj(Members), [Field | Fields], Result) :-
    jsonaccess(jsonobj(Members), Field, PartialResult),
    jsonaccess(PartialResult, Fields, Result).

jsonaccess(jsonarray(Elements), [Field | Fields], Result) :-
    jsonaccess(jsonarray(Elements), Field, PartialResult),
    jsonaccess(PartialResult, Fields, Result).

jsonaccess(jsonobj(Members), Field, Result) :-
    string(Field),
    accessvalue(Members, Field, Result).

jsonaccess(jsonarray(Elements), Field, Result) :-
    number(Field),
    nth0(Field, Elements, Result).

accessvalue([(Item1, Item2) | _], Field, Result) :-
    (Field = Item1 -> Result = Item2; fail).

accessvalue([(_) | Items], Field, Result) :-
    accessvalue(Items, Field, Result).

%%%%%%%%%% Lettura da file %%%%%%%%%%
jsonread(FileName, ParsedJSON) :-
    open(FileName, read, Stream),
    read_string(Stream, _, JSONInput),
    jsonparse(JSONInput, ParsedJSON),
    close(Stream).


%%%%%%%%%% Scrittura su file %%%%%%%%%%

jsondump(JSON, FileName) :-
    encloseinparens(JSON, [], Codes),
    string_codes(JSONOutput, Codes),
    filedump(FileName, JSONOutput).


encloseinparens(jsonobj(Members), Input, Result) :-
    append(Input, [123], Tmp),
    pair(Members, Tmp, WithoutParen),
    append(WithoutParen, [125], Result).

encloseinparens(jsonarray(Elements), Input, Result) :-
    append(Input, [91], Tmp),
    elements(Elements, Tmp, WithoutParen),
    append(WithoutParen, [93], Result).

elements([], [91], Result) :-
    append([], [91], Result).

elements([], Input, Result) :-
    pop(Input, Result).

elements([Head_Values | Tail_Values], Done, Result) :-
    value(Head_Values, Done, TmpDone),
    append(TmpDone, [44], TmpResult),
    elements(Tail_Values, TmpResult, Result).

pair([], [123], Result) :-
    append([], [123], Result).

pair([], Done, Result) :-
    pop(Done, Result).

pair([(String, Value) | MorePair], Done, Result) :-
    atom_codes(String, Codes),
    append([34 | Codes], [34], Tmp_String),
    append(Done, Tmp_String, TmpDone),
    append(TmpDone, [58], TmpPair),
    value(Value, TmpPair, TmpResult),
    append(TmpResult, [44], Pair),
    pair(MorePair, Pair, Result).

value(jsonobj(Members), Done, Result) :-
    encloseinparens(jsonobj(Members), Done, Result).

value(jsonarray(Elements), Done, Result) :-
    encloseinparens(jsonarray(Elements), Done, Result).

value(String, Done, Result) :-
    string(String),
    string_codes(String, Codes),
    append([34 | Codes], [34], Tmp_String),
    append(Done, Tmp_String, Result).

value(Number, Done, Result) :-
    number_codes(Number, Codes),
    append(Done, Codes, Result).

pop(List, Result) :-
    reverse(List, [_Last|ReversedResult]),
    reverse(ReversedResult, Result).

filedump(Filename, JSON) :-
    open(Filename, write, Stream),
    write(Stream, JSON),
    close(Stream).