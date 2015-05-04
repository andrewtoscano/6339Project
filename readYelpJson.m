% parse json line by line, save as mat file
fid = fopen('yelp_academic_dataset_business.json');

tline = fgetl(fid);
counter = 1;
business_data = struct([]);
while ischar(tline)
    disp(tline);
    business_data(counter) = loadjson(tline);
    tline = fgetl(fid);
    counter = counter+1;
end

fclose(fid);

save('business_data.mat', 'business_data')