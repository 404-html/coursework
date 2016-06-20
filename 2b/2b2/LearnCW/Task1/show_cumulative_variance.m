clf;
hold on;
plot([1:100]',cumsum(EVals),'b');
scatter([1:100]',cumsum(EVals),100,'.b');
axis([1,100,0,60]);
line90 = 0.9* sum(EVals);
line([1,100],[line90,line90]);
hold off;