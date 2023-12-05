% Set the maximum values for x and y
x_max = 10;
y_max = 15;

% Generate 1000 random points
num_points = 100000;
all_random_points = [rand(num_points, 1) * x_max, rand(num_points, 1) * y_max];

% Number of iterations
num_iterations = 10000;

% Initialize arrays to store perimeters and selected iterations
perimeter_array = zeros(num_iterations, 1);
selected_iterations = [];

% Perimeter range criteria
lower_perimeter_limit = 43.75;
upper_perimeter_limit = 44.25;

% User-specified points
user_points = [0, 0; 0, 15];

% Plot the initial random points
figure;
scatter(all_random_points(:, 1), all_random_points(:, 2), 'b.');
hold on;

for iter = 1:num_iterations
    % Randomly select 18 points
    selected_indices = randperm(num_points, 38);
    selected_points = all_random_points(selected_indices, :);

    % Include the user-specified points in each iteration
    selected_points = [selected_points; user_points];

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
        
        % Plot points and convex hull for the selected iteration
        plot(selected_points(:, 1), selected_points(:, 2), 'r.');
        plot(convex_hull_points(:, 1), convex_hull_points(:, 2), 'k-', 'LineWidth', 2);
    end
end

hold off;

% Add labels and title
xlabel('X-axis');
ylabel('Y-axis');
title('Points and Convex Hull Boundaries for Selected Iterations');
legend('All Points', 'Selected Iterations');

% Display selected iterations
disp('Selected Iterations:');
disp(selected_iterations);