%get classified data, confusion matrix as well as feature importance%

%load(attribute_classifier.mat)
Y = trainedAttributeClassifier.Y;
X = trainedAttributeClassifier.X;
%from matlab site to get feature importance
tree_bag = TreeBagger(5,X,Y,'OOBPred','On', 'OOBVarImp', 'On');
Yclassified = predict(attributeClassifier, X);

confusion_matrix = confusionmat(Y,Yclassified);
%from matlab site to visualize confusion matrix
heatmap(confusion_matrix, {'No', 'Yes'}, {'No','Yes'}, 1,'Colormap','red','ShowAllTicks',1,'UseLogColorMap',true,'Colorbar',true);
disp(confusion_matrix)
classification_error = abs(tree_bag.OOBPermutedVarDeltaMeanMargin);
classification_success = abs(tree_bag.OOBPermutedVarCountRaiseMargin);

topErrors = {}
topSuccess = {}
counter = 1;
while counter <=10
    [temp1 temp2] = max(classification_error)
    topErrors{end+1} = attribute_names{temp2};
    classification_error(temp2) = 0;
    
    [temp3 temp4] = max(classification_success);
    topSuccess{end+1} = attribute_names{temp4};
    classification_success(temp4) = 0;
    counter = counter + 1;
end
disp('Top Error Features')
disp(topErrors)

disp('Top Success Features')
disp(topSuccess)
    
    