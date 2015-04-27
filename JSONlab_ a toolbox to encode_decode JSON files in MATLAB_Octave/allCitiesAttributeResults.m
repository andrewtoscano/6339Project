% show data for every city

load('business_data.mat');
attribute_names = getAttributeNames(business_data);
city_names = getCityNames();
top_attribute_names = {};
for k=1:length(city_names)
    disp(city_names{k});
    city_count = getCityCount(business_data, city_names{k})
    [current_table temp_attribute_names] = setupCityAttributeBusinessData(business_data, attribute_names, city_names{k}, city_count);
    temp_attr = displayAttributeResultsFunction(current_table, temp_attribute_names, city_names{k});
    for(k=1:length(temp_attr))
        top_attribute_names{end+1} = temp_attr{k};
    end
end

%get which attribute showed up the most throughout cities
unique_attribute_names = {};
for k=1:length(top_attribute_names)
    if isempty(find(strcmp(unique_attribute_names, top_attribute_names{k})))
        unique_attribute_names{end+1} = top_attribute_names{k};
    end
end

attr_count = zeros([1, length(unique_attribute_names)]);
for k=1:length(unique_attribute_names)
    attr_count(k) = length(find(strcmp(unique_attribute_names{k}, top_attribute_names)));
end

topResults = zeros([1,10]);
resultNames = {};
counter = 1;
while counter <=10
    [temp1, temp2] = max(attr_count);
    topResults(counter) = temp1;
    resultNames{end+1} = unique_attribute_names{temp2};
    attr_count(temp2) = 0;
    counter = counter + 1;
end
title = strcat('Top Features for All Cities');
xlabel ='Attributes';
ylabel = 'Number of Cities Appeared';
filename = 'cityFeatureCount.fig';
bar = displayBarGraph(resultNames, topResults, xlabel, ylabel, title, filename);
