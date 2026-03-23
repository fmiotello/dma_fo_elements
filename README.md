# On the Extension of Differential Beamforming Theory to Arbitrary Planar Arrays of First-Order Elements

Official MATLAB implementation of the article

> F. Miotello, D. Albertini and A. Bernardini, "On the Extension of Differential Beamforming Theory to Arbitrary Planar Arrays of First-Order Elements," in IEEE Transactions on Audio, Speech and Language Processing.

The article is available in IEEE Xplore (early access): [https://ieeexplore.ieee.org/document/11447415/authors#authors](https://ieeexplore.ieee.org/document/11447415/authors#authors).

This repository implements the proposed framework to design steerable differential beamformers for arbitrary planar arrays of first-order elements. The codebase is compact and organized around two main entry-point scripts, with reusable helpers for beamforming, geometry generation, target beampattern construction, and plotting.

## Repository overview

The main workflow is organized around two entry-point scripts:

- `main.m`: runs a single experiment, designs the beamformer, and visualizes the resulting array geometry, beampatterns, WNG, and DF.
- `main_montecarlo.m`: runs repeated randomized experiments and plots mean and standard deviation statistics for the beampattern, WNG, and DF.

Supporting code is grouped as follows:

- `beamforming/`: beamformer design and performance evaluation routines.
- `ideal_beampatterns/`: target-pattern coefficient generators for omnidirectional, dipole, cardioid, hypercardioid, and supercardioid responses.
- `plotting/`: reusable visualization utilities for array geometry, beampatterns, WNG, and DF.
- `utils/`: helper functions for generating array geometries and related support routines.

## Requirements

- MATLAB
- Optimization Toolbox (`fmincon` is needed for `hypercardioid` and `supercardioid` target beampatterns).

The code is otherwise self-contained and uses standard MATLAB functionality.

## Getting started

From MATLAB, open the repository folder and choose the script that matches the type of experiment you want to run. The two entry points, `main.m` and `main_montecarlo.m`, share the same overall workflow: they define the acoustic and beamforming parameters, generate the array configuration and first-order element characteristics, compute the coefficients of the desired beampattern, design the frequency-dependent beamformer weights, and evaluate the resulting response. The lower-level functionality is delegated to the helper routines in `beamforming/`, `plotting/`, `utils/`, and `ideal_beampatterns/`.

For a single experiment on one array realization, run:

```matlab
main
```

For a statistical analysis over multiple randomized realizations, run:

```matlab
main_montecarlo
```

## Main parameters

The following parameters can be adjusted directly in `main.m` and `main_montecarlo.m`:

- `M`: number of array elements.
- `freq`: frequency grid used for beamformer design and evaluation.
- `N`: differential beamforming order.
- `shape`: target beampattern (`'omnidirectional'`, `'dipole'`, `'cardioid'`, `'hypercardioid'`, or `'supercardioid'`).
- `theta_s`: target beampattern steering direction.
- `q_m`, `theta_m`: element beam shape and orientations.
- `n_exp`: number of Monte Carlo experiments in `main_montecarlo.m`.

Geometry-related parameters depend on the specific array generation strategy adopted in the script. For example, `max_rad` and `min_sep` are relevant for the random circular-area geometry used in the article.

## Citation

If you use this repository, please cite the corresponding article:

```text
F. Miotello, D. Albertini and A. Bernardini, "On the Extension of Differential Beamforming Theory to Arbitrary Planar Arrays of First-Order Elements," in IEEE Transactions on Audio, Speech and Language Processing.
```
