data1=xlsread('cervical.csv'); % load the excel file
data=rmmissing(data1); % remove missing values
data(data==0)=2; % all 0 values to 2 
p = .7;  % split data into 70& train and 30% test   
N = size(data,1);  % total number of rows 
tf = false(N,1);    % create logical index vector
tf(1:round(p*N)) = true;     
tf = tf(randperm(N));   
dataTraining = data(tf,:); 
dataTesting = data(~tf,:);

inputs_parameters=dataTraining(1:end,1:32)';
class=dataTraining(:,33);

targets_class_dum=dummyvar(class)'; % create dummy var for output 
net=patternnet(20);
net=train(net,inputs_parameters,targets_class_dum);
view(net);
a=sim(net,inputs_parameters);
err=a-targets_class_dum;
err1=mse(err);
net=init(net);
net=train(net,inputs_parameters,targets_class_dum);
view(net);
esma=net;
save esma;
test1=xlsread('esi.csv'); % load the test excel file

 load esma
 newoutput = esma(test)';




