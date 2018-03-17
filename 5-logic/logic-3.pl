neighbors(X, Y, List) :-
    nextto(X, Y, List);
    nextto(Y, X, List).

make_street(0, []) :- !.
make_street(N, [[_House, _Nationality, _Animal, _Smokes, _Drinks]|T]) :-
    N1 is N - 1,
    make_street(N1, T).

solution(Street, FishOwner) :-
    make_street(5, Street),

    %      [ _House, _Nationality, _Animal,  _Smokes ,  _Drinks]         %
    member([ red   ,  englishmen ,  _     ,  _       ,  _      ], Street),
    member([ _     ,  swedish    ,  dog   ,  _       ,  _      ], Street),
    member([ _     ,  dane       ,  _     ,  _       ,  tea    ], Street),
    nextto([ green ,  _          ,  _     ,  _       ,  _      ],
           [ white ,  _          ,  _     ,  _       ,  _      ], Street),
    member([ green ,  _          ,  _     ,  _       ,  coffee ], Street),
    member([ _     ,  _          ,  bird  ,  pallman ,  _      ], Street),
    nth1(3, Street,
           [ _     ,  _          ,  _     ,  _       ,  milk   ]),
    member([ yellow,  _          ,  _     ,  dunhill,   _      ], Street),
    nth1(1, Street,
           [ _     ,  norwegian  ,  _     ,  _       ,  _      ]),
    neighbors(
           [ _     ,  _          ,  cat   ,  _       ,  _      ],
           [ _     ,  _          ,  _     ,  malborro,  _      ], Street),
    neighbors(
           [ _     ,  _          ,  horse ,  _       ,  _      ],
           [ _     ,  _          ,  _     ,  dunhill ,  _      ], Street),
    member([ _     ,  _          ,  _     ,  winfield,  beer   ], Street),
    neighbors(
           [ _     ,  norwegian  ,  _     ,  _       ,  _      ],
           [ blue  ,  _          ,  _     ,  _       ,  _      ], Street),
    member([ _     ,  german     ,  _     ,  rothmans,  _      ], Street),
    neighbors(
           [ _     ,  _          ,  _     ,  malborro,  _      ],
           [ _     ,  _          ,  _     ,  _       ,  water  ], Street),

    member([ _     ,  FishOwner  ,  fish  ,  rothmans,  _      ], Street).

print_list([]) :- !.
print_list([H|T]) :-
    format("~0|[ ~w,~9| ~w,~23| ~w,~32| ~w,~43| ~w~52|]~n", H),
    print_list(T).

solution :-
    solution(Street, FishOwner), !,
    write("Fish Owner is "), write(FishOwner), nl,
    print_list(Street).
