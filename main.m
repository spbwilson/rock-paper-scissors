%-------------------------------ROCK PAPER SCISSORS----------------------------
%--Average over the two background images provided
avBackground = averageImages('background1', 'background2', 0);

%--Get a list of all folders in train
rootDir = cd;
trainDir = strcat(rootDir, '/train/');

featureVectors = getFeatureVectors(trainDir, avBackground);

classes = [1;1;1;2;2;2;3;3;3;1;2;3;1;2;3;3;3;3;2;2;2;1;1;1];

classification(featureVectors, classes);

disp('Classified');
