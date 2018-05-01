Four nonlinear estimation algorithm are implemented in following function files:
extendKF.m: 	Extended Kalman Filter.
iterateEKF.m: 	Iterated EKF.
gridBF.m:	Grid-based Filter.
particleF.m:	Particle Filter.

The other codes are used to test these functions and plot the result:

ADsignal_C3.m: 	Main function, used to plot the estimation result and calculate RMSE.
spdfe.m:	Generate random length state according to the state equation in the report and perform Monte Carlo simulation.

Please run 'ADsignal_C3.m' to explore the estimation results and run the function files to investigate the detailed implementation of the algorithms.
