human(_) :- fail.
human(vitya).
human(yura).
human(misha).

not_on_the_edge(yura).

to_the_left(yura, misha).
to_the_left(vitya, yura).
to_the_left(misha, X) :-
    not(to_the_left(X, misha)),
    not_on_the_edge(X).

solve(H1, H2) :-
    human(H1),
    human(H2),
    not(H1 = H2),
    to_the_left(H1, H2).
solve(_, _).
