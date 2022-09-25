load fisheriris

c1 = cvpartition(species, 'Holdout', 0.2);
c2 = cvpartition(species, 'KFold', 5);
c3 = cvpartition(species, 'leaveout');

x1_train = meas(c1.training, :);
y1_train = species(c1.training);
x1_test = meas(c1.test, :);
y1_test = species(c1.test);

x2_train = meas(c2.training(3), :);
y2_train = species(c2.training(3));
x2_test = meas(c2.test(3), :);
y2_test = species(c2.test(3));