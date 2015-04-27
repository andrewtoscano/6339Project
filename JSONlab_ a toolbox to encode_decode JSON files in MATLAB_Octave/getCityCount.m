function [city_count] = getCityCount(business_data, city_name)
city_count = 0;
counter = 1;
while counter < length(business_data)
    if strcmp(business_data(counter).city, city_name) 
        city_count = city_count + 1;
    end
    counter = counter + 1;
end