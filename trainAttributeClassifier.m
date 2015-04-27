function [trainedClassifier, validationAccuracy] = trainAttributeClassifier(datasetTable)
% Extract predictors and response
predictorNames = {'ByAppointmentOnly', 'HappyHour', 'AcceptsCreditCards', 'GoodForGroups', 'OutdoorSeating', 'PriceRange', 'GoodforKids', 'Alcohol', 'NoiseLevel', 'HasTV', 'Attire', 'Ambience', 'GoodForDancing', 'Delivery', 'CoatCheck', 'Smoking', 'Takeout', 'TakesReservations', 'WaiterService', 'WiFi', 'Caters', 'GoodFor', 'Parking', 'Music', 'DriveThru', 'WheelchairAccessible', 'BYOB', 'Corkage', 'BYOBCorkage', 'OrderatCounter', 'GoodForKids', 'DogsAllowed', 'Open24Hours', 'HairTypesSpecializedIn', 'AcceptsInsurance', 'AgesAllowed', 'PaymentTypes', 'DietaryRestrictions'};
predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.HighRating;
% Train a classifier
trainedClassifier = fitensemble(predictors, response, 'Bag', 50, 'Tree', 'Type', 'Classification', 'PredictorNames', {'ByAppointmentOnly' 'HappyHour' 'AcceptsCreditCards' 'GoodForGroups' 'OutdoorSeating' 'PriceRange' 'GoodforKids' 'Alcohol' 'NoiseLevel' 'HasTV' 'Attire' 'Ambience' 'GoodForDancing' 'Delivery' 'CoatCheck' 'Smoking' 'Takeout' 'TakesReservations' 'WaiterService' 'WiFi' 'Caters' 'GoodFor' 'Parking' 'Music' 'DriveThru' 'WheelchairAccessible' 'BYOB' 'Corkage' 'BYOBCorkage' 'OrderatCounter' 'GoodForKids' 'DogsAllowed' 'Open24Hours' 'HairTypesSpecializedIn' 'AcceptsInsurance' 'AgesAllowed' 'PaymentTypes' 'DietaryRestrictions'}, 'ResponseName', 'HighRating', 'ClassNames', [0 1]);

% Perform cross-validation
partitionedModel = crossval(trainedClassifier, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

%% Uncomment this section to compute validation predictions and scores:
% % Compute validation predictions and scores
% [validationPredictions, validationScores] = kfoldPredict(partitionedModel);