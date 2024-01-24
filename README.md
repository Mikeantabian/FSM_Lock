# 3-Number Combination Lock VHDL Project

## Overview
This project implements a 3-number combination lock using VHDL and a Finite State Machine (FSM). The lock opens only when the correct numbers are entered sequentially. The FSM is designed with clock, reset, and new_value signals to control transitions between different lock states.

## Code Structure
The VHDL code is organized into a modular structure with the following key components:

### States
The FSM has five states: S0, S1, S2, S3, and Err. These states represent different phases of the combination lock operation.

### Combination Code
A constant array `nums` is defined to represent the correct combination. The combination lock opens only when the correct numbers are entered in sequence.

### State Transition Logic
Conditional logic is implemented within each state to verify the correctness of the entered combination. The FSM transitions to the next state or enters an error state (Err) based on the entered values.

### Door Control
The door control logic is integrated to activate the door output when the correct combination is entered in sequence (S3 state). This ensures that the door opens only upon successful entry of the combination.

### Robustness
The code includes robust error handling mechanisms, including a reset functionality, to manage unexpected inputs and ensure the proper functioning of the combination lock.

## RTL Schematic
![image](https://github.com/Mikeantabian/FSM_Lock/assets/119545472/9aa834e4-b077-48c7-a494-423ab2058925)

## TestBench Simulations
![image](https://github.com/Mikeantabian/FSM_Lock/assets/119545472/7e5b2fab-c679-4f4b-83b0-c936d882295a)

