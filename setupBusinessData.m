%turn business data into format we can create decision trees, cells with columns for attribute names 
%load('business_data.mat')
%load('attribute_names.mat')

attribute_cells = zeros(length(business_data), length(attribute_names));

counter =1;
while(counter <= length(business_data))
    if gt(length(business_data(counter).categories), 0)
        for fname = business_data(counter).categories(1,:)
            disp(fname)
            temp = fname;
            for k=1:length(fname)
                disp(fname{k})
                name = strsplit(fname{k});
                newname = name{1};
                index = find(strcmp(attribute_names, newname));
                if not(isempty(index))
                    attribute_cells(counter,index) = 1;
                end
            end
        end
    end
    if gt(length(fieldnames(business_data(counter).hours)), 0)
        for fname = fieldnames(business_data(counter).hours(1,:))
            disp(fname)
            temp = fname;
            for k=1:length(fname)
                disp(fname{k})
                attribute_cells(counter,find(strcmp(attribute_names, fname{k}))) = 1;
            end
        end
    end 
    rating = business_data(counter).stars;
    if (rating > 3.0)
        attribute_cells(counter, end) = 1;
    end
    counter = counter + 1;
end
%remove unneeded characters from variable names
fixed_attribute_names = {};
fixed_attribute_names = strrep(strrep(attribute_names, '&', '_'), ' ', '_');
fixed_attribute_names = strrep(strrep(fixed_attribute_names, '(', '_'), ')', '_');
fixed_attribute_names = strrep(strrep(fixed_attribute_names, '-', '_'), ',', '_');
fixed_attribute_names = strrep(strrep(fixed_attribute_names, char(39), '_'), '/', '');
%convert array to table with column names


attribute_table = array2table(attribute_cells, 'VariableNames', fixed_attribute_names);
%save('attribute_table.mat', attribute_table);