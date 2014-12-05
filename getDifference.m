function difImage = getDifference(background, filePath, fileName, fig)

	cd(filePath);
	nextImage = importdata(fileName,'jpg');
	cd ../..;

	difImage = abs(nextImage - background);
	
	if fig > 0
		figure(fig);
		imshow(difImage);
	end
end
