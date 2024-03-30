# ParaGA: Parameterised Genetic Algorithm IP Core

This repository contains the codebase for our IJE 2008 paper "A parameterised genetic algorithm IP core: FPGA design, implementation and performance evaluation" and ICINCO 2007 paper "A parameterised genetic algorithm IP core design and implementation".

## Abstract
>Genetic algorithm (GA) is a directed random search technique working on a population of solutions and is based on natural selection. However, its convergence to the optimum may be very slow for complex optimization problems, especially when the GA is software-implemented, making it difficult to be used in real-time applications. In this article, a parameterised GA intellectual property core is designed and implemented on hardware, achieving impressive time-speedups when compared to its software version. The parameterisation stands for the number of population individuals and their bit resolution, the bit resolution of each individual’s fitness, the number of elite genes in each generation, the crossover and mutation methods, the maximum number of generations, the mutation probability and its bit resolution. The proposed architecture is implemented in a field programmable gate array (FPGA) chip with the use of a very high-speed integrated-circuits hardware description language (VHDL) and advanced synthesis and place and route tools. The GA discussed in this work achieves a clock frequency of 92 MHz and is evaluated using the 'travelling salesman problem' as well as several benchmarking functions.

## Citation

Please cite our works in your publications if they help your research or if you use our code, models or data in your work:

```bibtex
@article{deliparaschos_parameterised_2008,
	title = {A parameterised genetic algorithm {IP} - core: {FPGA} - design, implementation and performance evaluation},
	volume = {95},
	issn = {0020-7217},
	doi = {10.1080/00207210802387494},
	pages = {1149},
	number = {11},
	journaltitle = {International Journal of Electronics},
	author = {Deliparaschos, K. M. and Doyamis, G. C. and Tzafestas, S. G.},
	date = {2008}
}

@inproceedings{deliparaschos_parameterized_2007,
	location = {Angers, France},
	title = {A parameterized genetic algorithm {IP} core design and implementation},
	isbn = {978-972-8865-82-5},
	eventtitle = {Int. Conf. on Informatics in Control, Automation and Robot ({ICINCO}'07)},
	pages = {417--423},
	booktitle = {Int. Conf. on Informatics in Control, Automation and Robot ({ICINCO}'07)},
	author = {Deliparaschos, K. M. and Doyamis, G. C. and Tzafestas, S. G.},
	date = {2007-05-09},
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.