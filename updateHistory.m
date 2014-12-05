function historyMatrix = updateHistory(bBoxInfo, binaryImage, historyMatrix, show)

	for i = 1 : 4
		bBoxInfo(i) = round(bBoxInfo(i));
	end

	for row = bBoxInfo(1) : bBoxInfo(3)
		for col = bBoxInfo(2) : bBoxInfo(4)
			if historyMatrix(col,row) > 0
				historyMatrix(col,row) = historyMatrix(col,row) - 10;
			end
			if binaryImage(col,row) > 0
				historyMatrix(col,row) = 255;
			end
		end
	end
	if show > 0
		figure(show);
		imshow(mat2gray(historyMatrix));
	end
end

