wmember([ H, (P1, P2) ], People) :-
    member([ H, (P1, P2) ], People);
    member([ H, (P2, P1) ], People).

solution(People) :-
    permutation([
        medical_orderly, head, telephonist, teacher,
        boxer, security_guard, policeman, actor ],
        [ RP1, RP2, TP1, TP2, SP1, SP2, PP1, PP2 ]),
    People = [
        [ (roberta, female), (RP1, RP2) ],
        [ (telma  , female), (TP1, TP2) ],
        [ (steve  ,   male), (SP1, SP2) ],
        [ (pete   ,   male), (PP1, PP2) ]
    ],
    wmember([ (_, male), (medical_orderly, _) ], People),
    wmember([ (_, female), (head, _) ], People),
    wmember([ (_, male), (telephonist, _) ], People),
    not(wmember([ (roberta, _), (boxer, _) ], People)),
    not(wmember([ (pete, _), (teacher, _) ], People)),
    not(wmember([ (pete, _), (head, _) ], People)),
    not(wmember([ (pete, _), (actor, _) ], People)),
    not(wmember([ (roberta, _), (head, _) ], People)),
    not(wmember([ (roberta, _), (policeman, _) ], People)),
    not(wmember([ _, (head, policeman) ], People)).

print_list([]) :- !.
print_list([[(N,G),(P1,P2)]|T]) :-
    format("~0|[ ~w,~10| ~w,~20| ~w,~40| ~w~60|]~n", [ N, G, P1, P2 ]),
    print_list(T).

solution :-
    solution(People), !,
    print_list(People).
