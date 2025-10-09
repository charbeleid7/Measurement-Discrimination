# Measurement-Discrimination

Examples of MATLAB codes for computing the optimal success probabilities of one-copy minimum-error quantum measurement discrimination tasks using SDP, given access to the post-measurement state and without access to the post measurement state.
This repository accompanies the numerical work presented in the paper:

> *[TITLE ADD LATER]*  
> **Charbel Eid**  
> LIP6, Sorbonne Université — currently at LIG, Université Grenoble Alpes  
> Contact: [charbelezzateid@gmail.com](mailto:charbelezzateid@gmail.com)

---

## Overview

This repository contains MATLAB scripts and functions for simulating and plotting the **maximum success probabilities** of various quantum measurement discrimination tasks.  
The examples explore how access to the *post-measurement state* affects the ability to distinguish between quantum measurements.

The codebase contains two kinds of scripts:

- **Example scripts** — run the discrimination tasks and produce plots.
- **Functions** — perform the underlying quantum information and optimization computations (e.g., POVMs, Choi operators, SDP).

The repository is designed to allow other researchers to verify the results presenter in the paper, inspect and extend them.  
To understand the theoretical background, please refer to the accompanying paper.

---

## Contents

### Example Scripts

Each example script computes and plots the optimal success probabilities for a specific class of measurement discrimination tasks:

| Script | Description |
|:--|:--|
| `Dichotomic_Error_Detection_Instrument_Advantage.m` | Plots the maximum success probability of discriminating between the Z measurement and a faulty version \( W(\theta, p) \) with noise parameter *p* and basis error *θ*. For example, \( W(\pi/2, 0) = X \). |
| `Dichotomic_Trine_Instrument_Advantage.m` | Plots the success probability for discriminating between two trine measurements. The code focuses on \( \Lambda(0,0) \) and a sampling of \( \Lambda(\theta, \phi) \), since any pair can be reduced to this form by a global unitary. |
| `Dichotomic_Projective_Qubit_Instrument_Advantage.m` | Plots the discrimination performance between the Z measurement and rotated versions of it within the ZX plane of the Bloch sphere. This captures all equivalent projective-qubit discrimination tasks up to a global unitary. |

---

### Core Functions

The following MATLAB functions are used by the example scripts:

| Function | Description |
|:--|:--|
| `Nchannels_1copy_discriminationexample.m` | Uses **YALMIP** and a semidefinite program (SDP) to compute the optimal success probability of discriminating a set of quantum channels. Input: Choi operators of the channels, and their input/output dimensions. Output: optimal success probability and optimal tester.  (This code was given to me by Jessica Bavaresco as an example and I never rewrote it as it worked very well.) |
| `Qubit.m` | Given two Bloch angles (*θ*, *φ*) in radians, returns the corresponding pure qubit density matrix. |
| `MeasChan.m` | Converts a POVM (stored in a tensor variable) into the Choi operator of the corresponding *measure-and-prepare* channel. |
| `LudIsntChan.m` | Similar to `MeasChan.m`, but constructs the Choi operator for the Lüders instrument — i.e., the *measure-and-prepare* process with access to the post-measurement state. |
| `ThreeOutQubitMeasChan.m` | Given two Bloch angles, returns a **trine measurement POVM** (not a channel). |
| `checkPOVM.m` | Verifies whether a given set of operators forms a valid POVM. Input: operator tensor; Output: boolean (true = valid POVM). |

---

## Requirements

- **MATLAB** R2021a or later  
- **YALMIP** toolbox  
- **MOSEK** solver

> **macOS users:**  
> MOSEK sometimes triggers a security warning. If MATLAB cannot access MOSEK, run the following commands in Terminal **before** starting MATLAB:  
> ```bash
> sudo spctl --master-disable
> ```
> Then, once finished:
> ```bash
> sudo spctl --master-enable
> ```
> This temporarily allows MATLAB to load the solver correctly.

---

## Usage

Clone the repository and open MATLAB:
Make sure all codes are in the same folder. (there is no path added in the example)

```bash
git clone https://github.com/charbeleid/Measurement-Discrimination.git
cd Measurement-Discrimination
```

Then run any example script, e.g.:

```bash
run('Dichotomic_Error_Detection_Instrument_Advantage.m')
```

Then define different POVMs, generate the Choi operators with MeasChan and LudInstChan and run the SDP to optimally discriminate them.
