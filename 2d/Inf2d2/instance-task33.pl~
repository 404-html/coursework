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

:- ['domain-task31.pl'].		% Replace with the domain for this problem




% --- Definition of the initial state ---------------------------------
agent(agent).
car(carA).
car(carB).
at(agent,drop,s0).
at(carA,park,s0).
at(carB,drop,s0).
parked(carA,s0).
dirty(carA,s0).
nextTo(drop,park).
nextTo(park,drop).
nextTo(park,pick).
nextTo(pick,park).





% --- Goal condition that the planner will try to reach ---------------

goal(S) :-  at(agent,drop,S),parked(carB,S),delivered(carA,S). 	% fill in the goal definition




% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
