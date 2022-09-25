function label = predictLabelsSVM(x) %#codegen
%PREDICTLABELSSVM Label new observations using trained SVM model Mdl
%   predictLabelsSVM predicts the vector of labels label using 
%   the saved SVM model Mdl and the predictor data x.
Mdl = loadLearnerForCoder('SVMModel');
label = predict(Mdl,x);
end