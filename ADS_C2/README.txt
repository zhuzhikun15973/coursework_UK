Please run the main.m directly.

There are three functions been submitted:

main.m: The main function. Used to process the Monte Carlo method and evaluate the result. Task 2, 3 and 4 are implemented in the main.m.

appleConDist.m: Apple consumption distribution random variable(RV) generator. This function use rejection method to generate a nWeek-by-N matrix contains RVs of the weekly apple demand.

appleSim.m: Simulation function used to simulate the total cost within nWeek period. It takes y, r, and the RVs matrix returned by appleConDist.m as input, and return the total cost in a N-by-1 matrix.

Further indications can be accessed within the respect .m files, and the algorithm illustration can be accessed in the report.