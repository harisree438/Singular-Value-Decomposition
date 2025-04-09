% Load an image
originalImage = imread("D:\Photos(jpg,jpeg,etc)\th (4).jpg");

% Convert the image to grayscale if it's a color image
if size(originalImage, 3) == 3
    grayscale_Image = rgb2gray(originalImage);
end

% Convert the image to double precision
grayscale_Image = double(grayscale_Image);

while true
    % Prompt the user for compression factor
    compressionFactor = input('Enter compression factor (between 0 and 1): ');
    
    % Check if compression factor is within range
    if compressionFactor >= 0 && compressionFactor <= 1
        break; % Exit the loop if valid compression factor is provided
    else
        disp('Invalid compression factor. Please enter a value between 0 and 1.');
    end
end

% Perform Singular Value Decomposition (SVD)
[U, S, V] = svd(grayscale_Image);

% Set the number of singular values to keep (compression factor)
numSingularValues = round(compressionFactor * min(size(S)));

% Keep only the first 'numSingularValues' singular values
U_compressed = U(:, 1:numSingularValues);
S_compressed = S(1:numSingularValues, 1:numSingularValues);
V_compressed = V(:, 1:numSingularValues);

% Reconstruct the compressed image
compressedImage = U_compressed * S_compressed * V_compressed';

% Display the original 
subplot(1, 3, 1);
imshow(uint8(originalImage));
title('Original Image');

% Displaying Grayscale image
subplot(1 , 3, 2);
imshow(uint8(grayscale_Image));
title('Grayscale image');

% Displaying Compressed image
subplot(1, 3, 3);
imshow(uint8(compressedImage));
title(['Compressed Image (', num2str(compressionFactor * 100), '%)']);

% Save the grayscale image
imagefile = 'Obtained Grayscale image.jpeg';
imwrite(uint8(grayscale_Image), imagefile);

% Save the compressed image
imagefile1 = 'Final Compressed image.jpeg';
imwrite(uint8(compressedImage), imagefile1);
