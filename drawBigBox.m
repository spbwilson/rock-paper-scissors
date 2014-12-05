function bigBox = drawBigbox(bBoxInfo,historyImage,fig)
	
	if fig > 0
		figure(fig);
		imshow(mat2gray(historyImage));
		hold on;

		line(bBoxInfo(1), bBoxInfo(2));
		line(bBoxInfo(3), bBoxInfo(4));
				
		x = [bBoxInfo(1) bBoxInfo(3) bBoxInfo(3) bBoxInfo(1) bBoxInfo(1)];
		y = [bBoxInfo(2) bBoxInfo(2) bBoxInfo(4) bBoxInfo(4) bBoxInfo(2)];
		plot(x, y, 'LineWidth', 2);
		hold off;
	end
end
