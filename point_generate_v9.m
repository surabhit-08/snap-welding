% Set the maximum values for x and y
x_min = 10;
x_max = 5;
y_min = 32;
y_max = 5;

% Generate 1000 random points
num_points = 1000;
all_random_points = [x_min+rand(num_points, 1) * x_max, y_min+rand(num_points, 1) * y_max];

% Number of iterations
num_iterations = 100;

% Initialize arrays to store perimeters and selected iterations
perimeter_array = zeros(num_iterations, 1);
selected_iterations = [];

% Perimeter range criteria
lower_perimeter_limit = 17;
upper_perimeter_limit = 18;

% User-specified points
user_points = [10,32;10,35];

% Superimpose user-defined rectangle
user_rectangle = [0,0;10,0;10,45;0,45];

% Plot the initial random points
figure;
scatter(all_random_points(:, 1), all_random_points(:, 2), 'b.');
hold on;

% Initialize arrays to store selected final plots
final_plots = cell(5, 1);

for iter = 1:num_iterations
    % Randomly select 48 points
    selected_indices = randperm(num_points, 48);
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
        
        % Store the final plot for later display
        final_plots{length(selected_iterations)} = figure;
        scatter(all_random_points(:, 1), all_random_points(:, 2), 'b.');
        hold on;
        plot(selected_points(:, 1), selected_points(:, 2), 'r.');
        plot(convex_hull_points(:, 1), convex_hull_points(:, 2), 'k-', 'LineWidth', 2);
        
        % Superimpose user-defined rectangle
        plot(user_rectangle(:, 1), user_rectangle(:, 2), 'g-', 'LineWidth', 2);
        
        % Add labels and title
        xlabel('X-axis');
        ylabel('Y-axis');
        title(['Iteration ' num2str(iter) ' - Points and Convex Hull Boundaries']);
        legend('All Points', 'Selected Iteration', 'User Rectangle');
        axis equal;
        
        hold off;
        
        % Pause to create the animation effect
        pause(0.1);
    end
    
    % Check if we have collected 5 final plots
    if length(selected_iterations) == 10
        break;
    end
end

% Display selected iterations
disp('Selected Iterations:');
disp(selected_iterations);
