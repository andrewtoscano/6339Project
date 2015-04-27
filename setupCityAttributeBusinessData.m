%turn attribute names into data usable to create decision trees
function [attribute_table, attribute_names] =  setupCityAttributeBusinessData(business_data, attribute_names, city_name, city_count)
attribute_cells = zeros(city_count, length(attribute_names));
field_struct = {};
value_struct = {};
counter =1;
cityCounter = 1;
while(counter <= length(business_data))
    if strcmp(business_data(counter).city, city_name) 
        attr = business_data(counter).attributes;
        fields = fieldnames(attr);
        if gt(length(fields), 0);
            for k=1:length(fields)
                index = find(strcmp(attribute_names, fields{k}));
                value = attr.(fields{k});
                if isstruct(value)
                    innerfields = fieldnames(value);
                    if gt(length(innerfields), 0)
                        for j=1:length(innerfields)
                            innervalue = value.(innerfields{j});
                            if(innervalue ~= 0)
                                spindex = find(strcmp(field_struct, innerfields{j}));
                                if isempty(spindex)
                                    field_struct{end+1} = innerfields{j};
                                    attribute_cells(cityCounter,index) = length(field_struct);
                                else
                                    attribute_cells(cityCounter,index) = spindex;
                                end
                            end
                        end
                    end
                else
                    if (ischar(value))
                        spindex = find(strcmp(value_struct, value));
                        if not(isempty(spindex))
                            attribute_cells(cityCounter,index) = spindex;
                        else
                            value_struct{end+1} = value;
                            attribute_cells(cityCounter,index) = length(value_struct);
                        end
                    else
                        attribute_cells(cityCounter,index) = value;
                    end
                end
            end
        end
        rating = business_data(counter).stars;
        if (rating > 3.0)
            attribute_cells(cityCounter, end) = 1;
        end
        cityCounter = cityCounter + 1;
    end
    counter = counter + 1;
end


attribute_names = strrep(strrep(attribute_names, '_0x20_', ''), '_0x2D_', '');
attribute_names = strrep(attribute_names, '_0x2F_', '');
attribute_table = array2table(attribute_cells, 'VariableNames', attribute_names);
       