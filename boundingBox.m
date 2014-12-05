function box = boundingBox(binaryImage, show)

	pHeight = 540;
	pWidth = 960;

	regions = regionprops(binaryImage, 'all');
	numRegions = size(regions, 1);
	
	%--Display figure if not zero
	if show > 0
        figure(show);
        imshow(binaryImage);
	end

	%--Get the largest bounding box
	largestArea = 0;
	boxIndex = 0;
	for k = 1 : numRegions
		if regions(k).Area > largestArea
			largestArea = regions(k).Area;
			boxIndex = k;
		end
	end

	if (boxIndex ~= 0) && (regions(boxIndex).Area < 100)
		boxIndex = 0;
	end

	%--If bounding box found..	
	if boxIndex > 0
   		box = regions(boxIndex).BoundingBox;
		xMin = box(1);
		yMin = box(2);
		xMax = xMin + box(3);
		yMax = yMin + box(4);

		hold on
		line(xMin, yMin);
		line(xMax, yMax);
    		
		x = [xMin xMax xMax xMin xMin];
		y = [yMin yMin yMax yMax yMin];
		if show > 0
			plot(x, y, 'LineWidth', 2);
		end
		hold off

	%--If no box found..
	else
		box = 0;
		display('No hand detected');
	end
end
