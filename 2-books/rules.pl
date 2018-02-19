
/* ******************* formatting and printing ********************* */

/*
 * format help:
 *
 *     ~n  -- newline
 *     ~t  -- fill with
 *     ~Nt -- fill with char(N) (45 for '-', 46 for '.' and so on)
 *     ~N| -- set next tab stop at N character
 *     ~N+ -- add N to the current tab stop position
 *     ~w  -- send next argument to `write`
 *     ~tX, X~t, ~tX~t -- left, right, center alignment of X
 */

table_rule("|~45t~59||~45t~6+|~45t~6+|").
table_column_format("|~w~59||~t~w~6+|~t~w~6+|").
table_column_headers(("Name", "Price", "Count")).

print_row((N, P, C)) :- table_column_format(F),
                        format(F, [N, P, C]).
print_head           :- table_column_headers(H), table_rule(R),
                        print_row(H), nl, format(R), nl.



/* ************************** utility ****************************** */

contains(String1, String2) :- sub_string(String1, _, _, _, String2), !.
contains_ci(String1, String2) :- string_lower(String1, String3),
                                 string_lower(String2, String4),
                                 contains(String3, String4).



/* ********************* single book queries *********************** */

query_by_name(Name, Book) :- book(Book), Book = (N, _, _), contains_ci(N, Name).
query_by_price_range(Min, Max, Book) :- book(Book), Book = (_, P, _), P =< Max, P >= Min.



/* ********************* list-based approach *********************** */

print_list_body([]).
print_list_body([T|R]) :- print_row(T), nl, print_list_body(R).

print_list(Books) :- print_head, print_list_body(Books).

list_all(Books) :- findall(B, book(B), Books).
list_all_by_name(Name, Books) :- findall(B, query_by_name(Name, B), Books).
list_all_by_price_range(Min, Max, Books) :- findall(B, query_by_price_range(Min, Max, B), Books).

print_all :- list_all(Books), print_list(Books).
print_all_by_name(Name) :- list_all_by_name(Name, Books), print_list(Books).
print_all_by_price_range(Min, Max) :- list_all_by_price_range(Min, Max, Books), print_list(Books).



/* ********************* manual-coded approach ********************* */

mprint_all :- print_head, book(B), print_row(B), nl, fail.
mprint_all_by_name(Name) :- print_head, query_by_name(Name, B), print_row(B), nl, fail.
mprint_all_by_price_range(Min, Max) :- print_head, query_by_price_range(Min, Max, B), print_row(B), nl, fail.
