% Set the maximum values for x and y
x_max = 10;
y_max = 10;

% Generate 1000 random points
num_points = 1000;
random_points = [rand(num_points, 1) * x_max, rand(num_points, 1) * y_max];

% Calculate the convex hull
convex_hull_indices = convhull(random_points(:,1), random_points(:,2));
convex_hull_points = random_points(convex_hull_indices, :);

% Plot the points
figure;
scatter(random_points(:,1), random_points(:,2), 'b.');
hold on;

% Plot the convex hull
plot(convex_hull_points(:,1), convex_hull_points(:,2), 'r-', 'LineWidth', 2);

% Set axis limits
axis([0 x_max 0 y_max]);

% Add labels and title
xlabel('X-axis');
ylabel('Y-axis');
title('Random Points and Convex Hull');

% Display legend
legend('Random Points', 'Convex Hull');
hold off;
