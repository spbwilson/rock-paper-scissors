function avImage = averageImages(fileName1, fileName2, fig)

	background1 = importdata([fileName1, '.jpg'],'jpg');
	background2 = importdata([fileName2, '.jpg'],'jpg');
	
	avImage = (background1 + background2)/2;
	
	if fig > 0
		figure(fig);
		imshow(avImage);
	end
end
