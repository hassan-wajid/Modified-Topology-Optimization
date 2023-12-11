function DataLoader(folderLocation, ~)
% Get all image files in the folder
file_extensions = {'*.jpg', '*.jpeg', '*.png'};

% Initialize an empty array to store all file information
file_list = [];

% Loop through each file extension
for i = 1:length(file_extensions)
    % Get the list of files for the current extension
    current_files = dir(fullfile(folderLocation,file_extensions{i}));
    
    % Append the current file list to the overall list
    imageFiles = [file_list; current_files];
end
display(imageFiles(1).name)
% Loop through each image file
for i = 1:length(imageFiles)
    % Get the full image path
    imagePath = fullfile(folderLocation, imageFiles(i).name);
    
    % Read the image
    try
        image = imread(imagePath);
        binaryWheel = double(imbinarize(image));
        %disp(binaryWheel)
        % Adjust nelx and nely based on the image size
        nelx = size(binaryWheel, 2); % Number of elements in x-direction
        nely = size(binaryWheel, 1); % Number of elements in y-direction
    catch
        warning('Failed to read image: %s', imagePath);
        continue;
    end
    
    % Pass the image to the function
    try
        [A,B] = calculateVolumes(binaryWheel);
        phys = top88(nelx,nely, (A/100),2.6,2.2,2,binaryWheel);

        randomFileName = tempname;
        randomFileName = strcat(randomFileName, '.jpeg');
        
        imwrite(real(phys), randomFileName, 'Quality', 99);
        fprintf('Final xPhys saved as %s.\n', randomFileName);
        default_folder = "optimised2/";
        % Generate a unique name for each image (you can modify this as needed)
        imageName = sprintf('image%d.png', i);
        % Assuming imageData{i} contains the actual image data
        imwrite(real(phys), fullfile(default_folder, imageName));


    catch e
        warning('Error processing image: %s (%s)', imagePath, e.message);
    end
end
end
