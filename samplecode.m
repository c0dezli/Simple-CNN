% Sample code  from the Project 1 Description 

%loading this file defines imageset, trueclass, and classlabels
load('cifar10testdata.mat');
%some sample code to read and display one image from each class; edited for subplots

figure(1); 
hold on;
for classindex = 1:10
    %get indices of all images of that class
    inds = find(trueclass==classindex);
    %take first one
    imrgb = imageset(:,:,:,inds(3));
    %display it along with ground truth text label
    subplot(2,5,classindex); 
    imagesc(imrgb); 
    title(sprintf('%s',classlabels{classindex}));
end

%loading this file defines filterbanks and biasvectors
load('CNNparameters.mat');
%sample code to verify which layers have filters and biases
for d = 1:length(filterbanks)
    filterbank = filterbanks{d};
    if not(isempty(filterbank))
        fprintf('layer %d has filters and biases\n',d);
        fprintf(' filterbank size %d x %d x %d x %d\n', ...
            size(filterbank,1),size(filterbank,2), ...
            size(filterbank,3),size(filterbank,4));
        biasvec = biasvectors{d};
        fprintf(' number of biases is %d\n',length(biasvec));
    end
end

%loading this file defines imrgb and layerResults
load('debuggingTest.mat');
%sample code to show image and access expected results
figure; 
% change this line to take different imges
imrgb = imageset(:,:,:,3);
imagesc(imrgb); 
truesize(gcf,[64 64]);
layerOutput = CNNDriver(imrgb);
for d = 1:length(layerOutput)
    result = layerOutput{d};
    fprintf('layer %d output is size %d x %d x %d\n',...
        d,size(result,1),size(result,2), size(result,3));
end

%find most probable class
classprobvec = squeeze(layerOutput{end});
[maxprob,maxclass] = max(classprobvec);
%note, classlabels is defined in 'cifar10testdata.mat'
fprintf('estimated class is %s with probability %.4f\n',...
    classlabels{maxclass},maxprob);