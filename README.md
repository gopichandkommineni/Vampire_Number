# This is a Class Project for COP5615

Gopichand Kommineni         UFID 0305-5523
Hemanth Kumar Malyala       UFID 6348-5914
We implemented 

# Vampire Number

A vampire number is a composite natural number with an even number of digits, that can be factored into two natural numbers each with half as many digits as the original number and not both with trailing zeroes, where the two factors contain precisely all the digits of the original number, in any order, counting multiplicity.  A classic example is: 1260= 21 x 60.
A vampire number can have multiple distinct pairs of fangs. A vampire numbers with 2 pairs of fangs is: 125460 = 204 × 615 = 246 × 510.
The goal of this first project is to use Elixir and the actor model to build a good solution to this problem that runs well on multi-core machines.


1. The number of worker actors:

2. result of mix run proj.ex 100000 200000
102510 201 510
104260 260 401
105210 210 501
105264 204 516
105750 150 705
108135 135 801
110758 158 701
115672 152 761
116725 161 725
117067 167 701
118440 141 840
120600 201 600
123354 231 534
124483 281 443
125248 152 824
125433 231 543
125460 204 615 246 510
125500 251 500
126027 201 627
126846 261 486
129640 140 926
129775 179 725
131242 311 422
132430 323 410
133245 315 423
134725 317 425
135828 231 588
135837 351 387
136525 215 635
136948 146 938
140350 350 401
145314 351 414
146137 317 461
146952 156 942
150300 300 501
152608 251 608
152685 261 585
153436 356 431
156240 240 651
156289 269 581
156915 165 951
162976 176 926
163944 396 414
172822 221 782


3. Biggest Vampire Number 10000000

4. Time
   real	0m0.243s
   user	0m0.485s
   sys	0m0.093s
