# Technical Overview — Measurement-Discrimination

This document provides a brief technical overview of the MATLAB tools contained in the **Measurement-Discrimination** repository.  
It explains how the example scripts and functions are organized, what inputs they expect, and what each component computes.

---

## 1. Purpose

The goal of this codebase is to numerically study **quantum measurement discrimination tasks** — specifically, to compare the success probability of distinguishing quantum measurements **with** and **without** access to the post-measurement state.  

The accompanying MATLAB scripts reproduce and visualize the results discussed in the related paper (*title to be added once published*).

---

## 2. Structure of the Repository

| Folder / File | Role |
|:--|:--|
| `Dichotomic_Error_Detection_Instrument_Advantage.m` | Plots success probabilities for discriminating between the Z measurement and a faulty version \( W(\theta, p) \) with noise parameter *p* and basis error *θ*. |
| `Dichotomic_Trine_Instrument_Advantage.m` | Plots success probabilities for discriminating between two trine measurements \( \Lambda(0,0) \) and \( \Lambda(\theta, \phi) \). |
| `Dichotomic_Projective_Qubit_Instrument_Advantage.m` | Plots success probabilities for discriminating between Z and ZX-plane rotated projective measurements. |
| `Nchannels_1copy_discriminationexample.m` | Core SDP solver — computes the optimal discrimination success probability for a given set of quantum channels. |
| `Qubit.m` | Returns the pure qubit density matrix for given Bloch angles. |
| `MeasChan.m` | Builds the Choi operator of the *measure-and-prepare* channel corresponding to a POVM. |
| `LudIsntChan.m` | Builds the Choi operator for the Lüders instrument (includes post-measurement state). |
| `ThreeOutQubitMeasChan.m` | Returns a trine measurement POVM given two Bloch angles. |
| `checkPOVM.m` | Checks if a given set of operators forms a valid POVM. |

---

## 3. General Workflow

Each example script follows a similar structure:

1. **Define the measurements**  
   The code constructs two or more quantum measurements (typically represented by POVMs or Choi operators).  
   These are parameterized by Bloch angles \( \theta, \phi \) or noise parameters *p*.

2. **Compute the discrimination probability**  
   The function `Nchannels_1copy_discriminationexample.m` formulates and solves a **semidefinite program (SDP)** using [YALMIP](https://yalmip.github.io/) and [MOSEK](https://www.mosek.com/).  
   The SDP maximizes the success probability of correctly identifying the measurement given a single copy of the channel.

3. **Plot the results**  
   The scripts visualize:
   - Success probabilities *without* access to post-measurement states.  
   - Success probabilities *with* access to post-measurement states (via the Lüders instrument).  
   - The **advantage** obtained by having access to the post-measurement state.

---

## 4. Conventions

- **Angles** are given in **radians**.  
- **POVMs** are stored in tensor variables.  
- **Choi operators** represent measure-and-prepare channels (for both standard and Lüders instruments).  
- **Dimensions:** Input and output Hilbert space dimensions must be specified when calling the SDP solver.

---

## 5. Dependencies

- **MATLAB** R2021a or later  
- **[YALMIP](https://yalmip.github.io/download/)** — for defining and solving the SDP  
- **[MOSEK](https://www.mosek.com/downloads/)** — optimization solver

### macOS note
If MATLAB cannot load MOSEK due to system security restrictions, temporarily disable Gatekeeper before launching MATLAB:

```bash
sudo spctl --master-disable
```
## 6. Contact

Charbel Eid
LIP6, Sorbonne Université — currently at LIG, Université Grenoble Alpes
Contact: [charbelezzateid@gmail.com](mailto:charbelezzateid@gmail.com)
