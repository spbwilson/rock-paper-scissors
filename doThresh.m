function threshImage = doThresh(image,threshold,show)
    num = 1;                % used to set the number of times image is sized
    [m,n,num] = size(image);

    for row = 1 : m         % = 640 (width)
        for col = 1 : n     % = 480 (height)
            if image(row,col) < threshold
              threshImage(row,col) = 0;
            else
              threshImage(row,col) = 1;
            end
        end
    end
    if show > 0
        figure(show)
        imshow(threshImage)
    end
end
    
