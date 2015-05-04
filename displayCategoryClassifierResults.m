%get classified data, confusion matrix as well as feature importance%

load(business_data.mat)
category_names = getCategoryNames(business_data);
category_table = setupCategoryBusinessData(business_data, category_names);
[trainedCategoryClassifier, categoryValidationAccuracy] = trainCategoryClassifier(category_table);

Y = trainedCategoryClassifier.Y;
X = trainedCategoryClassifier.X;

Yclassified = predict(trainedCategoryClassifier, X);

confusion_matrix = confusionmat(Y,Yclassified);
%from matlab site to visualize confusion matrix
categoryMatrix = heatmap(confusion_matrix, {'False', 'True'}, {'False','True'}, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);
disp(confusion_matrix)

%from matlab site to get feature importance
tree_bag = TreeBagger(15,X,Y,'OOBPred','On', 'OOBVarImp', 'On');
saveas(categoryMatrix, 'categoryClassifierConfusionMatrix.fig');
classification_error = tree_bag.OOBPermutedVarDeltaError;

topErrors = zeros([1,10]);
errorNames = {};
counter = 1;
while counter <=10
    [temp1, temp2] = max(classification_error);
    topErrors(counter) = temp1;
    errorNames{end+1} = category_names{temp2};
    classification_error(temp2) = 0;
    counter = counter + 1;
end
title = 'Out of Bag Feature Importance for Categories in All Cities';
xlabel ='Category';
ylabel = 'Relative Feature Importance Score';
filename = 'categoryOOBImportance.fig';
bar1 = displayBarGraph(errorNames, topErrors, xlabel, ylabel, title, filename)
category_tree_bag = tree_bag;
save('category_classified.mat', 'trainedCategoryClassifier', 'category_names', 'category_table', 'category_tree_bag');


    