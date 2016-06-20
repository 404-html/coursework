% ---------------------------------------------------------------------
%  ----- Informatics 2D - 2015/16 - Second Assignment - Planning -----
% ---------------------------------------------------------------------
%
% Write here you matriculation number (only - your name is not needed)
% Matriculation Number: s1413557
%
%
% ------------------------- Problem Instance --------------------------
% This file is a template for a problem instance: the definition of an
% initial state and of a goal. 

% debug(on).	% need additional debug information at runtime?



% --- Load domain definitions from an external file -------------------

:- ['domain-task21.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------
car(car).
agent(agent).
at(agent,park,s0).
at(car,park,s0).
nextTo(drop,park).
nextTo(park,drop).
nextTo(park,pick).
nextTo(pick,park).





% --- Goal condition that the planner will try to reach ---------------

goal(S) :-  at(agent,drop,S),parked(car,S).	       	% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
