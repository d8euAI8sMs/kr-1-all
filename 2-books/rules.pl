
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

table_rule("~0||~45t~59||~45t~6+|~45t~6+|").
table_column_format("~0||~w~59||~t~w~6+|~t~w~6+|").
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
mprint_all.
mprint_all_by_name(Name) :- print_head, query_by_name(Name, B), print_row(B), nl, fail.
mprint_all_by_name(_).
mprint_all_by_price_range(Min, Max) :- print_head, query_by_price_range(Min, Max, B), print_row(B), nl, fail.
mprint_all_by_price_range(_, _).



/* *********************** user interaction ************************* */

ui_get_input(Prompt, String) :- prompt1(Prompt), read(String).

ui_check_bool(true, Bool) :- Bool = true.
ui_check_bool(_, Bool) :- Bool = false.

ui_ask_write_to_file(Bool) :-
    ui_get_input("Write to file (true, false)? ", T),
    ui_check_bool(T, Bool).

ui_do_if(true, What, PostActionOnSuccess, _) :- What, PostActionOnSuccess.
ui_do_if(false, _, _, PostActionOnFailure) :- PostActionOnFailure.

ui_do_and_check_write_to_file(What, File) :-
    What,
    ui_ask_write_to_file(B),
    ui_do_if(B, with_output_to(File, What),
                write("[info] The data was successfully stored."),
                write("[info] The data was not stored.")).

ui_open_file(File) :- open("output.txt", write, File).
ui_do_while_open(File, What) :- ui_open_file(File), What, close(File).

ui_do_and_check_write_to_file(What) :-
    ui_do_while_open(F, ui_do_and_check_write_to_file(What, F)).

ui_print_all :-
    ui_do_and_check_write_to_file(mprint_all).
ui_print_all_by_name :-
    ui_get_input("Name: ", N),
    ui_do_and_check_write_to_file(mprint_all_by_name(N)).
ui_print_all_by_price_range :-
    ui_get_input("Price Range (Min, Max): ", (Min, Max)),
    ui_do_and_check_write_to_file(mprint_all_by_price_range(Min, Max)).

ui_main :-
    prompt1("Please, enter command ('help' for help): "),
    read(C),
    ui_command(C).

ui_command(help) :-
    write("=== Book Store CLI Application Help ==="), nl,
    write("type 'help'  to read this help again"), nl,
    write("type 'all'   to list all available books"), nl,
    write("type 'name'  to filter available books by the given name"), nl,
    write("type 'price' to filter the books by the given price range"), nl.

ui_command(all) :- ui_print_all.
ui_command(name) :- ui_print_all_by_name.
ui_command(price) :- ui_print_all_by_price_range.
