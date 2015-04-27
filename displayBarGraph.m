function [graph] = displayBarGraph(xValues, yValues, xAxis, yAxis, tName, filename)
reset(gca)
graph = bar(yValues);
set(graph, 'FaceColor', 'blue')
title(tName);
xlabel(xAxis);
ylabel(yAxis);
set(gca, 'XTick', 1:10, 'XTickLabel', xValues);
saveas(gca, filename)