Run 'main.m' directly please.

main.m
Main function to perform RHC method and present the results.

appleConDist.m:
Apple consumption distribution random variable(RV) generator. This function use rejection method to generate a nWeek-by-N matrix contains RVs of the weekly apple demand.

appleSim.m:
Simulation function used to simulate the total cost within one week. It returns the cost and stock number at end of the week.

appleSimu.m
Simulation function used to simulate the total cost within the prediction horizon.

gen_input.m
Generate all possible order sequences for the prediction horizon. For example, if order number is range from 0 to 6, and the prediction horizon is 3. Then gen_input returns sequences: [0,0,0], [0,0,1],..., [6,6,6], totally 7^3 = 343 possible states.

Further indications can be accessed within the respect .m files, and the algorithm illustration can be accessed in the report.