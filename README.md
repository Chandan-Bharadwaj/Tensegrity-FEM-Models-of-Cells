# Tensegrity FEM Models of Cells
 Generate FE line Models of biological cells using Spherical tensegrity structures

This repository contans three main programs
generate_tensegrities.m ,
generate_cell_models.m and
numerical_form_finding.m

- These serve the purpose of using standard tensegrity structures and generate cell models out of them
- a new stable tensegrity structure can be created using the numerical form finding technique

## Theory

In recent years, Studies on the mechanics of a cell have increased significantly. Many essential cell functions such as growth, proliferation and locomotion directly involve mechanical forces. It is found that observing the dynamics of a cell can very well indicate the condition of a cell i.e., whether it is healthy or in disease. Such explorations have the potential to bring out the largely unknown mechanisms of disease such as cancer.

The cytoskeleton of the cell is a key contributor in the generation of mechanical forces in the cell. These mechanical forces play a major role in many essential processes of a cell such as growth, proliferation and metastasis. More insight into such dynamic behaviour of cells is required in order to design better treatment for diseases such as cancer. 

Tensegrity structures are prestressed flexible structures made of simple compressive and tensional elements which are in equilibrium. There is sufficient evidence that the cytoskeleton of a cell surprisingly exhibits similarities with the dynamics of a tensegrity structure. They are found to mimic the behavior of a cytoskeleton in many ways. These structures offer a promising way to develop a prospective yet simple model of the complex cytoskeleton.

## Generate Cell models

1)  Open 'generate_tensegrities.m' or 'generate_cell_models.m'
2) In the Model Generation section,  select tensegrity structure or cell model to be generated and run the code
  -  The corresponding tensegrity structure or cell model will be displayed along with the mode shapes( from eigenvalue analysis)
  -  Corresponding APDL Macro codes will be printed onto the console 
3) Copy and paste the APDL codes onto a macro script which will help generate a line model of the cell in Ansys Mechanical APDL.

## Form Finding of a new tensegrity

1) Open "numerical_form_finding.m" 
2) the code can be used to execute either of the following cases:
 - generate a standard tensegrity -> randomize its nodes -> get back the original form through form-finding (using elements data)
 - Make a new tensegrity structure - make a new elements connections data and obtain a stable form of the new tensegrity
 ---
# Background

![image](https://user-images.githubusercontent.com/85007096/124547046-2cc4b580-de49-11eb-97ec-1a5394f9e995.png)

![image](https://user-images.githubusercontent.com/85007096/124067339-e261c400-da57-11eb-8399-e669bf87f85d.png)

# What the codes can do 

![image](https://user-images.githubusercontent.com/85007096/124066892-12f52e00-da57-11eb-9d22-ed7def0b5f9d.png)

![image](https://user-images.githubusercontent.com/85007096/125106739-9d93f800-e0fd-11eb-8494-d62afef09d8b.png)

![image](https://user-images.githubusercontent.com/85007096/124066900-1688b500-da57-11eb-9e8e-dfc756416e5a.png)

![image](https://user-images.githubusercontent.com/85007096/124073811-29ec4e00-da60-11eb-820d-3bd55df8c65d.png)

# References 
- Presentation by Dr Donald Ingber (a pioneer in the present topic) - https://www.youtube.com/watch?v=w8QZGOIQxXQ, https://www.youtube.com/watch?v=YdvE-sawpXs&t=416s
- Scarr, G., 2014, Biotensegrity: The Structural Basis of Life, Handspring Publishing, Scotland. http://www.tensegrityinbiology.co.uk/ 
