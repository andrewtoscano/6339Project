%import business_data into workspace, find a list of all unique attributes
%load(business_data.mat)
counter=1;
attribute_names={};
%add days of week open as an attribute
attribute_names{end+1} = 'Monday';
attribute_names{end+1} = 'Tuesday';
attribute_names{end+1} = 'Wednesday';
attribute_names{end+1} = 'Thursday';
attribute_names{end+1} = 'Friday';
attribute_names{end+1} = 'Saturday';
attribute_names{end+1} = 'Sunday';
unique_attribute_names = {};
all_attribute_names = {};
while counter <= length(business_data)
    if gt(length(business_data(counter).categories), 0)
        for fname = business_data(counter).categories(1,:)
            disp(fname)
            temp = fname;
            for k=1:length(fname)
                disp(fname{k})
                %only get first word of category to combine types
                name = strsplit(fname{k});
                newname = name{1};
                if isempty(find(strcmp(unique_attribute_names, newname)))
                    unique_attribute_names{end+1} = newname;
                end
                all_attribute_names{end+1} = newname;
            end
        end
    end
    counter = counter+1;
end

counter = 1;
for aname = unique_attribute_names(1,:)
    %disregard uncommon types of business
    if length(find(strcmp(all_attribute_names, aname))) >= 20
        attribute_names{end+1} = aname{1};
    end
    counter = counter + 1;
end
attribute_names{end+1} = 'Rating3StarsOrHigher';
save('attribute_names.mat', 'attribute_names')
