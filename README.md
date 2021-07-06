# Tensegrity FEM Models of Cells
 Generate FE line Models of biological cells using Spherical tensegrity structures

This repository contans three main programs
Main_code_1_tensegrities.m ,
Main_code_2_cell_models.m and
Main_code_3_Form_Finding.m

- These serve the purpose of using standard tensegrity structures and generate cell models out of them
- a new stable tensegrity structure can be created using the numerical form finding technique

## Generate Cell models

1)  Open 'Main_code_1_tensegrities.m' or 'Main_code_2_cell_models.m'
2) In the Model Generation section,  select tensegrity structure or cell model to be generated and run the code
  -  The corresponding tensegrity structure or cell model will be displayed along with the mode shapes( from eigenvalue analysis)
  -  Corresponding APDL Macro codes will be printed onto the console 
3) Copy and paste the APDL codes onto a macro script which will help generate a line model of the cell in Ansys Mechanical APDL.

## Form Finding of a new tensegrity

1) Open "Main_code_3_Form_Finding.m" 
2) the code can be used to execute either of the following cases:
 - generate a standard tensegrity -> randomize its nodes -> get back the original form through form-finding (using elements data)
 - Make a new tensegrity structure - make a new elements connections data and obtain a stable form of the new tensegrity
 ---
# Background

![image](https://user-images.githubusercontent.com/85007096/124547046-2cc4b580-de49-11eb-97ec-1a5394f9e995.png)

![image](https://user-images.githubusercontent.com/85007096/124067339-e261c400-da57-11eb-8399-e669bf87f85d.png)
![image](https://user-images.githubusercontent.com/85007096/124547879-782b9380-de4a-11eb-90b1-3dffe32286ca.png)

# What the codes can do 

![image](https://user-images.githubusercontent.com/85007096/124066892-12f52e00-da57-11eb-9d22-ed7def0b5f9d.png)

![image](https://user-images.githubusercontent.com/85007096/124066896-14bef180-da57-11eb-9bdd-e977487b1651.png)

![image](https://user-images.githubusercontent.com/85007096/124066900-1688b500-da57-11eb-9e8e-dfc756416e5a.png)

![image](https://user-images.githubusercontent.com/85007096/124073811-29ec4e00-da60-11eb-820d-3bd55df8c65d.png)
