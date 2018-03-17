wmember([ H, (P1, P2) ], People) :-
    member([ H, (P1, P2) ], People);
    member([ H, (P2, P1) ], People).

solution(People) :-
    permutation([carrot, carrot, carrot, cabbage, cabbage],
                [ K, E, Ki, Z, L ]),
    People = [
        [ katya, K  ],
        [ egor , E  ],
        [ kira , Ki ],
        [ zahar, Z  ],
        [ lera , L  ]
    ],
    E \= K,
    E \= Ki,
    Z \= Ki,
    Z = L.

print_list([]) :- !.
print_list([H|T]) :-
    format("~0|[ ~w,~10| ~w~20|]~n", H),
    print_list(T).

solution :-
    solution(People), !,
    print_list(People).
