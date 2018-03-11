fibonacci(0, 0) :- !.
fibonacci(1, 1) :- !.
fibonacci(N, M) :-
    N > 1, !,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, M1),
    fibonacci(N2, M2),
    M is M1 + M2.

fibonacci_tail(0, 0) :- !.
fibonacci_tail(N, F) :- N > 0, !, fibonacci_tail0(N, F, 0, 1, 0, 1).
fibonacci_tail0(N, F, _, N, _, F) :- !.
fibonacci_tail0(N, F, N1, N2, F1, F2) :-
    N11 is N1 + 1,
    N21 is N2 + 1,
    F21 is F1 + F2,
    fibonacci_tail0(N, F, N11, N21, F2, F21).

mult(_, 0, 0) :- !.
mult(0, _, 0) :- !.
mult(N, 1, N) :- !.
mult(N, M, R) :-
    N > 0, !,
    M > 0, !,
    M1 is M - 1,
    mult(N, M1, R1),
    R is R1 + N.

mult(_, 0, 0) :- !.
mult(0, _, 0) :- !.
mult(N, 1, N) :- !.

mult_tail(_, 0, 0) :- !.
mult_tail(0, _, 0) :- !.
mult_tail(N, M, R) :-
    N > 0, !,
    M > 0, !,
    mult_tail0(N, M, R, 0, 0).
mult_tail0(_, M, R, M, R) :- !.
mult_tail0(N, M, R, M1, R1) :-
    M2 is M1 + 1,
    R2 is R1 + N,
    mult_tail0(N, M, R, M2, R2).

sum_even(0, 0) :- !.
sum_even(N, M) :-
    N1 is N - 1,
    N1 >= 0, !,
    sum_even(N1, M1),
    M is M1 + 2 * N.

sum_even_tail(0, 0) :- !.
sum_even_tail(N, M) :-
    sum_even_tail0(N, M, 0, 0).
sum_even_tail0(N, M, N, M) :- !.
sum_even_tail0(N, M, N1, M1) :-
    N2 is N1 + 1,
    M2 is M1 + 2 * N2,
    sum_even_tail0(N, M, N2, M2).

positive_or_zero(N, M) :-
    N > 0, !, N = M.
positive_or_zero(_, 0).

do_if_else(false, _, B) :- B, !.
do_if_else(true, A, _) :- A, !.

is_less(A, B, R) :- A < B, !, R = true.
is_less(_, _, R) :- R = false.

sum_input0(T, R, S1, S2) :- S2 >= T, !, R = S1.
sum_input0(T, R, _, S2) :-
    write("current sum is "), write(S2), nl,
    prompt1("enter new integer number: "), read(N),
    positive_or_zero(N, N1), !,
    S3 is S2 + N1,
    sum_input0(T, R, S2, S3).

sum_input(T, R) :- sum_input0(T, R, 0, 0).
