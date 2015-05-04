%turn business data into format we can create decision trees, cells with columns for attribute names 
function [category_table] =  setupCategoryBusinessData(business_data, category_names)
category_cells = zeros(length(business_data), length(category_names));

counter =1;
while(counter <= length(business_data))
    if gt(length(business_data(counter).categories), 0)
        for fname = business_data(counter).categories(1,:)
            for k=1:length(fname)
                name = strsplit(fname{k});
                newname = name{1};
                index = find(strcmp(category_names, newname));
                if not(isempty(index))
                    category_cells(counter,index) = 1;
                end
            end
        end
    end
    if gt(length(fieldnames(business_data(counter).hours)), 0)
        for fname = fieldnames(business_data(counter).hours(1,:))
            for k=1:length(fname)
                category_cells(counter,find(strcmp(category_names, fname{k}))) = 1;
            end
        end
    end 
    rating = business_data(counter).stars;
    if (rating > 3.0)
        category_cells(counter, end) = 1;
    end
    counter = counter + 1;
end
%remove unneeded characters from variable names
fixed_category_names = {};
fixed_category_names = strrep(strrep(category_names, '&', '_'), ' ', '_');
fixed_category_names = strrep(strrep(fixed_category_names, '(', '_'), ')', '_');
fixed_category_names = strrep(strrep(fixed_category_names, '-', '_'), ',', '_');
fixed_category_names = strrep(strrep(fixed_category_names, char(39), '_'), '/', '');
%convert array to table with column names


category_table = array2table(category_cells, 'VariableNames', fixed_category_names);
clear('category_cells');
clear('fixed_category_names');