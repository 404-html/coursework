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
:- multifile nextTo/2, at/3, parked/2, delivered/2, car/1, agent/1, dirty/2.





% --- Primitive control actions ---------------------------------------
% this section defines the name and the number of parameters of the
% actions available to the planner
%
primitive_action( move(_) ).   % underscore means 'anything'
primitive_action( park(_) ).
primitive_action( drive(_,_) ).
primitive_action( deliver(_) ).
primitive_action( clean(_) ).





% --- Precondition for primitive actions ------------------------------
% describe when an action can be carried out, in a generic situation S
%
% poss( doSomething(...), S ) :- preconditions(..., S).
poss( move(Dest),S ) :-
  at(Agent,Start,S),
  nextTo(Start,Dest),
  agent(Agent).
poss( park(Car),S ) :-
  at(Agent,park,S),
  at(Car,park,S),
  not(parked(Car,S)),
  agent(Agent),
  car(Car).
poss( drive(Car,Dest),S ) :-
  at(Agent,Start,S),
  at(Car,Start,S),
  nextTo(Start,Dest),
  agent(Agent),
  car(Car).
poss( deliver(Car),S ) :-
  at(Agent,pick,S),
  at(Car,pick,S),
  agent(Agent),
  car(Car),
  not(dirty(Car,S)).

% the agent must clean the parked car before driving it to the pick-up area.
% i assume the park can only be cleaned when parked( it is weird to clean on street)  
poss( clean(Car),S ) :-
  at(Agent,park,S),
  parked(Car,S),
  agent(Agent),
  car(Car),
  dirty(Car,S).
  
  




% --- Successor state axioms ------------------------------------------
% describe the value of fluent based on the previous situation and the
% action chosen for the plan. 
%
% fluent(..., result(A,S)) :- positive; previous-state, not(negative)
parked( Car,result(A,S) ) :-
    A = park(Car), car(Car);
    parked(Car,S), not(A = drive(Car,_)).
delivered( Car,result(A,S) ) :-
    A = deliver(Car), car(Car);
    delivered(Car,S).
at( What,Where,result(A,S) ) :-
    A = move(Where), agent(What);
    A = drive(_,Where),agent(What);
    A = drive(What,Where),car(What);
    at(What,Where,S),not(A = move(_)),not(A = drive(_,_)),agent(What);
    at(What,Where,S),not(A = drive(What,_)),car(What).
dirty( Car,result(A,S) ) :-
    A = park(Car);
    dirty(Car,S), not(A=clean(Car)).




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
