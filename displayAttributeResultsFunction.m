function [errorNames] = displayAttributeResultsFunction(attribute_table, attribute_names, city_name)
[trainedAttributeClassifier, attributeValidationAccuracy] = trainAttributeClassifier(attribute_table);

Y = trainedAttributeClassifier.Y;
X = trainedAttributeClassifier.X;

Yclassified = predict(trainedAttributeClassifier, X);

confusion_matrix = confusionmat(Y,Yclassified);
%from matlab site to visualize confusion matrix
attributeMatrix = heatmap(confusion_matrix, {'False', 'True'}, {'False','True'}, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);
disp(confusion_matrix)
filename = strcat(city_name, 'AttributeConfusionMatrix.fig');
saveas(attributeMatrix, filename);

%from matlab site to get feature importance
tree_bag = TreeBagger(150,X,Y,'OOBPred','On', 'OOBVarImp', 'On');
classification_error = tree_bag.OOBPermutedVarDeltaError;

topErrors = zeros([1,10]);
errorNames = {};
counter = 1;
while counter <=10
    [temp1, temp2] = max(classification_error);
    topErrors(counter) = temp1;
    errorNames{end+1} = attribute_names{temp2};
    classification_error(temp2) = 0;
    counter = counter + 1;
end

%code from matlab seminar at UTA



title = strcat('Out of Bag Feature Importance for Attributes in ', city_name);
xlabel ='Attributes';
ylabel = 'Relative Feature Importance Score';
filename = strcat(city_name, 'OOBImportanceGraph.fig');
bar = displayBarGraph(errorNames, topErrors, xlabel, ylabel, title, filename);

