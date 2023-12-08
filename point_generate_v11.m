% Set the maximum values for x and y
x_min = 10;
x_max = 5;
y_min = 32;
y_max = 5;

num_points = 1000000;
all_random_points = [x_min + rand(num_points, 1) * x_max, y_min + rand(num_points, 1) * y_max];

% Number of iterations
num_iterations = 100000;

% Initialize arrays to store perimeters and selected iterations
perimeter_array = zeros(num_iterations, 1);
selected_iterations = [];

% Perimeter range criteria
lower_perimeter_limit = 17;
upper_perimeter_limit = 18;

% User-specified points
user_points = [10, 32; 10, 35];

% Superimpose user-defined rectangle
user_rectangle = [0, 0; 10, 0; 10, 45; 0, 45];

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

    % Remove duplicate points
    selected_points = unique(selected_points, 'rows');

    % Calculate the convex hull using convhull
    convex_hull_indices = convhull(selected_points(:, 1), selected_points(:, 2));
    convex_hull_points = selected_points(convex_hull_indices, :);
    
    % Simplify the convex hull to generate smoother curves
    convex_hull = simplify(polyshape(convex_hull_points));

    % Check if the convex hull has <90 degree bends and a fair amount of curvature
    angles = zeros(1, numel(convex_hull.Vertices)/2);
    for i = 1:numel(convex_hull.Vertices)/2
        next_index = mod(i, numel(convex_hull.Vertices)/2) + 1;
        next_next_index = mod(i, numel(convex_hull.Vertices)/2) + 2;

        if next_next_index > numel(convex_hull.Vertices)/2
            next_next_index = 1;
        end

        vec1 = [convex_hull.Vertices(next_next_index, :) 0] - [convex_hull.Vertices(next_index, :) 0];
        vec2 = [convex_hull.Vertices(next_index, :) 0] - [convex_hull.Vertices(i, :) 0];

        angles(i) = atan2(norm(cross(vec1, vec2)), dot(vec1(1:2), vec2(1:2)));
    end

    % Calculate the total angle change along the convex hull
    total_angle_change = sum(abs(diff(angles)));

    % Define a threshold for angle change
    angle_change_threshold = 5.0;  % Adjust as needed

    % Check if the total angle change is below the threshold
    if total_angle_change < angle_change_threshold
        continue;  % Skip iterations with low curvature
    end

    % Fit a smooth curve (spline) to all points in the convex hull
    t = 1:numel(convex_hull.Vertices)/2;
    tt = 1:0.1:numel(convex_hull.Vertices)/2;
    interp_points = spline(t, convex_hull.Vertices', tt);

    % Store the final plot for later display
    final_plots{length(selected_iterations) + 1} = figure;
    plot(convex_hull);
    hold on;
    plot(interp_points(1, :), interp_points(2, :), 'r-', 'DisplayName', 'Smooth Curve');
    
    % Superimpose user-defined rectangle
    plot(user_rectangle(:, 1), user_rectangle(:, 2), 'g-', 'LineWidth', 2);
    
    % Add labels and title
    xlabel('X-axis');
    ylabel('Y-axis');
    title([ num2str(iter) ' - Conv Hull with Smooth Curve']);
    legend('Convex Hull', 'Smooth Curve', 'User Rectangle');
    
    % Force both axes to have the same scale
    axis equal;

    hold off;
    
    % Pause to create the animation effect
    pause(0.1);

    % Increment the selected iteration count
    selected_iterations = [selected_iterations, iter];
    
    % Check if we have collected 5 final plots
    if length(selected_iterations) == 15
        break;
    end
end

% Display selected iterations
disp('Selected Iterations:');
disp(selected_iterations);
