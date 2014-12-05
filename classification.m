function result = classification(Vecs,Classes)

	Dim = 6;
	
	counter = 0;

	trainingData = zeros(21,Dim);
	trainingClasses = [1;1;1;1;1;1;1;2;2;2;2;2;2;2;3;3;3;3;3;3;3]
	
	confusionMatrix = zeros(3,3);
	
	rockSamples = find(Classes == 1);
	rockVectors = Vecs(rockSamples,:)
	
	paperSamples = find(Classes == 2);
	paperVectors = Vecs(paperSamples,:)
	
	scissorsSamples = find(Classes == 3);
	scissorsVectors = Vecs(scissorsSamples,:)

	for i = 1 : 8
	
		tempRockVectors = rockVectors;
		tempPaperVectors = paperVectors;
		tempScissorsVectors = scissorsVectors;

		%--Reduce training set to 7
		tempRockVectors(i,:) = [];
		tempPaperVectors(i,:) = [];
		tempScissorsVectors(i,:) = [];

		
		trainingData(1:7,:) = tempRockVectors;
		trainingData(8:14,:) = tempPaperVectors;
		trainingData(15:21,:) = tempScissorsVectors;
		
		[Means,Invcors,Aprioris] = buildmodel(Dim,trainingData,21,3,trainingClasses);
		
		disp('i =');
		disp(i);
		rockResult = classify(rockVectors(i,:),3,Means,Invcors,Dim,Aprioris);
		paperResult = classify(paperVectors(i,:),3,Means,Invcors,Dim,Aprioris);
		scissorsResult = classify(scissorsVectors(i,:),3,Means,Invcors,Dim,Aprioris);
		
		disp(rockResult);
		disp(paperResult);
		disp(scissorsResult);
		
		if (rockResult == 1)
			counter = counter + 1;
			confusionMatrix(1,1) = confusionMatrix(1,1) + 1;
		elseif (rockResult == 2)
			confusionMatrix(1,2) = confusionMatrix(1,2) + 1;
		else
			confusionMatrix(1,3) = confusionMatrix(1,3) + 1;
		end
		
		if (paperResult == 2)
			counter = counter + 1;
			confusionMatrix(2,2) = confusionMatrix(2,2) + 1;
		elseif (paperResult == 1)
			confusionMatrix(2,1) = confusionMatrix(2,1) + 1;
		else
			confusionMatrix(2,3) = confusionMatrix(2,3) + 1;
		end
		
		if (scissorsResult == 3)
			counter = counter + 1;
			confusionMatrix(3,3) = confusionMatrix(3,3) + 1;
		elseif (scissorsResult == 1)
			confusionMatrix(3,1) = confusionMatrix(3,1) + 1;
		else
			confusionMatrix(3,2) = confusionMatrix(3,2) + 1;
		end
	end
	
	result = (counter / 24) * 100
	confusionMatrix
end
