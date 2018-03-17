animal(_) :- fail.
animal(cat).
animal(hamster).
animal(dog).

human(_) :- fail.
human(tanya).
human(petya).
human(lena).

walks(tanya, cat).
walks(petya, X) :-
    not(X = cat),
    not(X = hamster).
walks(lena, X) :-
    not(walks(tanya, X)),
    not(walks(petya, X)).

solve(P, A) :-
    human(P),
    animal(A),
    walks(P, A).
solve(_, _).
