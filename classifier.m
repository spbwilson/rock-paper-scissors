%function [classFeatures, classError] = classifier(background)

background = averageImages('background1', 'background2', 0);

%--Get a list of all folders in train
rootDir = cd;
actionDir = strcat(rootDir, '/actions/');
rockDir = strcat(actionDir, '/rock/');
paperDir = strcat(actionDir, '/paper/');
scissorsDir = strcat(actionDir, '/scissors/');

folderList = dir(actionDir);

rockList = dir(rockDir);
paperList = dir(paperDir);
scissorsList = dir(scissorsDir);

rockfVectors = getFeatureVectors(rockDir, background);
paperfVectors = getFeatureVectors(paperDir, background);
scissorsfVectors = getFeatureVectors(scissorsDir, background);

foldRockError = zeros(1,7);
foldPaperError = zeros(1,7);
foldScissorsError = zeros(1,7);

classFeatures = zeros(3,7);
classErrors = zeros(3,7);

%--For each fold
for i = 1 : 8

	avRock = zeros(1,7);
	avPaper = zeros(1,7);
	avScissors = zeros(1,7);
	
	foldAvRock = zeros(1,7);
	foldAvPaper = zeros(1,7);
	foldAvScissors = zeros(1,7);
	
	%--Training set is other 7
	for j = 1 : 8
		if j ~= i
			%--Get the average feature vector of training
			avRock = rockfVectors(j,:) + avRock;
			avPaper = paperfVectors(j,:) + avPaper;
			avScissors = scissorsfVectors(j,:) + avScissors;
		end
	end
	
	foldAvRock = foldAvRock + (avRock / 7);
	foldAvPaper = foldAvPaper + (avPaper / 7);
	foldAvScissors = foldAvScissors + (avScissors / 7);
	
	%--Get the error from training to test
	foldRockError = foldRockError + (abs(foldAvRock - rockfVectors(i,:)));
	foldPaperError = foldPaperError + (abs(foldAvPaper - paperfVectors(i,:)));
	foldScissorsError = foldScissorsError + (abs(foldAvScissors - scissorsfVectors(i,:)));
end

totalAvRock = foldAvRock / 8;
totalAvPaper = foldAvPaper / 8;
totalAvScissors = foldAvScissors / 8;

rockError = foldRockError / 8;
paperError = foldPaperError / 8;
scissorsError = foldScissorsError / 8;

classFeatures(1,:) = totalAvRock;
classFeatures(2,:) = totalAvPaper;
classFeatures(3,:) = totalAvScissors;

classErrors(1,:) = rockError; 
classErrors(2,:) = paperError; 
classErrors(3,:) = scissorsError;

disp(classFeatures);
disp(classErrors);
