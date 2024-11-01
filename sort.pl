%% my_append([],[],[]).

%% my_append(Xs, [], Xs).

%% my_append([],Ys,Ys).

%% my_append(Xs,Ys,Zs) :-
%%   my_append().

%% my_reverse([],Xs,Xs).


%% my_reverse([X],[X],[X]).

%% my_reverse([X|Xs],Zs) :-
%%   append(Ys,[X],),
%%   my_reverse(Xs, Zs).

split([],[],[]).

split([X],[X],[]).

split([Xa,Xb|Xs],[Xa|Ys],[Xb|Zs]) :-
  split(Xs,Ys,Zs).

merge([],[],[]).

merge(X,[],X).

merge([],X,X).

merge([X|Xs],[Y|Ys],[X|Zs]) :-
  X=<Y,
  merge(Xs,[Y|Ys],Zs).

merge([X|Xs],[Y|Ys],[Y|Zs]) :-
  Y<X,
  merge([X|Xs],Ys,Zs).

msort([],[]).

msort([X],[X]).

msort(Xs,Ys) :-
  split(Xs,Ls,Rs),
  msort(Ls,As),
  msort(Rs,Bs),
  merge(As,Bs,Ys).

partition(_,[],[],[]).

partition(X, [Y|Ys], [Y|Ls], Rs) :-
  Y=<X,
  partition(X,Ys,Ls,Rs).

partition(X, [Y|Ys], Ls, [Y|Rs]) :-
  Y>X,
  partition(X,Ys,Ls,Rs).

qsort([],[]).

qsort([X],[X]).

qsort([X|Xs],Ys) :-
  partition(X,Xs,Ls,Rs),
  qsort(Ls,As),
  qsort(Rs,Bs),
  append(As,[X|Bs],Ys).

ordered([]).

ordered([_]).

ordered([Xa,Xb|Xs]) :-
  Xa=<Xb,
  ordered([Xb|Xs]).

shift([],[]).

shift([X],[X]).

shift([Xa,Xb|Xs],[Xa|Ys]) :-
  Xa=<Xb,
  shift([Xb|Xs],Ys).


shift([Xa,Xb|Xs],[Xb|Ys]) :-
  Xa>Xb,
  shift([Xa|Xs],Ys).

bsort([],[]).

bsort([X],[X]).

bsort(Xs,Xs) :-
  ordered(Xs).

bsort(Xs,Zs) :-
  %% not(ordered(Xs)),
  shift(Xs,Ys),
  bsort(Ys,Zs).
