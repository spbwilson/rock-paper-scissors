%--This is passed either train, paper, rock or scissors
function fVectors = getFeatureVectors(folderDir,background)

folderList = dir(folderDir);
fVectors = zeros(length(folderList)-2,6);

%---------For each sequence------------
for i = 3 : (length(folderList))
	nextDir = strcat(folderDir,folderList(i).name);
	fileList = dir(nextDir);
	historyMatrix = mat2gray(zeros(540, 960));
	xMin = 960;
	yMin = 540;
	xMax = 0;
	yMax = 0;
	bBoxInfo = [xMin, yMin, xMax, yMax];
	cuv = 0;

	%---------For each picture---------
	for k = 3 : (length(fileList))
		fileName = fileList(k).name;
		disp(fileName);

		%--Get difference
		filePath = strcat('train/', folderList(i).name, '/');
		disp(filePath);
		hand = getDifference(background, filePath, fileName, 0);

		%--Turn to bw
		doHist(hand, 20);
		whiteHand = doThresh(hand, 40, 0);
		binaryImage = cleanup(whiteHand, 3, 3, 0);
		
		%--Get bounding boxes
		box = boundingBox(binaryImage, 0);

		if box ~= 0
			if box(1) < xMin
				xMin = box(1);
			end
			if box(2) < yMin
				yMin = box(2);
			end
			if (box(3) + box(1)) > xMax
				xMax = box(1) + box(3);
			end
			if (box(4) + box(2)) > yMax
				yMax = box(2) + box(4);
			end
		end

		bBoxInfo = [xMin, yMin, xMax, yMax];

		%--MHI--don't do until hand seen
		if (xMin < xMax)
			historyMatrix = updateHistory(bBoxInfo, binaryImage, historyMatrix, 0);
		end
	end
	
	%--Draw big box
	%drawBigBox(bBoxInfo,historyMatrix,0);

	%--Change to gray scale and crop
	cropSize = [bBoxInfo(1), bBoxInfo(2), (bBoxInfo(3) - bBoxInfo(1)), (bBoxInfo(4) - bBoxInfo(2))];
	historyMatrix = mat2gray(historyMatrix);
	historyMatrix = imcrop(historyMatrix, cropSize);
	figure(2);
	imshow(historyMatrix);

	%---------Get feature vector-------
	
	%--Calculate area
	area = sum(sum(bwlabel(historyMatrix)));
	perim = bwarea(bwperim(historyMatrix,8));

	%--Scale and translation invariant
	s11 = (translationInvariant(1,1,area,historyMatrix)) / area^2;
	s20 = (translationInvariant(2,0,area,historyMatrix)) / area^2;
	s21 = (translationInvariant(2,1,area,historyMatrix)) / area^2.5;
	s12 = (translationInvariant(1,2,area,historyMatrix)) / area^2.5;
	s30 = (translationInvariant(3,0,area,historyMatrix)) / area^2.5;

	%--Rotation, scale and translation invariant
	ci1 = real(s11);
	ci2 = real(1000 * s21 * s12);
	ci3 = 10000 * real(s20 * s12 * s12);
	ci4 = 10000 * imag(s20 * s12 * s12);
	ci5 = 1000000 * real(s30 * s12 * s12 * s12);
	ci6 = 1000000 * imag(s30 * s12 * s12 * s12);

	compactness = (perim*perim) / (4*pi*area);

	fVector = [compactness,ci1,ci2,ci3,ci4,ci5]
	fVectors(i-2,:) = fVector;
end
