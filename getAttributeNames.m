function [attribute_names] = getAttributeNames(business_data)
counter=1;
attribute_names={};
while counter <= length(business_data)
    fields = fieldnames(business_data(counter).attributes);
    if gt(length(fields), 0)
        for k=1:length(fields)
            if isempty(find(strcmp(attribute_names, fields{k})))
                attribute_names{end+1} = fields{k};
            end
        end
    end
    counter = counter + 1;
end
attribute_names{end+1} = 'HighRating';
