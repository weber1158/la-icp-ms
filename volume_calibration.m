function cv_S = volume_calibration(As, Vs, Cm, Cd, Ac, Vc)
%LA-ICP-MS volume-corrected calibration of an element's concentration
%Based on the work of Mervič et al. (2024)
%
%Inputs
%  As :: {scalar} Sample signal intensity for an element Z [cps]
%  Vs :: {scalar} Sample volume ablated [µm^3]
%  Cm :: {vector} Calibrant mass concentrations [µg/g]
%  Cd :: {vector} Calibrant densities [g/cm^3]
%  Ac :: {vector} Calibrant signal intensities for element Z [cps]
%  Vc :: {vector} Calibrant volumes ablated [µm^3]
%
%Output
%  cv_S:: {scalar} Vol-corrected conc. for sample S [ug/cm^3]
%
%
%Reference
% Mervič, K., Van Elteren, J. T., Bele, M., & Šala, M. (2024). 
% Utilizing ablation volume for calibration in LA-ICP-MS mapping 
% to address variations in ablation rates within and between 
% matrices. Talanta, 269, 125379. 
% https://doi.org/10.1016/j.talanta.2023.125379

%% Main function body
% Handle calibrants
Cv = Cm .* Cd; % calibrant volume concentrations [µg/cm^3]
Ac2Vc = Ac ./ Vc; % ratio of Ac to Vc [cps/µm^3]
m = Cv(:) \ Ac2Vc(:); % left division solves linear system for slope

%Perform volume correction
As2Vs = As ./ Vs; % ratio of As to Vs [cps/µm^3]
cv_S = As2Vs ./ m; % [µg/cm^3]

end
