clear all;
close all;
clc;
D1 = 'C:\Users\GOWTHAM KISHORE\Documents\MATLAB\paddy dataset\Leaf smut';
S1 = dir(fullfile(D1,'*.jpg')); % pattern to match filenames.
for n1 = 1:120
    F1 = fullfile(D1,S1(n1).name);
    I1 = imread(F1);
    imshow(I1)
    disp(n1)
    disp('n1')
    I1 = imresize(I1,[64,220]);
    [II,RGB] = createMask(I1);
    seg_img = RGB;
    img = rgb2gray(seg_img);
    glcms = graycomatrix(img);
    stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
    Contrast = stats.Contrast;
    Energy = stats.Energy;
    Homogeneity =  stats.Homogeneity;
    Mean = mean2(seg_img);
    Standard_Deviation = std2(seg_img);
    Entropy = entropy(seg_img);
    RMS = mean2(rms(seg_img));
    %Skewness = skewness(img)
    Variance = mean2(var(double(seg_img)));
    a = sum(double(seg_img(:)));
    Smoothness = 1-(1/(1+a));
    m = size(seg_img,1);
    n = size(seg_img,2);
    in_diff = 0;
    for i = 1:m
           for j = 1:n
                 temp = seg_img(i,j)./(1+(i-j).^2);
                  in_diff = in_diff+temp;
           end
    end
    IDM = double(in_diff); 
    ff = [Contrast,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, IDM,1];
  if n1==1
       x= ff;
  end
 if n1>1
       x = [x;ff];
 end;
end
D2 = 'C:\Users\GOWTHAM KISHORE\Documents\MATLAB\paddy dataset\Brown spot';
S2 = dir(fullfile(D2,'*.jpg')); % pattern to match filenames.
for n2 = 1:120
    F2 = fullfile(D2,S2(n2).name);
    I2 = imread(F2);
    imshow(I2)
    disp(n2)
    disp('n2')
    I2 = imresize(I2,[64,220]);
    [II,RGB] = createMask(I2);
    seg_img = RGB;
    img = rgb2gray(seg_img);
    glcms = graycomatrix(img);
    stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
    Contrast = stats.Contrast;
    Energy = stats.Energy;
    Homogeneity =  stats.Homogeneity;
    Mean = mean2(seg_img);
    Standard_Deviation = std2(seg_img);
    Entropy = entropy(seg_img);
    RMS = mean2(rms(seg_img));
    %Skewness = skewness(img)
    Variance = mean2(var(double(seg_img)));
    a = sum(double(seg_img(:)));
    Smoothness = 1-(1/(1+a));
    m = size(seg_img,1);
    n = size(seg_img,2);
    in_diff = 0;
    for i = 1:m
           for j = 1:n
                 temp = seg_img(i,j)./(1+(i-j).^2);
                  in_diff = in_diff+temp;
           end
    end
    IDM = double(in_diff); 
    ff = [Contrast,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, IDM,2];
    x = [x;ff];
end
D3 = 'C:\Users\GOWTHAM KISHORE\Documents\MATLAB\paddy dataset\Bacterial leaf blight';
S3 = dir(fullfile(D3,'*.jpg')); % pattern to match filenames.
for n3 = 1:120
    F3 = fullfile(D3,S3(n3).name);
    I3 = imread(F3);
    imshow(I3)
    disp(n3)
    disp('n3')
     I3 = imresize(I3,[64,220]);
    [II,RGB] = createMask(I3);
    seg_img = RGB;
    img = rgb2gray(seg_img);
    glcms = graycomatrix(img);
    stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
    Contrast = stats.Contrast;
    Energy = stats.Energy;
    Homogeneity =  stats.Homogeneity;
    Mean = mean2(seg_img);
    Standard_Deviation = std2(seg_img);
    Entropy = entropy(seg_img);
    RMS = mean2(rms(seg_img));
    %Skewness = skewness(img)
    Variance = mean2(var(double(seg_img)));
    a = sum(double(seg_img(:)));
    Smoothness = 1-(1/(1+a));
    m = size(seg_img,1);
    n = size(seg_img,2);
    in_diff = 0;
    for i = 1:m
           for j = 1:n
                 temp = seg_img(i,j)./(1+(i-j).^2);
                  in_diff = in_diff+temp;
           end
    end
    IDM = double(in_diff); 
    ff = [Contrast,Energy,Homogeneity, Mean, Standard_Deviation, Entropy, RMS, Variance, Smoothness, IDM,3];
    x = [x;ff];
end
training_class_name1 = x(1:100,11:11);
training_data1 = x(1:100,1:10);
training_class_name2 = x(121:220,11:11);
training_data2 = x(121:220,1:10);
training_class_name3 = x(241:340,11:11);
training_data3 = x(241:340,1:10);
training_class_name = [training_class_name1;training_class_name2;training_class_name3];
training_data = [training_data1;training_data2;training_data3];
% validating data
validating_class_names1 = x(101:120,11:11);
validating_data1 = x(101:120,1:10);
validating_class_names2 = x(221:240,11:11);
validating_data2 = x(221:240,1:10);
validating_class_names3 = x(341:360,11:11);
validating_data3 = x(341:360,1:10);
validating_class_names = [validating_class_names1;validating_class_names2;validating_class_names3];
validating_data = [validating_data1;validating_data2;validating_data3];
SVM_model1=fitcecoc(training_data,training_class_name);
[predicted_class_name,score] = predict(SVM_model1,validating_data);
% checking the accuracy 
accuracy = sum(predicted_class_name == validating_class_names)/numel(validating_class_names)*100
disp(accuracy);
disp('svm');
