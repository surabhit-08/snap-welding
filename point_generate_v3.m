% Set the maximum values for x and y
x_max = 10;
y_max = 10;

% Generate 1000 random points
num_points = 10000;
all_random_points = [rand(num_points, 1) * x_max, rand(num_points, 1) * y_max];

% Number of iterations
num_iterations = 1000;

% Initialize an array to store perimeters
perimeter_array = zeros(num_iterations, 1);

% Perimeter range criteria
lower_perimeter_limit = 28;
upper_perimeter_limit = 28.5;

% Initialize an array to store selected iterations
selected_iterations = [];

for iter = 1:num_iterations
    % Randomly select 20 points
    selected_indices = randperm(num_points, 20);
    selected_points = all_random_points(selected_indices, :);

    % Calculate the convex hull
    convex_hull_indices = convhull(selected_points(:, 1), selected_points(:, 2));
    convex_hull_points = selected_points(convex_hull_indices, :);

    % Calculate the perimeter
    perimeter = 0;
    for i = 1:size(convex_hull_points, 1) - 1
        perimeter = perimeter + norm(convex_hull_points(i, :) - convex_hull_points(i+1, :));
    end
    % Add the last edge
    perimeter = perimeter + norm(convex_hull_points(end, :) - convex_hull_points(1, :));

    % Store the perimeter in the array
    perimeter_array(iter) = perimeter;

    % Check if the perimeter is within the specified range
    if perimeter >= lower_perimeter_limit && perimeter <= upper_perimeter_limit
        selected_iterations = [selected_iterations, iter];
    end
end

% Plot the perimeters
% figure;
% histogram(perimeter_array, 'BinWidth', 5);
% xlabel('Perimeter');
% ylabel('Frequency');
% title('Distribution of Convex Hull Perimeters for 100 Iterations');

% Display selected iterations
disp('Selected Iterations:');
disp(selected_iterations);
