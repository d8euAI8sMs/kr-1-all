sum_list(L, S) :-
    sum_list0(L, S, 0).
sum_list0([], S, S).
sum_list0([H|T], S, S1) :-
    S2 is S1 + H,
    sum_list0(T, S, S2).

max_of(A, B, C) :-
    A > B, !,
    C = A.
max_of(_, B, C) :-
    C = B.

max_list([H|T], A) :-
    max_list0(T, A, H).
max_list0([], A, A).
max_list0([H|T], A, A1) :-
    max_of(H, A1, A2),
    max_list0(T, A, A2).

take_odd_list(L, R) :-
    take_odd_list0(L, R, []).
take_odd_list0([], R, R).
take_odd_list0([H], R, R1) :- !,
    append(R1, [H], R).
take_odd_list0([H1,_|T], R, R1) :-
    append(R1, [H1], R2),
    take_odd_list0(T, R, R2).
