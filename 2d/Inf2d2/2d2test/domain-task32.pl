% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1413557
%
%
% ------------------------- Domain Definition -------------------------
% This file describes a planning domain: a set of predicates and
% fluents that describe the state of the system, a set of actions and
% the axioms related to them. More than one problem can use the same
% domain definition, and therefore include this file


% --- Cross-file definitions ------------------------------------------
% marks the predicates whose definition is spread across two or more
% files
%
:- multifile parked/2, car/1, holding/2, stored/2, poss/2.





% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
primitive_action( grab(_) ).
primitive_action( store(_) ).
primitive_action( nothing ).





% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
% poss( doSomething(...), S ) :- preconditions(..., S).

poss( grab(Car) ) :-
  parked(Car,S),
  stored(Car,S),
  car(Car).

poss( store(Car) ) :-
  parked(Car,S),
  holding(Car,S),
  car(Car).
poss( nothing ) :-
  car(_).
  




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)
parked( Car,result(_,S) ) :-
    parked(Car,S).
holding( Car,result(A,S) ) :-
    A = grab(Car);
    holding(Car,S), not(A = store(_)).
stored( Car,result(A,S) ) :-
    A = store(Car);
    stored(Car,S), not(A = grab(Car)).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
