# snap-welding

# Documentation for the Provided MATLAB Code

## Introduction
This documentation explains the purpose, functionality, and usage of the provided MATLAB code. The code generates a series of convex hulls and smooth curves within a specified range. It also checks for certain conditions and intersections with a user-defined rectangle. The code is structured into sections, each with a specific purpose.

## Initialization
Before executing the main loop, the code initializes various parameters and data structures.

1. **Setting Maximum Values for x and y**
   - `x_min`: Minimum value for x-coordinate.
   - `x_max`: Maximum value for x-coordinate.
   - `y_min`: Minimum value for y-coordinate.
   - `y_max`: Maximum value for y-coordinate.

2. **Generating Random Points**
   - `num_points`: Number of random points to generate.
   - `all_random_points`: Generates `num_points` random (x, y) points within the specified ranges.

3. **Number of Iterations**
   - `num_iterations`: Number of iterations for the main loop.

4. **Arrays Initialization**
   - `perimeter_array`: Array to store perimeters.
   - `selected_iterations`: Array to store selected iterations.
   - `final_plots`: Cell array to store final plot figures.

5. **Perimeter Range Criteria**
   - `lower_perimeter_limit`: Lower limit for the perimeter of the convex hull.
   - `upper_perimeter_limit`: Upper limit for the perimeter of the convex hull.

6. **User-specified Points**
   - `user_points`: Array of user-specified points.

7. **User-defined Rectangle**
   - `user_rectangle`: Vertices of a user-defined rectangle.

## Main Loop
The main loop runs for a specified number of iterations (`num_iterations`) and performs the following steps:

1. **Random Point Selection**
   - Randomly selects 48 points from the generated random points.

2. **Including User-specified Points**
   - Appends the user-specified points to the selected points.

3. **Duplicate Removal**
   - Removes duplicate points from the selected points.

4. **Convex Hull Calculation**
   - Calculates the convex hull of the selected points.

5. **Convex Hull Simplification**
   - Simplifies the convex hull to generate smoother curves.

6. **Checking for Curvature**
   - Calculates the curvature of the convex hull.
   - If the total angle change is below a threshold, the iteration is skipped.

7. **Curve Fitting**
   - Fits a smooth curve (spline) to the convex hull points.

8. **Intersection with User-defined Rectangle**
   - Determines the intersection point between the smooth curve and the user-defined rectangle.
   - Adjusts the curve accordingly.

9. **Plotting**
   - Plots the convex hull, smooth curve, and user-defined rectangle.
   - Creates an animation effect by pausing briefly.

10. **Selected Iterations Tracking**
    - Keeps track of selected iterations that meet the criteria.
    - Stops the loop when 15 selected iterations are reached.

## Final Output
After the loop, the code displays the selected iterations that met the criteria.

## Helper Function: `findIntersection`
This function finds the intersection point between a line segment defined by `startPt` and `endPt` and a polygon defined by `rectVertices`. It uses the `polyxpoly` function and returns the intersection point if found.

## Note
- Some parts of the code are commented out (e.g., ensuring the red curve ends at specific points). You can uncomment and adjust them as needed.
- The code generates and stores plots in the `final_plots` cell array, which can be used to visualize the results.

## Usage
To use this code, follow these steps:
1. Set the desired parameters at the beginning of the code.
2. Execute the code in a MATLAB environment.
3. Review the selected iterations and plotted results at the end.

Make sure to customize the code as needed for your specific application and criteria.

Date | Code Version | Description 
| --- | --- | --- |
| 03-12-2023 | V5 | The best working one. Works as in ss 25.
| 22-11-2023 | V6 | Cubic spline to make the lines smoother. Weird, even self intersecting shapes coming up. Works as in ss26.
| 01-12-2023 | V7 | Trying to fix the problems with V6


  ![Screenshot (24)](https://github.com/surabhit-08/snap-welding/assets/62366465/455ce6cf-4e57-454d-b37e-a428672f776f)

  
  
  ![Screenshot (23)](https://github.com/surabhit-08/snap-welding/assets/62366465/848a65eb-4401-4f12-9cda-8f917899aeb4)




![Screenshot (26)](https://github.com/surabhit-08/snap-welding/assets/62366465/c48ac2c1-8d6b-4b53-a37d-04175b13d550)


## Things to do:
1. Implement Bezier curves on the achieved contours of v5.

2. ![Screenshot (29)](https://github.com/surabhit-08/snap-welding/assets/62366465/520bbe8a-49ed-4f97-bbcf-441971dd6da6)

