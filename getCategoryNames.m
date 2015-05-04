%import business_data into workspace, find a list of all unique attributes
%load(business_data.mat)
function [category_names] = getCategoryNames(business_data)
counter=1;
category_names={};
%add days of week open as an attribute
category_names{end+1} = 'Monday';
category_names{end+1} = 'Tuesday';
category_names{end+1} = 'Wednesday';
category_names{end+1} = 'Thursday';
category_names{end+1} = 'Friday';
category_names{end+1} = 'Saturday';
category_names{end+1} = 'Sunday';
unique_category_names = {};
all_category_names = {};
while counter <= length(business_data)
    if gt(length(business_data(counter).categories), 0)
        for fname = business_data(counter).categories(1,:)
            for k=1:length(fname)
                %only get first word of category to combine types
                name = strsplit(fname{k});
                newname = name{1};
                if isempty(find(strcmp(unique_category_names, newname)))
                    unique_category_names{end+1} = newname;
                end
                all_category_names{end+1} = newname;
            end
        end
    end
    counter = counter+1;
end

counter = 1;
for aname = unique_category_names(1,:)
    %disregard uncommon types of business
    if length(find(strcmp(all_category_names, aname))) >= 20
        category_names{end+1} = aname{1};
    end
    counter = counter + 1;
end
category_names{end+1} = 'HighRating';
clear('unique_category_names');
clear('all_category_names');
